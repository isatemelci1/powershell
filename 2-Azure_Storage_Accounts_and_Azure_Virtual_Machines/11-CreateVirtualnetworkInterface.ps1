<#
Command Reference

1. Get-AzVirtualNetwork 
https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-7.3.0

2. Get-AzVirtualNetworkSubnetConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetworksubnetconfig?view=azps-7.3.0

3. New-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworkinterface?view=azps-7.3.0

#>

$ResourceGroupName ="powershell-grp"
$VirtualNetworkName="app-network"
$SubnetName="SubnetA"
$Location="North Europe"

# We first need to get the details of our virtual network
$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

# Then we get the details of the subnet
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork

# Then we create the network interface in the virtual network

$NetworkInterfaceName="app-interface"

$NetworkInterface = New-AzNetworkInterface -Name $NetworkInterfaceName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-Subnet $Subnet

# If you want to display the details of the network interface

$NetworkInterface