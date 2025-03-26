import argparse
import matplotlib.pyplot as plt
import numpy as np
import seaborn as sns
from statsmodels.nonparametric.smoothers_lowess import lowess

from multiprocessing import Pool

from config import *
from utils import *
from classify import *
from learn import *

OUT_DIR = Path("./rq2_results")

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.legend_handler import HandlerTuple
from statsmodels.nonparametric.smoothers_lowess import lowess

def plot_cpr_vs_idr():
    apcc_list = ["Random", "PatchSim", "ODS", "Shibboleth", "PRISM"]
    colors = ["black", "red", "blue", "green", "purple"]  # 색상 유지
    markers = [".", "s", "v", "^", "*"]  # random: 점, ods: 아래쪽 삼각형, 나머지 유지
    
    plt.figure(figsize=(7, 7))
    plt.grid(True, zorder=0)

    scatter_handles = []  # 범례에서 마커 크기 조정을 위한 핸들 저장 리스트
    scatter_labels = []  # 범례용 라벨 저장

    for apcc, color, marker in zip(apcc_list, colors, markers):
        summary_file = OUT_DIR / f"summary_{apcc.lower()}.csv"

        if not summary_file.exists():
            print(f"{WARNING}: {summary_file} not found, skipping...")
            continue

        df = pd.read_csv(summary_file)

        # Prism은 더 크고, 다른 것들은 작게 설정
        scatter_size = 80 if apcc == "PRISM" else 25  # Prism만 크게
        scatter_alpha = 0.6 if apcc == "PRISM" else 0.4  # Prism은 덜 투명하게, 나머지는 더 투명하게

        # **Scatter plot (테두리 더 선명하게 설정)**
        scatter = plt.scatter(
            df["CPR"], df["IDR"], label=apcc, color=color, marker=marker,
            s=scatter_size, edgecolor=color, linewidths=0, zorder=2
        )
        
        # 범례용 핸들 저장 (마커 크기 키우기 위해 사용)
        scatter_handles.append(scatter)
        scatter_labels.append(apcc)

        # 동일한 LOWESS 추세선
        if len(df) > 1:
            lowess_curve = lowess(df["IDR"], df["CPR"], frac=0.5)
            plt.plot(lowess_curve[:, 0], lowess_curve[:, 1], color=color, linestyle="dashed", linewidth=1.5)
    
    # **X, Y 축 라벨 크기 키우기**
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
        handletextpad=0.8  # 마커와 텍스트 사이 간격 조정
    )
    # 그래프 저장
    output_plot = OUT_DIR / "cpr_idr_comparison.png"
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
	df = pd.read_csv(CSV_DIR / f"training_ods.csv", encoding='latin1',index_col=False)
	testing_df = df[df["id"].astype(str).str.contains(project)].copy()
	id_label_df = testing_df[["id", "label"]].copy()
	prob = [random.random() for _ in range(len(testing_df))]
	pred = [1 if p >= threshold else 0 for p in prob]
	
	result_df = id_label_df.copy()
	result_df["pred"] = pred

	return result_df

def process_ods_task(project, threshold):
	model_path = MODELS_DIR / f"model_ods_{project}.pkl"
	if not model_path.is_file():
		print(f"{PROGRESS} Train ODS with {project}")
		training_df = pd.read_csv(CSV_DIR / f"training_ods.csv", encoding='latin1',index_col=False)
		training_df = training_df[~training_df["id"].astype(str).str.contains(project)]
		numerical_features = training_df.select_dtypes(include=np.number).columns.tolist()
		outliers_to_drop = detect_outliers(training_df, 15, numerical_features)
		print(f"Removing {len(outliers_to_drop)} outliers...")

		# 이상치 제거 후 데이터 재구성
		training_df = training_df.drop(index=outliers_to_drop).reset_index(drop=True)
	
		X_train = training_df.iloc[:,2:]
		Y_train = training_df.iloc[:,1]
		X_train, Y_train = shuffle(X_train, Y_train, random_state=0)
		X_train, X_val, Y_train, Y_val = train_test_split(X_train, Y_train, test_size=0.2, random_state=42)

		smote = SMOTE(random_state=42, sampling_strategy="minority")
		X_train, Y_train = smote.fit_resample(X_train, Y_train)

		model = xgb.XGBClassifier(
			random_state=42, 
		 	max_depth=6, 
			gamma=0.5, 
			early_stopping_rounds=30, 
			eval_metric="mae", 
			enable_categorical=True
		)
		eval_set=[(X_val, Y_val)]
		model.fit(X_train, Y_train, eval_set=eval_set)
		joblib.dump(model, model_path)

	model = joblib.load(model_path)
	model_features = model.get_booster().feature_names
	
	df = pd.read_csv(CSV_DIR / f"training_ods.csv", encoding='latin1',index_col=False)
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
			pred = formula.eval_patch(feature_row)  # Boolean 값 반환
		result_data.append([patch_id, label, 0 if pred else 1])  # pred를 0/1로 변환

	# DataFrame 생성
	result_df = pd.DataFrame(result_data, columns=["id", "label", "pred"])
	return result_df

def process_prism_task(project, threshold):
	model_path = RESOURECES_DIR / f"formula_180/{threshold:.2f}" / f"formula_prism_{project}.pkl"
	model = joblib.load(model_path)
	df = pd.read_csv(CSV_DIR / f"training_prism.csv", encoding='latin1',index_col=False)
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
		
	# 결과 저장
	summary_df = pd.DataFrame(results, columns=["threshold", "CPR", "IDR"])
	summary_df.to_csv(summary_file, index=False)
	print(f"{PROGRESS}: Summary results saved to {summary_file}")

				
if __name__ == '__main__':    
	parser = argparse.ArgumentParser()
	parser.add_argument("--apcc", type=str, choices=["random", "patchsim", "ods", "shibboleth", "prism"], help="Target instance for classifying", default="all")
	parser.add_argument("--mode", type=str, choices=["run", "eval", "plot"], default="run")
	args = parser.parse_args()
	
	apcc = args.apcc
	results_all = []
	#pipeline for one benchmark
	if args.mode == "run":
		tasks = []
		with open(OUT_DIR / "dataset.csv", "r") as f:
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
		# for i in [20, 30, 40, 50]:
		for i in range(1, 101):
			threshold = i / 100
			out_dir = OUT_DIR / apcc
			out_dir.mkdir(parents=True, exist_ok=True)
			out_file = out_dir / f"{threshold:.2f}.csv"
			if apcc == "patchsim":
				results_merged = []
				c_cnt, i_cnt, c_hit, i_hit = 0, 0, 0, 0
				task_args = [(task["project"], task["bugid"], task["patchid"], task["label"], threshold) for task in tasks]
				with Pool(processes=32) as pool:
					results_list = pool.map(process_patchsim_task, task_args)
				for result in results_list:
					results_merged.append(result)

				with open(out_file, "w", newline="") as f:
					writer = csv.writer(f)
					writer.writerow(["id", "label", "pred"])
					writer.writerows(results_merged)
			elif apcc == "random":
				total_df = pd.DataFrame()
				print(f"{PROGRESS} run random with {threshold}...")
				for project in projects:
					result_df = process_random_task(project, threshold)
					total_df = pd.concat([total_df, result_df], ignore_index=True)
				total_df.to_csv(out_file, index=False)
			elif apcc == "ods":
				total_df = pd.DataFrame()
				print(f"{PROGRESS} run ods with {threshold}...")
				for project in projects:
					result_df = process_ods_task(project, threshold)
					total_df = pd.concat([total_df, result_df], ignore_index=True)
				
				total_df.to_csv(out_file, index=False)
			elif apcc == "shibboleth":
				total_df = pd.DataFrame()
				print(f"{PROGRESS} run shibboleth with {threshold}...")
				for project in projects:
					result_df = process_shibboleth_task(project, threshold)
					total_df = pd.concat([total_df, result_df], ignore_index=True)
				total_df.to_csv(out_file, index=False)
			elif apcc == "prism":
				total_df = pd.DataFrame()
				print(f"{PROGRESS} run prism with {threshold}...")
				for project in projects:
					result_df = process_prism_task(project, threshold)
					total_df = pd.concat([total_df, result_df], ignore_index=True)
				total_df.to_csv(out_file, index=False)
	elif args.mode == "eval":
		print(f"{PROGRESS}: Running evaluation for {apcc}...")
		evaluate_results(apcc)
	elif args.mode == "plot":
		print(f"{PROGRESS}: Generating CPR vs IDR plot...")
		plot_cpr_vs_idr()
