# $rgName = Read-Host -Prompt 'Which resource group name should be used?'
# $acrName = Read-Host -Prompt 'What is the registry name?'
# $containerName = Read-Host -Prompt 'Which name should be used for the c

$rgName = "rgaks"
$acrName = "robsacr"


$rgExists = az group exists -n $rgName
if ($rgExists -eq 'false') {
    $location = "southeastasia"
    $resourceGroup = New-AzResourceGroup -Name $rgName -Location $location
    Write-Host "`n New resource group '$rgName' created in '$location'.`n"
}
else {
  az group get -n $rgName
}

az acr create -g $rgName -n $acrName --sku Basic
az acr login -n $acrName

# robsacr.azurecr.io/camunda/camunda-bpm-platform:run-latest
docker push robsacr.azurecr.io/camunda/camunda-vanilla-boot:7.14.0
