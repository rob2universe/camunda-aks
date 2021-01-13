$rgName = rgaks
$acrName = robsacr
$clusterName = camundaCluster
az group create -n $rgName -l southeastasia

# az acr create -g $rgName -n robsacr --sku Basic
# az acr login -n robsacr
# docker push robsacr.azurecr.io/azure-vote-front:v1
# docker push robsacr.azurecr.io/camunda/camunda-bpm-platform:run-latest

az aks create -g $rgName -n camundaCluster --node-count 2 --generate-ssh-keys --attach-acr $acrName
az aks get-credentials -g $rgName -n camundaCluster

kubectl get nodes

# kubectl apply -f .\azure-camunda-bpm-run.yaml
kubectl apply -f .\pod.yml
kubectl apply -f .\service.yml
kubectl apply -f .\ingress.yml

kubectl get service camunda-bpm-run --watch
