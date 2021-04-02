Connect-AzureRmAccount

$gruporecurso = "AZURE-TREINAMENTO-BACKUP"
$localizacao = "centralus"
$NomeRecoveryService = "RecoveryServicePS"

#Registra o provedor de serviços
Register-AzureRmResourceProvider -ProviderNamespace "Microsoft.RecoveryServices" 

#Cria o RecoveryServiceVault
New-AzureRmRecoveryServiceVault -ResourceGroupName -Name $NomeRecoveryService -Location $localizacao

#Lista os RecoveryServiceVault
Get-AzureRmRecoveryServicesVault  -Name $NomeRecoveryService | Set-AzureRmRecoveryServicesVaultContext

#Lista as politicas de backup
Get-AzureRmRecoveryServicesBackupProtectionPolicy




#Criando uma VM (Vai pedir um usuário e senha)
New-AzureRmVM -ResourceGroupName $gruporecurso -Name "vm1ps" -Location $localizacao

#Vinculando um backup a VM criada
$politica = Get-AzureRmRecoveryServicesBackupProtectionPolicy -Name "DefaultPolicy"
Enable-AzureRmRecoveryServicesBackupProtection -ResourceGroupName $gruporecurso -Name "vm1ps" -Policy $politica

#Gerando o backup da VM
$backupContainer = Get-AzureRmRecoveryServicesBackupContainer -ContainerType "AzureVM" -FriendlyName "vm1ps"
$item = Get-AzureRmRecoveryServicesBackupItem -Container $backupContainer -WorkloadType "AzureVM"
Backup-AzureRmRecoveryServicesBackupItem -Item $item

#Acompanhando o andamento do backupjob
Get-AzureRmRecoveryServicesBackupJob

#Restaurando o backup
#Criando o ponto de restauracao
$RP = Get-AzureRmRecoveryServicesBackupRecoveryPoint -Item $item
#Cria o StorageAccount para armazenar o ponto de restauração
$storage = New-AzureRmStorageAccount -ResourceGroupName $gruporecurso -Name "recoverystorageps" -Location $localizacao -SkuName "Standard_LRS"
#Rodando a restauração
$restore = Restore-AzureRmRecoveryServicesBackupItem -RecoveryPoint $rp[0] -StorageAccountName "recoverystorageps" -StorageAccountResourceGroupName $gruporecurso

#Acompanhando a execução da restauração
Get-AzureRmRecoveryServicesBackupJobDetails -job $restore


#Removendo o RecoveryServiceVault
#Desativando o backup protection
Disable-AzureRmRecoveryServicesBackupProtection -Item $item -RemoveRecoveryPoints

#Removendo o ServiceVault
$vault = Get-AzureRmRecoveryServicesVault -Name $NomeRecoveryService
Remove-AzureRmRecoveryServicesVault -Vault $vault

#Removendo a VM criada
Remove-AzVM -Name "vm1ps"