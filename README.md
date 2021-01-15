# go-k3d 

This docker image is having go-lang and k3d installed. Can be used for testing the kubernetes components like CRD.

## How to use in gitlab pipleline

The ".gitlab-ci.yml" must have a job like this

```
deployment-test:
  stage: deployment-test
  image: dmathai/gok3d:latest
  services:
    - docker:20-dind
  script:
    - k3d cluster create --image docker.io/rancher/k3s:v1.18.9-k3s1 --api-port 6444 --servers 1 --agents 1
    # Setting the server url in gitlab pipeline as the docker service is available at hostname "docker"
    - kubectl config set-cluster k3d-k3s-default --server=https://docker:6444
    - kubectl get deployments
    - kubectl create deployment nginx --image=nginx
    - kubectl get deployments
```

## Build docker locally

```
docker build -t dmathai/gok3d:latest -f Dockerfile .
```
