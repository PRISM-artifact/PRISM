import argparse
import shutil
import json
import subprocess
import csv
import traceback

import joblib
import pandas as pd
import xgboost as xgb
import random

from sklearn.utils import shuffle
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.ensemble import RandomForestClassifier
from imblearn.over_sampling import SMOTE

from config import *
from utils import *
from bug import Bug
from patch import Patch

from patchsim import PatchSim
from ods import FeatureExtractor
from shibboleth import Shibboleth
from prism import PrismTarget
from learn import Formula, process_features

class Classifier():
	def	__init__(self, patch: Patch):
		self.target_project = patch.bug.project
		self.label = 1 if patch.check_correctness() == "Incorrect" else 0
  
	# Random classifyier
	def classify(self):
		return random.choice([0,1])
  
	def classify_with_threshold(self, threshold=0.5):
		return 1 if random.random() < threshold else 0


class PatchSimClassifier(Classifier):
	def	__init__(self, patch: Patch):
		super().__init__(patch)
		self.target = PatchSim(patch)
		assert self.target.result_file.is_file(), f""
	
	def classify(self):
		with open(self.target.result_file, "r") as f:
			result = json.load(f)
		return 1 if result["label"] == "Incorrect" else 0

	def classify_with_threshold(self, threshold=0.5):
		result_file = self.target.classify_dir / f"result_{threshold}.txt"
		if result_file.is_file():
			with open(result_file, "r") as f:
				return 1 if f.readlines()[-1].strip() == "Incorrect" else 0
		print(f"{WARNING}not found {result_file}")
		return 0

class ODSClassifier(Classifier):
	def	__init__(self, patch: Patch):
		super().__init__(patch)
		self.target_vec = FeatureExtractor(patch).run()
		self.training_data = CSV_DIR / f"training_syn.csv"
		assert self.training_data.is_file(), f"{ERROR}: {self.training_data} does not exists"
		self.model_path = MODELS_DIR / f"model_ods_{patch.bug.project}.pkl"
		self.model = self.load_model()
	
	def load_model(self):
		if self.model_path.is_file():
			model = joblib.load(self.model_path)
			return model
		
		print(f"{PROGRESS} Train ODS with {self.target_project}")
		training_df = pd.read_csv(self.training_data, encoding='latin1',index_col=False)
		training_df = training_df[~training_df["id"].astype(str).str.contains(self.target_project)]
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
		joblib.dump(model, self.model_path)
		return model
		
	def classify(self):
		model_features = self.model.get_booster().feature_names
		target_df = pd.DataFrame([self.target_vec])
		target_df = target_df.reindex(columns=model_features, fill_value=0)
		pred = self.model.predict(target_df)
		return pred
		
	def classify_with_threshold(self, threshold=0.5):
		model_features = self.model.get_booster().feature_names
		target_df = pd.DataFrame([self.target_vec])
		target_df = target_df.reindex(columns=model_features, fill_value=0)
		prob = self.model.predict_proba(target_df)[:, 1]
		pred = (prob >= threshold).astype(int)
		return int(pred[0])

class ShibbolethClassifier(Classifier):
	def	__init__(self, patch: Patch):
		super().__init__(patch)
		self.target_vec = Shibboleth(patch).extract_score()
		self.training_data = CSV_DIR / f"training_shibboleth.csv"
		assert self.training_data.is_file(), f"{ERROR}: {self.training_data} does not exists"
		self.model_path = MODELS_DIR / f"model_shibboleth_{patch.bug.project}.pkl"
		self.scaler_path = MODELS_DIR / f"scaler_shibboleth_{patch.bug.project}.pkl"
		self.model, self.scaler = self.load_model()
	
	def load_model(self):
		if self.model_path.is_file() and self.scaler_path.is_file():
			model = joblib.load(self.model_path)
			scaler = joblib.load(self.scaler_path)
			return model, scaler
 
		training_df = pd.read_csv(self.training_data, encoding='latin1',index_col=False)
		training_df = training_df[~training_df["id"].astype(str).str.contains(self.target_project)]
	
		X_train = training_df.iloc[:,2:]
		Y_train = training_df.iloc[:,1]
		X_train, Y_train = shuffle(X_train, Y_train, random_state=0)
	
		scaler = StandardScaler()
		X_train_scaled = scaler.fit_transform(X_train)

		model = RandomForestClassifier(random_state=42)
		model.fit(X_train_scaled, Y_train)
	
		joblib.dump(model, self.model_path)
		joblib.dump(scaler, self.scaler_path)
		return model, scaler

	def classify(self):
		target_df = pd.DataFrame([self.target_vec])
		target_df = target_df.reindex(columns=["ts", "scs", "bc"], fill_value=0)
		target_df = self.scaler.transform(target_df)
		pred = self.model.predict(target_df)
		return pred

	def classify_with_threshold(self, threshold=0.5):
		target_df = pd.DataFrame([self.target_vec])
		target_df = target_df.reindex(columns=["ts", "scs", "bc"], fill_value=0)
		target_df = self.scaler.transform(target_df)
		prob = self.model.predict_proba(target_df)[:, 1]
		pred = (prob >= threshold).astype(int)
		return int(pred[0])
		
class PrismClassifier(Classifier):
	def	__init__(self, patch: Patch):
		super().__init__(patch)
		self.feature_file = PrismTarget(patch).result_dir / "result.json"
		self.model_path = PRISM_MODEL_DIR / "0.90" / f"formula_prism_{patch.bug.project}.pkl"
		assert self.feature_file.is_file(), f"{ERROR}: {self.feature_file} does not exsits"
		assert self.model_path.is_file(), f"{ERROR}: {self.model_path} does not exists"
		self.model = self.load_model()
	
	def load_model(self):
		model = joblib.load(self.model_path)
		return model
 
	def classify(self):
		with open(self.feature_file, "r") as f:
			target_vec = json.load(f)["features"]
		patch_row = process_features(pd.DataFrame([target_vec])).iloc[0]
		return 0 if self.model.eval_patch(patch_row) else 1

def eval_all(patch_file: Path) -> Tuple[bool, bool, bool, bool, bool]:
	project = args.patch.name.split("-")[0]
	bug_id = int(args.patch.name.split("-")[1])
	bug = Bug(project, bug_id, set_ant=False)
	patch = Patch(bug, args.patch)
	
	patchsim = PatchSimClassifier(patch)
	r_patchsim = patchsim.classify() == 0
	ods = ODSClassifier(patch)
	r_ods = ods.classify()[0] == 0
	shib = ShibbolethClassifier(patch)
	r_shib = shib.classify()[0] == 0
	prism = PrismClassifier(patch)
	r_prism = prism.classify() == 0
	return (patch.patch_id, r_patchsim, r_ods, r_shib, r_prism)

if __name__ == '__main__':    
	parser = argparse.ArgumentParser()
	# parser.add_argument("-p", required=True, type=str, choices=["Chart", "Closure", "Lang",  "Math", "Time", "Mockito"], help="Target D4J1.2 project")
	# parser.add_argument("-v", type=int, required=True, help="Corresponding bug id of target project")
	parser.add_argument("--apcc", type=str, choices=["patchsim", "ods", "shibboleth", "prism", "all"], help="Target instance for ranking", default="all")
	parser.add_argument("--patch", type=Path, required=True, help="patch file path")
	args = parser.parse_args()
	project = args.patch.name.split("-")[0]
	bug_id = int(args.patch.name.split("-")[1])
	bug = Bug(project, bug_id, set_ant=False)
	patch = Patch(bug, args.patch)
	
	if args.apcc == "all":
		res = eval_all(args.patch)
		print(res)
	elif args.apcc == "prism":
		print(patch.patch_id)
		prism = PrismClassifier(patch)
		r_prism = prism.classify() == 0
		print(r_prism)
	elif args.apcc == "ods":
		print(patch.patch_id)
		ods = ODSClassifier(patch)
		r = ods.classify() == 0
		print(r)
	#pipeline for one benchmark