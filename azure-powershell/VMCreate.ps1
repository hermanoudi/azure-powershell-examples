#Conecta na conta da azure
Connect-AzureRmAccount

#Salva em um arquivo json as infos de conta
Save-AzureRmProfile -Path c:\azureprofile.json

#Importa os dados de conta
Import-AzureRmContext -Path "c:\azureprofile.json"

#Criar Simples VM
New-AzureRmVM -Name "VMSimples" 

#Criar VM com vnet, subnet e NIC
$gruporecurso = "AZURE-TREINAMENTO"
$localizacao = "centralus"
$vmSize = "Standard_DS3"
$nomeVM = "vmwinps"
$networkNome = "vmnet"
$nicNome = "vmnic"
$subnetNome = "vmsubnet"
$subnetEnderecoPrefixo = "10.0.0.0/24"
$vnetEnderecoPrefixo = "10.0.0.0/16"

$subnet = New-AzureRmVirtualNetworkSubnetConfig -Name $subnetNome -AddressPrefix $subnetEnderecoPrefixo
$vnet = New-AzureRmVirtualNetwork -Name $networkNome -ResourceGroupName $gruporecurso -Location $localizacao -AddressPrefix $vnetEnderecoPrefixo -Subnet $subnet
$nic = New-AzureRmNetworkInterface -Name $nicNome -ResourceGroupName $gruporecurso -Location $localizacao -SubnetId $Vnet.Subnets[0].Id 

$vm = New-AzureRmVMConfig -VMName $nomeVM -VMSize $vmSize 
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Windows -ComputerName $nomeVM -ProvisionVMAgent -EnableAutoUpdate 
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$vm = Set-AzureRmVMSourceImage -VM $vm -PublisherName 'MicrosoftWindowsServer' -Offer "WindowsServer" -Skus "2012-R2-Datacenter" -Version latest

New-AzureRmVM -ResourceGroupName $gruporecurso -Location $localizacao -VM $vm -Verbose
Start-AzVM -Name $nomeVM 
Stop-AzVM -Name $nomeVM 
Remove-AzVM -Name $nomeVM 