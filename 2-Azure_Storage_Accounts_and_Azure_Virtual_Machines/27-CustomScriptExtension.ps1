<#
Command Reference
All of the commands stay the same as previous scripts for creating an Azure VM

The different commands used in this script are

1. Get-AzStorageAccountKey
https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccountkey?view=azps-7.3.0

2. Set-AzVmExtension
https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmextension?view=azps-7.3.0

#>

$ResourceGroupName ="powershell-grp"
$Location="North Europe"

$VirtualNetworkName="app-network"
$VirtualNetworkAddressSpace="10.0.0.0/16"
$SubnetName="SubnetA"
$SubnetAddressSpace="10.0.0.0/24"

# Create the subnet resource

$SubnetA=New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Creating the Virtual Network

$VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $SubnetA

$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

# Creating the Network Interface

$NetworkInterfaceName="app-interface"

$NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-Subnet $Subnet

# Creating the Public IP Addresss

$PublicIPAddressName="app-ip"

$PublicIPAddress = New-AzPublicIpAddress -Name $PublicIPAddressName -ResourceGroupName $ResourceGroupName `
-Location $Location -Sku "Standard" -AllocationMethod "Static"

$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

$NetworkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIPAddress `
-Name $IpConfig.Name

$NetworkInterface | Set-AzNetworkInterface

# Creating the Network Security Group

$SecurityRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
-SourceAddressPrefix * -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 3389

# Ensure that we have another rule to allow traffic on port 80

$SecurityRule2=New-AzNetworkSecurityRuleConfig -Name "Allow-HTTP" -Description "Allow-HTTP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 200 `
-SourceAddressPrefix * -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 80

$NetworkSecurityGroupName="app-nsg"

$NetworkSecurityGroup=New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-SecurityRules $SecurityRule1,$SecurityRule2

$VirtualNetworkName="app-network"
$SubnetName="SubnetA"
$SubnetAddressSpace="10.0.0.0/24"

$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $NetworkSecurityGroup `
-AddressPrefix $SubnetAddressSpace

$VirtualNetwork | Set-AzVirtualNetwork

# Creating the Azure Virtual Machine

$VmName="appvm"
$VMSize = "Standard_DS2_v2"

$Location ="North Europe"
$UserName="demousr"
$Password="Azure@123"

$PasswordSecure=ConvertTo-SecureString -String $Password -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $UserName,$PasswordSecure

$NetworkInterfaceName="app-interface"
$NetworkInterface= Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName

$VmConfig=New-AzVMConfig -Name $VmName -VMSize $VMSize

Set-AzVMOperatingSystem -VM $VmConfig -ComputerName $VmName `
-Credential $Credential -Windows

Set-AzVMSourceImage -VM $VmConfig -PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest"

$Vm=Add-AzVMNetworkInterface -VM $VmConfig -Id $NetworkInterface.Id

Set-AzVMBootDiagnostic -Disable -VM $Vm

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location `
-VM $Vm

# This is the setup of the storage account for storing the IIS Config file
$AccountName = "vmstore40008989"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"
$ResourceGroupName="powershell-grp"
$Location = "North Europe"

$StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU

# First to create the container
$ContainerName="data"

New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context `
-Permission Blob

$BlobObject=@{
    FileLocation="IIS_Config.ps1"
    ObjectName ="IIS_Config.ps1"
}

$Blob=Set-AzStorageBlobContent -Context $StorageAccount.Context -Container $ContainerName `
-File $BlobObject.FileLocation -Blob $BlobObject.ObjectName


# Work with the Custom Script Extension

$blobUri=@($Blob.ICloudBlob.Uri.AbsoluteUri)
$StorageAccountKey=(Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName `
-AccountName $AccountName) | Where-Object {$_.KeyName -eq "key1"}

$settings=@{"fileUris"=$blobUri}

$StorageAccountKeyValue=$StorageAccountKey.Value

$protectedSettings=@{"storageAccountName" = $AccountName;"storageAccountKey"= $StorageAccountKeyValue; `
"commandToExecute" ="powershell -ExecutionPolicy Unrestricted -File IIS_Config.ps1"};

Set-AzVmExtension -ResourceGroupName $ResourceGroupName -Location $Location `
-VMName $VmName -Name "IISExtension" -Publisher "Microsoft.Compute" `
-ExtensionType "CustomScriptExtension" -TypeHandlerVersion "1.10" `
-Settings $settings -ProtectedSettings $protectedSettings


