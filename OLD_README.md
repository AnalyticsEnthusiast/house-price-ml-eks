[![AnalyticsEnthusiast](https://circleci.com/gh/AnalyticsEnthusiast/house-price-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/AnalyticsEnthusiast/house-price-ml-microservice-kubernetes)


## Project Summary


<p>This project involves the operationalization of a House price prediction API developed by our Data science team. The model uses a sklearn model 
that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios etc. 
The application has been designed to run in a kubernetes environment to take advantage of auto scaling and improve uptime and stability of the application.</p>

<br>

## How to run


To run the application directly, you can run app.py file like so. The API should be exposed on port 80 by default.

```
> python3 app.py
```

The application has been bundled into a docker image which can be downloaded from dockerhub (https://hub.docker.com/repository/docker/theanalyst6/house-prediction-ml).

```
> docker pull theanalyst6/house-prediction-ml:v1.0
```

You can then run the container like so, exposing the container on port 8001 on the host.

```
> docker run -d --rm -p 8001:80 --name house-pred-1 theanalyst6/house-prediction-ml:v1.0
```

<br>

## Project files



| Filename            | Description                                           | 
|---------------------|-------------------------------------------------------|
| app.py              | Main Flask API application                            |                        
| docker_out.txt      | Sample of logs from running docker locally            |
| Dockerfile          | Dockerfile of API                                     |
| kubernetes_out.txt  | Sample logs from running in kubernetes locally        |
| make_prediction.sh  | Sample POST request packet for testing the API        |
| README.md           | README file for the project                           |
| requirements.txt    | Python package Dependencies required to run the API   |
| run_docker.sh       | Script for running and pushing new image to dockerhub |
| run_kubernetes.sh   | Script for running in kubernetes environment          |
| upload_docker.sh    | Script for pushing image to dockerhub                 |
