# Camunda Spring Boot deployment on Azure Kubernetes Service (AKS)
This project illustrates how 
- a docker image based on a  [Camunda BPM Spring Boot](https://docs.camunda.org/get-started/spring-boot/) project is built,
- the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) is used to create an Azure Container Reqgistry (ACR) and to push the image to it
- a Kubernetes Cluster on AKS is created using the Azure CLI
- an image is deployed on the Kubernetes cluster as a service and
- the service is exposed to the internet via a public IP using a [LoadBalancer](https://docs.microsoft.com/en-us/azure/aks/load-balancer-standard) or Ingress)

## Prerequisites
The project assume local installations [Maven](https://maven.apache.org/), [Docker](https://www.docker.com/), [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.1) and [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) are accessible via the command line.


## Usage

### Build the Camunda Spring Boot project and Docker image

The sub folder [.\vanilla-spring-boot](vanilla-spring-boot) contains a standard Camunda Spring Boot Maven project, created using the [Camunda BPM Initializr](https://start.camunda.com/). This project can be adjusted as needed to created the desired Camunda deployment.

Inside the [.\vanilla-spring-boot](vanilla-spring-boot) folder run 
`mvn clean install` 
to clean the project, then build the Camunda Spring Boot jar (in
*.\vanilla-spring-boot\target\camunda-vanilla-boot-7.14.0.jar*) and build and publish a Docke rimage based on it to your local Docker registry named robsacr.azurecr.io/camunda/camunda-vanilla-boot:7.14.0 (adjust docker.image.tag in [pom.xml line 15 ](vanilla-spring-boot/pom.xml) as desired).   


## Create an Azure container registry and push the image to it
In [.\createACRandPush.ps1](createACRandPush.ps1) adjust resource group name, container registry name and image tag as desired.

> $rgName = "rgaks"
> 
> $acrName = "robsacr"
>
>...
> 
> docker push robsacr.azurecr.io/camunda/camunda-vanilla-boot:7.14.0
> 
then run `.\createACRandPush.ps1` to create the resource group and container registry and push your image to the Azure container registry.

## Create Kubernetes Cluster, Pod, Service and Ingress

In [.\createCluster.ps1](createCluster.ps1) adjust resource group, container registry and cluster names as desired.

> $rgName = "rgaks"
> 
> $acrName = "robsacr"
> 
> $clusterName = "camundaCluster"
then run `.\createCluster.ps1` to create a new Kubernetes cluster and apply pod, service and ingress definitions to it.

## Application Gateway, Application Gateway Ingress Controller and network routing

![Architecture](https://azure.github.io/application-gateway-kubernetes-ingress/images/architecture.png)

## Simple Tests

You can check the results of the scripts via Azure CLI or in the [Azure portal](https://portal.azure.com/)

The external IP will become visible in the console when the script and Azure proivisioning are completed.
The EXTENRAL IP column will at first show *pending*, then a new row with the external IP will appear. This may take a few seconds or rarely even minutes.

Check if you can access the Camunda Web application via the public IP of your load balancer. 

In the *Kubernetes services* section of the Azure portal you can check the configured *workloads*, *services and ingresses* and their status. The *services and ingresses* also contains a link to the external IP under which the Camunda web application should be accessible.

## Cleanup

`Remove-AzResourceGroup -Name <resource group name>`

## Supporting Documentation and Resources
 
 [Camunda BPM Spring Boot documentation](https://docs.camunda.org/get-started/spring-boot/)

 [Azure Kubernetes Sevrice (AKS) documentation](https://docs.microsoft.com/en-us/azure/aks/)

[Azure CLI documentation](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

[Quickstart: Create a private container registry using Azure PowerShell](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-powershell)

[Quickstart: Create an Azure container registry using the Azure portal](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-portal)

[Tutorial: Deploy an Azure Kubernetes Service (AKS) cluster](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster)

[Use a public Standard Load Balancer in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/load-balancer-standard)

[Exposing an External IP Address to Access an Application in a Kubernetes Cluster](https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/)

[Kubernetes Nginx ingress: traffic redirect using annotations demystified](https://medium.com/ww-engineering/kubernetes-nginx-ingress-traffic-redirect-using-annotations-demystified-b7de846fb43d)

[Create an HTTPS ingress controller on Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/ingress-tls)

[Application Gateway Ingress Controller for Azure Kubernetes Service](https://azure.microsoft.com/en-us/blog/application-gateway-ingress-controller-for-azure-kubernetes-service/)

[Application Gateway Ingress Controller](https://azure.github.io/application-gateway-kubernetes-ingress/)

[Use kubenet networking with your own IP address ranges in Azure Kubernetes Service (AKS)](https://docs.microsoft.com/en-us/azure/aks/configure-kubenet)
## License
[Application Gateway configuration overview]()https://docs.microsoft.com/en-us/azure/application-gateway/configuration-overview


[Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0)


