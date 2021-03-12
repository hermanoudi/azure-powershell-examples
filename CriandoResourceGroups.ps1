$arquivoToken = "C:\azureprofile.json"
Import-AzureRmContext -Path $arquivoToken
$nomeRG = "NovoGrupoRecurso"
$localizacaoRG = "South Central US"
New-AzureRmResourceGroup -Name $nomeRG -Location $localizacaoRG

Get-AzureRmResourceGroup | Select ResourceGroupName

Remove-AzureRmResourceGroup -Name $nomeRG