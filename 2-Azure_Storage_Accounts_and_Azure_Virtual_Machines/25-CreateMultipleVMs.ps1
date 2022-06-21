<#
Command Reference
All of the commands stay the same as previous scripts for creating an Azure VM

#>


$ResourceGroupName ="powershell-grp"
$Location="North Europe"

$VirtualNetworkName="app-network"
$VirtualNetworkAddressSpace="10.0.0.0/16"
$SubnetName="SubnetA"
$SubnetAddressSpace="10.0.0.0/24"

# Create the subnet resource

$Subnet=New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Creating the Virtual Network

$VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet

$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

# Creating the Network Interface

$NetworkInterfaceName="app-interface"
$NetworkInterfaces=@()

for($i=1;$i -le 2;$i++)
{
    $NetworkInterfaces+=New-AzNetworkInterface -Name "$NetworkInterfaceName$i" `
    -ResourceGroupName $ResourceGroupName -Location $Location `
    -Subnet $Subnet    
}

 
# Creating the Public IP Addresss

$PublicIPAddressName="app-ip"
$PublicIPAddresses=@()
$IpConfigs=@()

for($i=1;$i -le 2;$i++)
{
$PublicIPAddresses+=New-AzPublicIpAddress -Name "$PublicIPAddressName$i" -ResourceGroupName $ResourceGroupName `
-Location $Location -Sku "Standard" -AllocationMethod "Static"

$IpConfigs+=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterfaces[$i-1]

$NetworkInterfaces[$i-1] | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIPAddresses[$i-1] `
-Name $IpConfigs[$i-1].Name

$NetworkInterfaces[$i-1] | Set-AzNetworkInterface

}


# Creating the Network Security Group

$SecurityRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
-SourceAddressPrefix * -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 3389

$NetworkSecurityGroupName="app-nsg"

$NetworkSecurityGroup=New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-SecurityRules $SecurityRule1

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

$VmConfig=@()
$VMs=@()

for($i=1;$i -le 2;$i++)
{

$NetworkInterfaces[$i-1]= Get-AzNetworkInterface -Name "$NetworkInterfaceName$i" -ResourceGroupName $ResourceGroupName

$VmConfig+=New-AzVMConfig -Name "$VmName$i" -VMSize $VMSize

Set-AzVMOperatingSystem -VM $VmConfig[$i-1] -ComputerName "$VmName$i" `
-Credential $Credential -Windows

Set-AzVMSourceImage -VM $VmConfig[$i-1] -PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest"

$VMs+=Add-AzVMNetworkInterface -VM $VmConfig[$i-1]  -Id $NetworkInterfaces[$i-1].Id

Set-AzVMBootDiagnostic -Disable -VM $Vms[$i-1]

New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location `
-VM $VMs[$i-1]

}
