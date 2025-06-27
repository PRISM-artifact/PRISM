import argparse
import numpy as np
import joblib

from tabulate import tabulate

from config import *
from utils import *
from learn import *

def eval_rf(model, testing_set, feature_type, threshold):
	if feature_type == "syn":
		if threshold == 70:
			threshold = 0.715
		elif threshold == 80:	
			threshold = 0.78
		elif threshold == 90:
			threshold = 0.84
	elif feature_type == "sem":
		if threshold == 70:
			threshold = 0.65
		elif threshold == 80:	
			threshold = 0.735
		elif threshold == 90:
			threshold = 0.815
	elif feature_type == "synsem":
		if threshold == 70:
			threshold = 0.685
		elif threshold == 80:	
			threshold = 0.765
		elif threshold == 90:
			threshold = 0.85
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
	thresholds = [70, 80, 90]
	feature_types = ["syn", "sem", "synsem"]

	result_table = {}
	for threshold in thresholds:
		for feature_type in feature_types:
			total_rf_TP = total_rf_TN = total_rf_FP = total_rf_FN = 0
			total_prism_TP = total_prism_TN = total_prism_FP = total_prism_FN = 0
			for project in ["Chart", "Closure", "Lang", "Math", "Time", "Mockito"]:
				df = pd.read_csv(CSV_DIR / f"training_{feature_type}.csv", encoding='latin1', index_col=False)
				testing_df = df[df["id"].astype(str).str.contains(project)].copy()

				# RF
				rf_model = joblib.load(RESOURECES_DIR / f"rq3/rf/rf_{feature_type}_{project}.pkl")
				result_rf = eval_rf(rf_model, testing_df, feature_type, threshold)
				total_rf_TP += ((result_rf["label"] == 1) & (result_rf["pred"] == 1)).sum()
				total_rf_FN += ((result_rf["label"] == 1) & (result_rf["pred"] == 0)).sum()

				# PRISM
				prism_model = joblib.load(RESOURECES_DIR / f"rq3/formula/{threshold}/formula_{feature_type}_{project}.pkl")
				result_prism = eval_prism(prism_model, testing_df)
				total_prism_TP += ((result_prism["label"] == 1) & (result_prism["pred"] == 1)).sum()
				total_prism_FN += ((result_prism["label"] == 1) & (result_prism["pred"] == 0)).sum()

			# Compute IDR
			rf_idr_ratio = total_rf_TP / (total_rf_TP + total_rf_FN) if (total_rf_TP + total_rf_FN) > 0 else 0
			prism_idr_ratio = total_prism_TP / (total_prism_TP + total_prism_FN) if (total_prism_TP + total_prism_FN) > 0 else 0

			result_table[(feature_type, threshold)] = (
					total_rf_TP, rf_idr_ratio, total_prism_TP, prism_idr_ratio
			)

	# Table Construction
	headers = ["Feature Type"]
	for t in thresholds:
			headers += [f"RF@{t}%", f"PRISM@{t}%"]

	# Body rows
	rows = []
	for feature_type in feature_types:
			row = [feature_type.capitalize() if feature_type != "synsem" else "Syn+Sem"]
			for t in thresholds:
					rf_tp, rf_idr, prism_tp, prism_idr = result_table[(feature_type, t)]
					row.append(f"{rf_tp} ({int(rf_idr * 100)}%)")
					row.append(f"{prism_tp} ({int(prism_idr * 100)}%)")
			rows.append(row)


	print(tabulate(rows, headers=headers, tablefmt="github"))
