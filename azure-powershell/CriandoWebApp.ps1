Connect-AzureRmAccount

Get-AzureRmWebApp

Get-AzureRmAppServicePlan

$ResourceGroup= "AZURE-TREINAMENTO-WEBAPP"
$NomePlanoAppService= "planoappserviceps"
$localizacao = "Central US"
$NomeWebApp = "TreinamentoWebAppPS"
$NomeSlot = "Stage"
New-AzureRmAppServicePlan -ResourceGroupName $ResourceGroup -Name $NomePlanoAppService -Location $localizacao -Tier "Standard" -NumberofWorkers 2

New-AzureRmWebApp -ResourceGroupName $ResourceGroup -Name $NomeWebApp -Location $localizacao -AppServicePlan $NomePlanoAppService

New-AzureRmWebAppSlot -ResourceGroupName $ResourceGroup -Name $NomeSlot