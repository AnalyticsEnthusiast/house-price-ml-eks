## The Makefile includes instructions on environment setup and lint tests
# Create and activate a virtual environment
# Install dependencies in requirements.txt
# Dockerfile should pass hadolint
# app.py should pass pylint
# (Optional) Build a simple integration test

setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb

lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	pylint --disable=R,C,W1203,W1202 app.py

init:
	# Sets up Elastic Kubernetes Cluster with Namespace and initial Deployment
	# Should be run locally, step is not part of any automation
	eksctl create cluster -f cluster_config/eks-cluster.yml --profile UdacityAdmin
	kubectl apply -f deployment/ml-namespace.yml
	LABEL_VERSION=$(./get_latest_tag.sh)
	LEN=${#LABEL_VERSION}
	LABEL_VERSION=${LABEL_VERSION:1:${LEN}}
	export GREEN=""
	export LABEL_VERSION=${LABEL_VERSION/./-}
	# Deploy initial Deployment and service
	envsubst < deployment/ml-deployment.yml | kubectl apply -f -
	envsubst < deployment/ml-service.ml | kubectl apply -f -

all: install lint test
