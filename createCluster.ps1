az group create -n rgaks -l southeastasia
az acr create -g rgaks -n robsacr --sku Basic
az acr login -n robsacr


docker push robsacr.azurecr.io/azure-vote-front:v1
docker push robsacr.azurecr.io/camunda/camunda-bpm-platform:run-latest

az aks create -g rgaks -n camAKSCluster --node-count 2 --generate-ssh-keys --attach-acr robsacr
az aks get-credentials -g rgaks -n camAKSCluster

kubectl get nodes

kubectl apply -f .\azure-camunda-bpm-run.yaml
kubectl get service camunda-bpm-run --watch
