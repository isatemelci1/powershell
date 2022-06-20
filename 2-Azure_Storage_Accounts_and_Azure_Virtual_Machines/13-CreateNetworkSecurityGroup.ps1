<#
Command Reference

1. New-AzNetworkSecurityRuleConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworksecurityruleconfig?view=azps-7.3.0

2. New-AzNetworkSecurityGroup
https://docs.microsoft.com/en-us/powershell/module/az.network/new-aznetworksecuritygroup?view=azps-7.3.0

3 .Get-AzVirtualNetwork
https://docs.microsoft.com/en-us/powershell/module/az.network/get-azvirtualnetwork?view=azps-7.3.0

4. Set-AzVirtualNetworkSubnetConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworksubnetconfig?view=azps-7.3.0

5. Set-AzVirtualNetwork
https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetwork?view=azps-7.3.0

#>

# First we need to define the Security Rule to create

$SecurityRule1=New-AzNetworkSecurityRuleConfig -Name "Allow-RDP" -Description "Allow-RDP" `
-Access Allow -Protocol Tcp -Direction Inbound -Priority 100 `
-SourceAddressPrefix * -SourcePortRange * `
-DestinationAddressPrefix * -DestinationPortRange 3389

# Then we can create the Network Security Group

$NetworkSecurityGroupName="app-nsg"
$ResourceGroupName ="powershell-grp"
$Location="North Europe"

$NetworkSecurityGroup=New-AzNetworkSecurityGroup -Name $NetworkSecurityGroupName `
-ResourceGroupName $ResourceGroupName -Location $Location `
-SecurityRules $SecurityRule1

# We then need to assign the network security group to the subnet in the virtual network
$VirtualNetworkName="app-network"
$SubnetName="SubnetA"
$SubnetAddressSpace="10.0.0.0/24"

$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

# We are setting the subnet with the configuration of the Network Security Group
Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $NetworkSecurityGroup `
-AddressPrefix $SubnetAddressSpace

# We then need to update the Virtual Network accordingly

$VirtualNetwork | Set-AzVirtualNetwork
