import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from matplotlib.legend_handler import HandlerTuple
from statsmodels.nonparametric.smoothers_lowess import lowess
from multiprocessing import Pool

from config import *
from utils import *
from classify import *
from learn import *


OUT_DIR = Path("../rq2_results")
def plot_cpr_vs_idr():
	apcc_list = ["Random", "PatchSim", "ODS", "Shibboleth", "PRISM"]
	colors = ["black", "red", "blue", "green", "purple"]  
	markers = [".", "s", "v", "^", "*"]  
	
	plt.figure(figsize=(7, 7))
	plt.grid(True, zorder=0)

	scatter_handles = []
	scatter_labels = []

	for apcc, color, marker in zip(apcc_list, colors, markers):
		summary_file = OUT_DIR / f"summary_{apcc.lower()}.csv"
		if not summary_file.exists():
			print(f"{WARNING}: {summary_file} not found, skipping...")
			continue

		df = pd.read_csv(summary_file)
		scatter_size = 80 if apcc == "PRISM" else 25  

		scatter = plt.scatter(
			df["CPR"], df["IDR"], label=apcc, color=color, marker=marker,
			s=scatter_size, edgecolor=color, linewidths=0, zorder=2
		)
		
		scatter_handles.append(scatter)
		scatter_labels.append(apcc)

		if len(df) > 1:
			lowess_curve = lowess(df["IDR"], df["CPR"], frac=0.5)
			plt.plot(lowess_curve[:, 0], lowess_curve[:, 1], color=color, linestyle="dashed", linewidth=1.5)
	
	plt.xlabel("Correct Patch Preserving Ratio (CPR)", fontsize=12)
	plt.ylabel("Incorrect Patch Detection Ratio (IDR)", fontsize=12)
	plt.xticks(np.arange(0, 1.1, 0.1), fontsize=12)
	plt.yticks(np.arange(0, 1.1, 0.1), fontsize=12)

	plt.legend(
		handles=scatter_handles,
		labels=scatter_labels,
		fontsize=12,
		markerscale=1.3,  
		handlelength=2,  
		handletextpad=0.8  
	)
	output_plot = OUT_DIR / "plot.png"
	plt.savefig(output_plot, dpi=300)
	plt.show()

	print(f"{PROGRESS}: Graph saved as {output_plot}")

def load_patchsim_result(project, bug_id, patch_id, threshold):
	target_dir = RESULTS_DIR / f"{project}{bug_id}b/{patch_id}/patchsim/classify"
	target_file = target_dir / f"result_{threshold}.txt"
	if target_file.is_file():
		with open(target_file, "r") as f:
			return 1 if "Incorrect" in f.read() else 0 
	print(f"{WARNING}: {target_file} not found")
	return 0

def process_patchsim_task(args):
	project, bugid, patchid, label, threshold = args
	pred = load_patchsim_result(project, bugid, patchid, threshold)
	print(f"{PROGRESS}: result {patchid}({threshold}) : {pred}")
	return [f"{project}-{bugid}-{patchid}", label, pred] 

def process_random_task(project, threshold):
	df = pd.read_csv(CSV_DIR / f"training_syn.csv", encoding='latin1',index_col=False)
	testing_df = df[df["id"].astype(str).str.contains(project)].copy()
	id_label_df = testing_df[["id", "label"]].copy()
	prob = [random.random() for _ in range(len(testing_df))]
	pred = [1 if p >= threshold else 0 for p in prob]
	
	result_df = id_label_df.copy()
	result_df["pred"] = pred

	return result_df

def process_ods_task(project, threshold):
	model_path = MODELS_DIR / f"model_ods_{project}.pkl"
	model = joblib.load(model_path)
	model_features = model.get_booster().feature_names
	
	df = pd.read_csv(CSV_DIR / f"training_syn.csv", encoding='latin1',index_col=False)
	testing_df = df[df["id"].astype(str).str.contains(project)].copy()
	id_label_df = testing_df[["id", "label"]].copy()
	testing_df = testing_df.reindex(columns=model_features, fill_value=0)
	prob = model.predict_proba(testing_df)[:, 1]
	pred = (prob >= threshold).astype(int)
	
	result_df = id_label_df.copy()
	result_df["pred"] = pred

	return result_df

def process_shibboleth_task(project, threshold):
	model_path = MODELS_DIR / f"model_shibboleth_{project}.pkl"
	model = joblib.load(model_path)
	model_features = ["ts", "scs", "bc"]
	scaler_path = MODELS_DIR / f"scaler_shibboleth_{project}.pkl"
	scaler = joblib.load(scaler_path)
	
	df = pd.read_csv(CSV_DIR / f"training_shibboleth.csv", encoding='latin1',index_col=False)
	testing_df = df[df["id"].astype(str).str.contains(project)].copy()
	id_label_df = testing_df[["id", "label"]].copy()
	
	testing_df = testing_df.reindex(columns=model_features, fill_value=0)
	testing_df = scaler.transform(testing_df)
	prob = model.predict_proba(testing_df)[:, 1]
	pred = (prob >= threshold).astype(int)
	
	result_df = id_label_df.copy()
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

def process_prism_task(project, threshold):
	model_path = RESOURECES_DIR / f"formula/{threshold:.2f}" / f"formula_sem_{project}.pkl"
	model = joblib.load(model_path)
	df = pd.read_csv(CSV_DIR / f"training_sem.csv", encoding='latin1',index_col=False)
	testing_df = df[df["id"].astype(str).str.contains(project)].copy()
	testing_df = process_features(testing_df)
	result_df = evaluate_formula_on_dataset(model, testing_df)
	return result_df

def evaluate_results(apcc):
	results = []
	target_dir = OUT_DIR / apcc
	summary_file = OUT_DIR / f"summary_{apcc}.csv"
	for i in range(1, 101):
		threshold = i * 0.01
		result_file = target_dir / f"{threshold:.2f}.csv"

		df = pd.read_csv(result_file)

		# True Negative (Correctly classified patches)
		correct_ids = df[df["label"] == 0]["id"].tolist()
		incorrect_ids = df[df["label"] == 1]["id"].tolist()

		# Predicted sets
		correct_pred = df[(df["label"] == 0) & (df["pred"] == 0)]["id"].tolist()
		incorrect_pred = df[(df["label"] == 1) & (df["pred"] == 1)]["id"].tolist()

		# Compute CPR (True Negative Rate) and IDR (True Positive Rate)
		cpr = len(correct_pred) / len(correct_ids) if correct_ids else 0.0
		idr = len(incorrect_pred) / len(incorrect_ids) if incorrect_ids else 0.0

		results.append([threshold, cpr, idr])
		
	summary_df = pd.DataFrame(results, columns=["threshold", "CPR", "IDR"])
	summary_df.to_csv(summary_file, index=False)
	print(f"{PROGRESS}: Summary results saved to {summary_file}")

				
if __name__ == '__main__':
	# run each APCC with different threshold
	tasks = []
	with open(TRAINING_DIR / "dataset.csv", "r") as f:
		reader = csv.reader(f)
		next(reader)  
		for row in reader:
			task = {
				"project": row[0],
				"bugid": row[1],
				"patchid": row[2],
				"label": row[3]
			}
			tasks.append(task)
	projects = ["Chart", "Closure", "Lang", "Math", "Time", "Mockito"]
	apcc_list = ["patchsim", "random", "ods", "shibboleth", "prism"]

	for apcc in apcc_list:
		for i in range(1, 101):
			threshold = i / 100
			out_dir = OUT_DIR / apcc
			out_dir.mkdir(parents=True, exist_ok=True)
			out_file = out_dir / f"{threshold:.2f}.csv"
			if out_file.exists():
				print(f"{SUCCESS}: classication under {threshold} with {apcc} already done")
				continue

			if apcc == "patchsim":
				task_args = [(task["project"], task["bugid"], task["patchid"], task["label"], threshold) for task in tasks]
				with Pool(processes=32) as pool:
					results_list = pool.map(process_patchsim_task, task_args)
				with open(out_file, "w", newline="") as f:
					writer = csv.writer(f)
					writer.writerow(["id", "label", "pred"])
					writer.writerows(results_list)

			else:
				total_df = pd.DataFrame()
				print(f"{PROGRESS} run {apcc} with {threshold}...")
				for project in projects:
					if apcc == "random":
						result_df = process_random_task(project, threshold)
					elif apcc == "ods":
						result_df = process_ods_task(project, threshold)
					elif apcc == "shibboleth":
						result_df = process_shibboleth_task(project, threshold)
					elif apcc == "prism":
						result_df = process_prism_task(project, threshold)
					else:
						raise ValueError(f"Unsupported APCC: {apcc}")
					total_df = pd.concat([total_df, result_df], ignore_index=True)
				total_df.to_csv(out_file, index=False)
		
		print(f"{PROGRESS}: Running evaluation for {apcc}...")
		evaluate_results(apcc)
	
	print(f"{PROGRESS}: Generating CPR vs IDR plot...")
	plot_cpr_vs_idr()
