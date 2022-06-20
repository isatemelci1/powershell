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

$VirtualNetwork=Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName

# We are setting the subnet with the configuration of the Network Security Group
Set-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork `
-NetworkSecurityGroup $NetworkSecurityGroup `
-AddressPrefix $VirtualNetwork.Subnets[0].AddressPrefix

# We then need to update the Virtual Network accordingly

$VirtualNetwork | Set-AzVirtualNetwork
