### 1. Architecture

#### Introduction

<p>The API will be deployed to AWS running on an EKS instance with the following specifications.</p>

| Feature                 | Value           |
|-------------------------|-----------------|
| desiredCapacity         | 3               |
| instanceType            | t3.small        |
| region                  | us-east-1       |
| version                 | 1.21            |
| name                    | api-cluster-1   |

<br>

<p>A Typical EKS deployment is shown in the figure below. Notice the number of AWS services required to create a kubernetes cluster is quite high; VPCs, subnets, autoscaling groups, gateways and routing are needed. This can be difficult to manage and configure so using an Iac tool can help to alleviate this issue. "eksctl" developed by weaveworks is a command lines tool which can create an entire cluster based on a yaml configuration file. It is the recommended approach for creating EKS clusters. </p>


![High Level Architecture](/images/HousePriceML_EKS.png)


<br>

#### Tools and Utilities

<p>The following will be used for deploying to kubernetes</p>

- **kubectl** - Command line tool for interacting with local (minikube) or remote (eks) kubernetes clusters. Used for creating namespaces, deployments and services.
- **eksctl** - Command line utility used for creating kubernetes clusters on AWS. The offically supported EKS creation tool for AWS. Generates cloud formation templates to create the necessary resources.
- **minikube** - Sandbox kubernetes environment for testing and development.
- **Docker** - Container run time used to run docker images of house price prediction ML.
- **Circleci** - Local Command line version the of cloud based version of circleci (CI/CD automation). Used to lint/check circleci configs and run local builds before pushing.

<br>

#### Infrastructure as code

<p>As mentioned above, eksctl uses cloud formation templates under the hood to generate the required resources in AWS and is the recommended approach for creating EKS clusters. IaC allows us to define a single re-usable template in yaml that can be version controlled in git and modified when required. The eksctl template used in ths project is shown below. Notice how only a few lines of configuration are required in comparison with having to generate cloud formation templates or writing terraform configurations.</p>

```
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: api-cluster-1
  region: us-east-1
  version: "1.21"

availabilityZones: ["us-east-1a", "us-east-1b", "us-east-1c"]

managedNodeGroups:
- name: nodegroup
  desiredCapacity: 3
  instanceType: t3.small
  ssh:
    enableSsm: true

```

<br>


#### Deployment Strategy

<p>To ensure high availability with no downtime, a blue/green deployment strategy was selected. </p>

<p>The blue deployment represents a current production deployment in kubernetes. Traffic is sent from the outside world to a service which acts as a load balancer. Traffic is then forwarded to PODS which contain the House prediction ML API.</p>

![Initial Deployment](/images/BLUE_GREEN_BEFORE.png)

<br>

<p>Next We deploy the newer version of the application shown in green.</p>

![Initial Deployment](/images/BLUE_GREEN_DEPLOY.png)

<br>

<p>After a successful smoke test, traffic is sent from the blue LB to the green PODS.</p>

![Initial Deployment](/images/BLUE_GREEN_SWITCH.png)

<br>

<p>The green LB and old POD version are removed. Load now gets sent to the green PODS.</p>

![Initial Deployment](/images/BLUE_GREEN_REMOVE.png)

<br>

### Index

1. [Introduction](./README.md)

2. Architecture

3. [CI/CD Pipeline](./docs/circleci.md)