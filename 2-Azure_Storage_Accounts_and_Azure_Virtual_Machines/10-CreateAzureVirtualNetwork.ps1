<#
Command Reference
1. New-AzVirtualNetworkSubnetConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetworksubnetconfig?view=azps-7.3.0

2. New-AzVirtualNetwork
https://docs.microsoft.com/en-us/powershell/module/az.network/new-azvirtualnetwork?view=azps-7.3.0

#>

$ResourceGroupName ="powershell-grp"
$Location="North Europe"

$VirtualNetworkName="app-network"
$VirtualNetworkAddressSpace="10.0.0.0/16"
$SubnetName="SubnetA"
$SubnetAddressSpace="10.0.0.0/24"

# We are first going to create a subnet configuration

$Subnet=New-AzVirtualNetworkSubnetConfig -Name $SubnetName -AddressPrefix $SubnetAddressSpace

# Then we will create the virtual network

$VirtualNetwork = New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet

# You can then display the details of the virtual network

' The Virtual Network details'
$VirtualNetwork