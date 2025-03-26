import argparse
import pandas as pd
import time
import multiprocessing
import heapq
import numpy as np
import pickle
import csv
from copy import deepcopy
from config import *
from utils import *
from math import pow

from typing import Set, FrozenSet, Iterable
ClauseType = FrozenSet[str]
FormulaType = FrozenSet[ClauseType]

GLOBAL_CLAUSE_CACHE = {}

def get_global_atoms(training_set):
	feature_columns = set(training_set.columns) - {"id", "label"}
	variable_features = {col for col in feature_columns if training_set[col].nunique() > 1}
	filtered_features = set()
	for col in variable_features:
		formula = Formula(variable_features, [], [col])
		cpr, idr = formula.eval_formula(training_set)
		if not (cpr < 1 and idr == 0) or (cpr == 0):
			filtered_features.add(col)
	return filtered_features

def is_consistent(clause: ClauseType) -> bool:
	for literal in clause:
		if literal.startswith("~"):
			if literal[1:]in clause:
				return False
		else:
			if ("~" + literal) in clause:
				return False
	return True

def is_redundant_formula(formula: FormulaType) -> bool:
	for clause in formula:
		for other in formula:
			if clause != other and clause.issubset(other):
				return True
	return False

def score(cpr, idr, threshold, alpha=0.5, beta=1.0):
		return idr
#   return idr * min(1, cpr / threshold)
#   return alpha * idr + (1 - alpha) * (cpr ** beta)

# def score(cpr, idr, threshold, alpha=0.5, beta=1.0):
#     return idr + max(0, cpr - threshold) * 0.2
	
def get_patch_set_for_clause(clause: ClauseType, df: pd.DataFrame, use_cache=True) -> Set[int]:
	if clause in GLOBAL_CLAUSE_CACHE and use_cache:
		return GLOBAL_CLAUSE_CACHE[clause]
	
	cond = np.ones(len(df), dtype=bool)
	for literal in clause:
		cond = cond & (df[literal].to_numpy() == 1)
	
	pos = np.nonzero(cond)[0]
	patch_set = set(df.index[pos])
	
	if use_cache:
		GLOBAL_CLAUSE_CACHE[clause] = patch_set
	return patch_set

class Formula():
	atoms: Set[str]
	formulas: FormulaType
	
	def __init__(self, atoms: Set[str], 
							 specified: Iterable[Iterable[str]],
							 to_specify: Iterable[str]):
		self.atoms = atoms
		self.specified = frozenset(specified)
		self.to_specify = frozenset(to_specify)
	
	def specify(self) -> Set["Formula"]:
		new_formulas = set()
		for atom in self.atoms:
			if atom not in self.to_specify:
				new_clause = frozenset(self.to_specify | {atom})
				if not is_consistent(new_clause):
					continue
				new_formula = frozenset(self.specified | {new_clause})
				if is_redundant_formula(new_formula):
					continue
				new_formulas.add(Formula(self.atoms, self.specified, new_clause))
		return new_formulas
	
	def generalize(self) -> Set["Formula"]:
		used_atoms = set().union(*self.specified) | set(self.to_specify)
		candidate_atoms = self.atoms - used_atoms
		new_formulas = set()
		for atom in candidate_atoms:
			new_clause = frozenset({atom})
			new_specified = self.specified.union({self.to_specify})
			new_formula = Formula(self.atoms, new_specified, new_clause)
			new_formulas.add(new_formula)
		return new_formulas
	
	def _eval_clause(self, patch_row: pd.Series, clause:ClauseType) -> bool:
		return all(patch_row.get(literal, 0) for literal in clause)

	def eval_patch(self, patch_row: pd.Series) -> bool:
		formula = self.specified.union({self.to_specify})
		matching_clauses = [clause for clause in formula if self._eval_clause(patch_row, clause)]
		patch_features = {col: int(val) for col, val in patch_row.items() if col not in ["id", "label"]}

		# print("\n=== Patch Evaluation ===")
		# print(formula)
		# print("Matching Clauses:")
		# for clause in matching_clauses:
		#   print(f"  {clause}")
		return bool(matching_clauses)


	def eval_formula(self, train_set: pd.DataFrame, use_cache=True) -> Tuple[float, float]:
		correct_ids = set(train_set.index[train_set['label'] == 0])
		incorrect_ids = set(train_set.index[train_set['label'] == 1])
		
		formula = self.specified.union({self.to_specify})
		clause_patch_sets = [get_patch_set_for_clause(clause, train_set, use_cache) for clause in formula]
		satsified = set.union(*clause_patch_sets) if clause_patch_sets else set()
		
		cpr = len(correct_ids & satsified) / len(correct_ids) if correct_ids else 0.0
		idr = (len(incorrect_ids) - len(incorrect_ids & satsified)) / len(incorrect_ids) if incorrect_ids else 0.0
		return cpr, idr

	def eval_formula2(self, train_set: pd.DataFrame, use_cache=True) -> Tuple[int, int]:
		correct_ids = set(train_set.index[train_set['label'] == 0])
		incorrect_ids = set(train_set.index[train_set['label'] == 1])
		
		formula = self.specified.union({self.to_specify})
		clause_patch_sets = [get_patch_set_for_clause(clause, train_set, use_cache) for clause in formula]
		satsified = set.union(*clause_patch_sets) if clause_patch_sets else set()

		return len(correct_ids & satsified), len(incorrect_ids) - len(incorrect_ids & satsified)

	def __str__(self):
		specified_str = "V".join("("+"/\\".join(sorted(clause))+")" for clause in self.specified)
		to_specify_str = "(" + "/\\".join(sorted(self.to_specify)) + ")"
		if specified_str:
			return specified_str + "V" + to_specify_str
		else:
			return to_specify_str
		
	def __eq__(self, other):
		if not isinstance(other, Formula):
			return False
		return (self.specified | {self.to_specify}) == (other.specified | {other.to_specify})

	def __hash__(self):
		return hash(frozenset(self.specified | {self.to_specify}))

	def __lt__(self, other):
		if not isinstance(other, Formula):
			return False
		return hash(self) < hash(other)

	
class PrismDNFTrainer:
	train_set: pd.DataFrame
	threshold: float
	solution: Formula
	works_heap: list
	atoms: Set[str]
	
	def __init__(self, train_set: pd.DataFrame, 
							 threshold: float = 0.9, 
							 init_atom_num: int = 5,
							 generalize_num:int = 5,
							 timeout: float = 60,
							 no_improve_limit: int = 10,
							 batch_size: int = 16):
		self.train_set = train_set
		self.threshold = threshold
		self.timeout = timeout
		self.init_atom_num = init_atom_num
		self.generalize_num = generalize_num
		self.no_improve_limit = no_improve_limit
		self.atoms = get_global_atoms(train_set)
		self.solution = None
		self.best_improvement = float('-inf')
		self.works_heap = []
		self.batch_size = batch_size
		print(f"{INFO} Learn model with {len(self.train_set)} data and {len(self.atoms)} features")  
	
	def add_candidates(self, candidates: Iterable[Tuple[Formula, float, float]], count, num_cands: int = 0):
		if num_cands > 0:
				sorted_candidates = sorted(candidates, key=lambda x: (x[1], x[2]), reverse=True)
				if num_cands > 0:
						sorted_candidates = sorted_candidates[:num_cands]
		else:
				sorted_candidates = candidates
		for candidate, cpr, idr in sorted_candidates:
			# print(f"{candidate} -> CPR: {cpr:.4f}, IDR: {idr:.4f}")
			heapq.heappush(self.works_heap, (count, -score(cpr, idr, threshold), candidate))
	
	def is_improved(self, candidate_cpr: float, candidate_idr: float) -> bool:
		if not self.solution:
			return True
		current_cpr, current_idr = self.solution.eval_formula(self.train_set)
		return candidate_idr > current_idr or (candidate_idr == current_idr and candidate_cpr > current_cpr)
	
	def eval_formulas(self, formula: Formula) -> Tuple[Formula, float, float]:
		return (formula, *formula.eval_formula(self.train_set))
	
	def specify_formulas(self, formula: Formula) -> Set[Formula]:
		return formula.specify()
	
	def generalize_formulas(self, formula: Formula) -> Set[Formula]:
		return formula.generalize()
	
	def train_model(self) -> Formula:
		start_time = time.time()
		no_improve_cnt = 0
		general_count = 0

		pool = multiprocessing.Pool(self.batch_size)
		try:
			# Init work set with promising candidates (high CPR with high IDR)
			initial_candidates = [Formula(self.atoms, [], [literal]) for literal in self.atoms]
			promising = pool.map(self.eval_formulas, initial_candidates)
			self.add_candidates(promising, general_count, self.init_atom_num)
				
			tempt_set = set([])
			remain = []
			general_size = -1
			tempt_size = 0
			
			max_size = 1000
			iter_cnt = 0
			# Training loop
			while time.time() - start_time < self.timeout and self.works_heap:
				maximum = int(max_size * pow(0.75, iter_cnt))
				flag = False
				if len(self.works_heap) > maximum:
					flag = True
				self.works_heap = heapq.nsmallest(maximum, self.works_heap)
				# if general_size >= 0:
				#     if tempt_size > general_size:
				#         self.works_heap = heapq.nsmallest(1500, self.works_heap)
				# 6. ψ ← argmax_{ψ ∈ W} IDR(T, ψ)
				batch_size = min(self.batch_size, len(self.works_heap))
				# batch = [heapq.heappop(self.works_heap) for _ in range(batch_size)]
				# print(heapq.nsmallest(5, self.works_heap))
				# print(f"********** # Remaining Works: {len(self.works_heap)} {maximum} **********")
				if flag:
					iter_cnt += 1
				remain.extend(self.works_heap)
				batch = [work[2] for work in self.works_heap]
				tempt_size += len(batch)

				# 8. W′ ← { ψ′ | ψ′ ∈ SpecifyA(ψ) ∧ CPR(T, ψ′) ≥ threshold }
				candidates = pool.map(self.specify_formulas, batch)  
				candidates = {formula for sublist in candidates for formula in sublist}
				
				# Evaluate new works and add them to workset
				new_candidates = pool.map(self.eval_formulas, candidates)
				W_prime = {candidate for candidate in new_candidates if candidate[1] >= self.threshold}
				# print(f"{PROGRESS} {len(W_prime)} is generated by speicyfing")
				# 9. for each candidate in W′, 평가 후 개선점이 있으면 solution 업데이트
				improved = False
				for candidate, candidate_cpr, candidate_idr in W_prime:
					if self.is_improved(candidate_cpr, candidate_idr) and candidate_cpr >= self.threshold:
						self.solution = candidate
						improved = True
						no_improve_cnt = 0
						# print(f"{INFO}: New best candidate {candidate} -> CPR: {candidate_cpr:.4f}, IDR: {candidate_idr:.4f}: ")
					heapq.heappush(self.works_heap, (general_count, -score(candidate_cpr, candidate_idr, threshold), candidate))
					
				# Generalize formula if no imporvemnt in specific limit    
				if not improved:
					no_improve_cnt += 1
				if no_improve_cnt >= self.no_improve_limit:
					print(f"{INFO} No improvement for {self.no_improve_limit} iteration... generalize!")
					
					general_heap = deepcopy(heapq.nsmallest(self.generalize_num, self.works_heap))
					general_heap = [(r[1], r[2]) for r in general_heap]
					for r in remain:
						if r[2] not in tempt_set:
								tempt_set.add(r[2])
								heapq.heappush(general_heap, (r[1], r[2]))

				#   self.works_heap = []
					general_count -= 1
					remain = []
					top_candidates = [work[1] for work in heapq.nsmallest(self.generalize_num, general_heap)]
					if self.solution is not None:
						top_candidates.append(self.solution)

					generalized_candidates = pool.map(self.generalize_formulas, top_candidates)
					generalized_candidates = {formula for sublist in generalized_candidates for formula in sublist}
					promising = pool.map(self.eval_formulas, generalized_candidates)
					self.add_candidates(promising, general_count)
					
					no_improve_cnt = 0
					self.no_improve_limit *= 1

					iter_cnt = 0
					max_size = 1000
					tempt_size = 0
					general_size = len(self.works_heap)
			
			print(time.time() - start_time)
			return self.solution
		finally:
			pool.close()
			pool.join()
	
def process_features(df):
	features = df.copy()
	feature_cols = [col for col in features.columns if col not in ["id", "label"]]
	features[feature_cols] = features[feature_cols].astype(int)
	neg_features = 1 - features[feature_cols]
	neg_features.columns = ["~" + col for col in neg_features.columns]
	features = pd.concat([features, neg_features], axis=1)

	return features

def analyze_features(train_set: pd.DataFrame):
	print("\n=== Feature Analysis ===")
	feature_cpr_idr = []
	feature_columns = set(train_set.columns) - {"id", "label"}

	for feature in feature_columns:
		formula = Formula(feature_columns, [], {feature})  
		cpr, idr = formula.eval_formula(train_set)

		matching_indices = get_patch_set_for_clause(frozenset({feature}), train_set)
		# Retrieve patch IDs and corresponding labels
		matching_patches = train_set.loc[list(matching_indices), ["id", "label"]]
		matching_patches = matching_patches.sort_values(by="id")  # Sort by patch ID

		# Convert to list of "ID (Label)" format
		formatted_patches = [f"{pid} ({label})" for pid, label in zip(matching_patches["id"], matching_patches["label"])]


		feature_cpr_idr.append((feature, cpr, idr, formatted_patches))

	feature_cpr_idr.sort(key=lambda x: (x[1], x[2]), reverse=True)

	with open("feature_analysis.csv", mode="w", newline="", encoding="utf-8") as file:
		writer = csv.writer(file)
		writer.writerow(["Feature", "CPR", "IDR", "Matching Patch IDs"])  # 헤더 작성
		for feature, cpr, idr, patches in feature_cpr_idr:
				id_list = ", ".join(sorted(patches))  # 패치 ID 정렬 후 문자열 변환
				writer.writerow([feature, f"{cpr:.4f}", f"{idr:.4f}", id_list])

	print(f"{INFO} Feature analysis saved")

if __name__ == "__main__":
		parser = argparse.ArgumentParser()
		parser.add_argument("--train_set", type=Path, default=Path(f"{CSV_DIR}/training_sem.csv"), help="training csv file")
		parser.add_argument("-p", required=True, type=str, choices=["Chart", "Closure", "Lang",  "Math", "Time", "Mockito"], help="Target D4J1.2 project")
		parser.add_argument("--analyze", action="store_true", help="Perform feature analysis")
		parser.add_argument("--timeout", type=int, help="learning timeout", default=180)
		parser.add_argument("--limit", type=int, help="improve limit", default=2)
		parser.add_argument("--core", type=int, help="improve limit", default=16)
		parser.add_argument("--mode", type=str, default="default", choices=["default", "sweep"], help="Select training mode: default or sweep")
		parser.add_argument("--threshold", type=float, default=0.705, help="Threshold for default model training")


		args = parser.parse_args()

		total_correct = 0
		total_incorrect = 0
		total_our_correct = 0
		total_our_incorrect = 0

		tool_name = args.train_set.stem.split("_")[-1]
		target_project = args.p
		
		df = pd.read_csv(args.train_set, encoding='latin1', index_col=False)
		df = df.reset_index(drop=True) # Set integer id for each datafram row
		testing_df = df[df["id"].astype(str).str.contains(target_project)]
		training_df = df[~df["id"].astype(str).str.contains(target_project)]
		
		print("# Correct:", len(df.index[df['label'] == 0]))
		print("# Inorrect:", len(df.index[df['label'] == 1]))
		print("# Testing:", len(testing_df))
		print("# Training:", len(training_df))
		training_features = process_features(training_df)
		testing_features = process_features(testing_df)
		
		if args.analyze:
				analyze_features(training_features)
				exit()
		
		if args.mode == "sweep":
				results = []
				# for i in [20, 30, 40, 50]:
				print("HE")
				for threshold in np.arange(0.70, 1.00, 0.005):
						print("threshold")
						GLOBAL_CLAUSE_CACHE = {}
						out_dir = Path("./rq3_results/formula") / f"{threshold:.3f}"
						out_dir.mkdir(parents=True, exist_ok=True)
						out_file = out_dir / f"formula_{tool_name}_{target_project}.pkl"
						if out_file.is_file():
							continue
						trainer = PrismDNFTrainer(
								train_set=training_features, 
								threshold=threshold, 
								init_atom_num=5,
								generalize_num=5,
								timeout=args.timeout, 
								no_improve_limit=args.limit,
								batch_size=args.core
						)
						print(f"{PROGRESS}: Start learning... {threshold}")
						learned_formula = trainer.train_model()
						print("Learned DNF formula:")
						print(learned_formula)
						
						# out_dir = PRISM_MODEL_DIR / f"{threshold:.2f}"
						with open(out_file, "wb") as f:
								pickle.dump(learned_formula, f)
						

						if learned_formula: 
							cpr, idr = learned_formula.eval_formula(testing_features, use_cache=False)
							c_num, i_num = learned_formula.eval_formula2(testing_features, use_cache=False)
							print(f"Testing set evaluation -> # C: {c_num}({cpr:.4f}), # I: {i_num}({idr:.4f})")
							results.append((threshold, cpr, idr, c_num, i_num))
						
						eval_csv_filename = PRISM_MODEL_DIR / f"eval_sweep_{tool_name}_{target_project}.csv"
						with open(eval_csv_filename, "w", newline="") as csvfile:
								writer = csv.writer(csvfile)
								writer.writerow(["threshold", "cpr", "idr", "#C", "#I"])
								writer.writerows(results)
						print(f"Evaluation results saved to {eval_csv_filename}")
		else:
				print("OK")
				threshold = args.threshold
				GLOBAL_CLAUSE_CACHE = {}
				
				trainer = PrismDNFTrainer(
						train_set=training_features,
						threshold=threshold,
						init_atom_num=5,
						generalize_num=5,
						timeout=args.timeout,
						no_improve_limit=args.limit,
						batch_size=args.core
				)
				print(f"{PROGRESS}: Start learning with threshold {threshold:.3f} ...")
				learned_formula = trainer.train_model()
				print("Learned DNF formula:")
				print(learned_formula)

				# out_dir = PRISM_MODEL_DIR / f"{threshold:.2f}"
				out_dir = Path("./rq3_results/formula") / f"{threshold:.3f}"
				out_dir.mkdir(parents=True, exist_ok=True)
				out_file = out_dir / f"formula_{tool_name}_{target_project}.pkl"
				with open(out_file, "wb") as f:
						pickle.dump(learned_formula, f)
						print(f"Model saved to {out_file}")
				cpr, idr = learned_formula.eval_formula(testing_features, use_cache=False)
				c_num, i_num = learned_formula.eval_formula2(testing_features, use_cache=False)
				print(f"Testing set evaluation -> # C: {c_num} ({cpr:.4f}), # I: {i_num} ({idr:.4f})")

				total_our_correct += c_num
				total_our_incorrect += i_num
				total_correct += len(testing_df.index[testing_df['label'] == 0])
				total_incorrect += len(testing_df.index[testing_df['label'] == 1])
