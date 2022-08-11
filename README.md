[![AnalyticsEnthusiast](https://circleci.com/gh/AnalyticsEnthusiast/house-price-ml-eks.svg?style=svg)](https://circleci.com/gh/AnalyticsEnthusiast/house-price-ml-eks)

## Deploying a machine learning API in EKS on AWS


### Introduction

<p>This project involves the operationalization of a House price prediction API. It uses a sklearn model to predict house prices in Boston according to several features, such as average rooms in a home, highway access and teacher-to-pupil ratios etc. 
The application has been designed to run in a kubernetes environment to take advantage of auto scaling using replica sets and achieving high availability of the application. Elastic kubernetes service (EKS) on AWS was selected as the platform on which to run to reduce the costs and admin overhead associated with a self hosted Kubernetes cluster.</p>

<p>A blue/green deployment strategy was used to ensure that end users experience no downtime during new releases. Build pipelines are run on circleci to minimise administration overhead associated with managing self hosted build servers such as Jenkins. Additional documentation on architecture and design can be found in the sections below.</p>

![High Level Architecture](./images/HousePriceML_EKS.png)


<br>

### Project files


| Filename                          | Description                                           | 
|-----------------------------------|-------------------------------------------------------|
| .circleci/                        | Circle CI directory containing job workflow pipeline  |
| cluster_config/eks-cluster.yml    | yaml file cluster details for eksctl                  |     
| deployment/ml-deployment.yml      | yaml file with kubernetes deployment details          |
| deployment/ml-service.yml         | yaml file with kubernetes service details             |
| deployment/ml-namespace.yml       | yaml file with namespace details                      |
| docs/                             | Extra documentation stored here                       |
| images/                           | Images used in documentation stored here              |
| model_data/                       | Binary file/data for trained housing ML model         |
| screenshots/                      | Project screenshots                                   |
| testing/make_prediction.sh        | Contains script for testing ML api endpoint           |
| .gitignore                        | Files to ignore for git                               |
| app.py                            | Main Flask API application                            |
| Dockerfile                        | Dockerfile of API                                     |
| get_latest_tag.sh                 | Script for getting latest tag from Dockerhub          |
| Makefile                          | makefile with bootstrap commands for lint and test    |
| README.md                         | README file for the project                           |
| requirements.txt                  | Python package Dependencies required to run the API   |

<br>

### Project Setup

<p>To get started with this project an EKS cluster must be created in AWS with an initial deployment. For this project "eksctl" will be used to create the cluster, then "kubectl" will be used to create the application namespace and initial deployment/service. As a prerequisite, you must have an IAM with necessary permissions to create an EKS cluster in AWS. I have created a EKSAdmin profile with the required permissions. Assuming you have cloned this repository, run the following commands.</p>

<br>

Spin up an eks cluster by running eksctl from the root directory. (This command can take about 15min to complete!)

```
> eksctl create cluster -f cluster_config/eks-cluster.yml --profile EKSAdmin
```
<br>

Create the application namespace using kubectl to provide a logical grouping.

```
> kubectl apply -f deployment/ml-namespace.yml
```

<br>

Deploy application to EKS (envsubst is used to substitute parameters into config).

```
> envsubst < deployment/ml-deployment.yml | kubectl apply -f -
```

<br>

Deploy service to EKS (This will act as the load balancer for the application).

```
> envsubst < deployment/ml-service.yml | kubectl apply -f -
```

<br>

The load balancer will generate an endpoint like so "xxxxxxxxxxxxxxxxxxx-891722211.us-east-1.elb.amazonaws.com". Visiting your endpoint over HTTP you should see something like below.

![Working Application](/screenshots/screenshot_blue_deployment.png)



### Index

1. [Architecture](./docs/architecture.md)

2. [CI/CD Pipeline](./docs/circleci.md)

