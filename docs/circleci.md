### 2. CI/CD Pipeline

<p>CircleCi was selected as the primary automation tool as it is relatively low cost with no admin required. The entire work flow contains the following steps:</p>


1. lint - Check Dockerfile syntax using hadolint
2. test - Use pytest to check python app syntax and test flask endpoint using make_prediction.sh script
3. build - Build the docker image and tag it
4. push - Push to Dockerhub
5. create_deployment - Create Kuberneres deployment using prebuilt circleci orb for kubernetes
6. create_service - Create Kuberneres service using prebuilt circleci orb for kubernetes
7. smoke_test - Run the make_predictions.sh script to test the endpoint
8. repoint - Run an update on the blue load balancer to point to new POD version
9. delete_prev_version - Delete green LB and blue PODS

Full job script is located at ./.circleci/config.yml


### Index

1. [Introduction](/README.md)

2. [Architecture](/docs/architecture.md)

3. CI/CD Pipeline



