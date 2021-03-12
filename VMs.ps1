Connect-AzureRmAccount

Get-AzureRmVM | Select Name

Get-AzureRMVM -ResourceGroupName 'AZURE-TREINAMENTO' -Name 'VMWINSERVER2016'

Restart-AzureRmVM -ResourceGroupName 'AZURE-TREINAMENTO' -Name 'VMWINSERVER2016'

Stop-AzureRmVM -ResourceGroupName 'AZURE-TREINAMENTO' -Name 'VMWINSERVER2016'

Start-AzureRmVM -ResourceGroupName 'AZURE-TREINAMENTO' -Name 'VMWINSERVER2016'