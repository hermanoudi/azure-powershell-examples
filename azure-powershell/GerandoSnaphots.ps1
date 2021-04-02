Connect-AzureRmAccount

$gruporecurso = "AZURE-TREINAMENTO-BACKUP"
$localizacao = "centralus"
$NomeVM = "vm1"
$NomeSnapshot = "vm1snapshotps"

//Pega o objeto da VM
$vm = Get-AzureRmVM -ResourceGroupName $gruporecurso -Name $NomeVM

$snapshot = New-AzureRmSnapshotConfig -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id -Location $localizacao -CreateOption copy 

//Gera o snapshpt
New-AzureRmSnapshot -Snapshot $snapshot -SnapshotName $NomeSnapshot -ResourceGroupName $gruporecurso


//Criar VM a partir do snapshot
//Lista os snapshots do grupo de recurso selecionado
Get-AzureRmSnapshot -ResourceGroupName $gruporecurso

//Pega o snapshot do nome selecionado
$snapshot = Get-AzureRmSnapshot -ResourceGroupName $gruporecurso -SnapshotName $NomeSnapshot

$discoConfig = New-AzureRmDiskConfig -Location $localizacao -SourceResourceId $snapshot.Id -CreateOption Copy 
$NomeDisco = "disco"
$disco = New-AzureRmDisk -Disk $discoConfig -ResourceGroupName $gruporecurso -DiskName $NomeDisco 

$NomeVmNova = "vm2"
$VirtualMachine = New-AzureRmVmConfig -VMName $NomeVmNova -VMSize "Standard_DS3"
$VirtualMachine = Set-AzureRmVMOSDisk -VM $VirtualMachine -ManagedDiskId $disco.Id -CreateOption Attach -Windows 

$NomeVmNova = "vm2-ip"
$ippublico = New-AzureRmPublicIpAddress -Name $NomeVmNova -ResourceGroupName -$gruporecurso -Location $snapshot.Location -AllocationMethod Dynamic

$NomeVNet = "AZURE-TREINAMENTO-BACKUP-vnet"
$vnet = Get-AzureRmVirtualNetwork -Name $NomeVNet -ResourceGroupName $gruporecurso 

$NomeNic = "vm2_nic" 
$nic = New-AzureRmNetworkInterface -Name $NomeNic -ResourceGroupName $gruporecurso -Location $snapshot.Location -SubnetId $vnet.Subnets[0].Id $ippublico.Id 

$VirtualMachine = Add-AzureRmVMNetworkInterface -VM $VirtualMachine -Id $nic.Id

//Finalmente cria a vm através do snapshot
New-AzureRmVm -VM $VirtualMachine -ResourceGroupName $gruporecurso -Location $snapshot.Location 

