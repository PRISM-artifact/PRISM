import argparse
import numpy as np
import joblib

from sklearn.utils import shuffle
from sklearn.ensemble import RandomForestClassifier

from multiprocessing import Pool

from config import *
from utils import *
from learn import *

OUT_DIR = Path("../rq3_results")

def learn_rf(project, feature_type):
	model_path = RESOURECES_DIR / "rf" / f"rf_{feature_type}_{project}.pkl"
	if model_path.is_file():
		model = joblib.load(model_path)
		return model
	df = pd.read_csv(OUT_DIR / f"{feature_type}.csv", encoding='latin1',index_col=False)
	training_df = df[~df["id"].astype(str).str.contains(project)].copy()
	X_train = training_df.iloc[:,2:]
	Y_train = training_df.iloc[:,1]
	X_train, Y_train = shuffle(X_train, Y_train, random_state=0)
	model = RandomForestClassifier(random_state=42)
	model.fit(X_train, Y_train)
	joblib.dump(model, model_path)
	return model

def eval_rf(model, testing_set, threshold=0.5):
	prob = model.predict_proba(testing_set.iloc[:, 2:])[:, 1]
	pred = (prob >= threshold).astype(int)
	result_df = testing_set[["id", "label"]].copy()
	result_df["pred"] = pred
	return result_df

def evaluate_formula_on_dataset(formula: Formula, testing_df: pd.DataFrame) -> pd.DataFrame:
	result_data = []
	for _, row in testing_df.iterrows():
		patch_id = row["id"]
		label = row["label"]
		feature_row = row.drop(["id", "label"])
		pred = 0
		if formula:
			pred = formula.eval_patch(feature_row) 
		result_data.append([patch_id, label, 0 if pred else 1])

	result_df = pd.DataFrame(result_data, columns=["id", "label", "pred"])
	return result_df

def eval_prism(model, testing_set):	
	testing_set = process_features(testing_set)
	result_df = evaluate_formula_on_dataset(model, testing_set)
	return result_df
	
if __name__ == '__main__':    
	parser = argparse.ArgumentParser()
	parser.add_argument("--feature", type=str, choices=["syn", "sem", "synsem"], required=True, help="training csv file")
	parser.add_argument("--mode", type=str, choices=["rf", "prism"], default="run")
	args = parser.parse_args()
	
	#pipeline for one benchmark
	projects = ["Chart", "Closure", "Lang", "Math", "Time", "Mockito"]
	outfile = OUT_DIR / f"total_{args.feature}_{args.mode}.csv"
	feature_type = args.feature
	all_results = []
	for threshold in np.arange(0.70, 1.00, 0.01):
		total_df = pd.DataFrame()
		is_checked = False
		for project in projects:
			df = pd.read_csv(CSV_DIR / f"training_{feature_type}.csv", encoding='latin1',index_col=False)
			testing_df = df[df["id"].astype(str).str.contains(project)].copy()
			if args.mode == "rf":
				model = learn_rf(project, feature_type)
				result_df = eval_rf(model, testing_df, threshold)
			elif args.mode == "prism":
				model_path = PRISM_MODEL_DIR / f"formula/{threshold:.2f}" / f"formula_{feature_type}_{project}.pkl"
				if not model_path.is_file():
					print(f"{WARNING} not found {model_path}")
					break
				model = joblib.load(model_path)
				is_checked = True
				result_df = eval_prism(model, testing_df)

			total_df = pd.concat([total_df, result_df], ignore_index=True)

		if not is_checked:
			continue
		TP = ((total_df["label"] == 1) & (total_df["pred"] == 1)).sum()
		FN = ((total_df["label"] == 1) & (total_df["pred"] == 0)).sum()
		TN = ((total_df["label"] == 0) & (total_df["pred"] == 0)).sum()
		FP = ((total_df["label"] == 0) & (total_df["pred"] == 1)).sum()

		cpr = TN / (TN + FP) if (TN + FP) > 0 else 0
		idr = TP / (TP + FN) if (TP + FN) > 0 else 0

		print(f"{threshold},{TN}({cpr}),{TP}({idr})")
		all_results.append(f"{threshold},{TN}({cpr}),{TP}({idr})")

	with open(outfile, "w") as f:
		f.write("\n".join(all_results))
	
