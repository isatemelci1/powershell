<#
Command Reference

1. New-AzPublicIpAddress
https://docs.microsoft.com/en-us/powershell/module/az.network/new-azpublicipaddress?view=azps-7.3.0

2. Get-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-7.3.0

3 .Get-AzNetworkInterfaceIpConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterfaceipconfig?view=azps-7.3.0

4. Set-AzNetworkInterfaceIpConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-7.3.0

5. Set-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterfaceipconfig?view=azps-7.3.0

6. Set-AzVirtualNetworkSubnetConfig
https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetworksubnetconfig?view=azps-7.3.0

7. Set-AzVirtualNetwork
https://docs.microsoft.com/en-us/powershell/module/az.network/set-azvirtualnetwork?view=azps-7.3.0

#>

$PublicIPAddressName="app-ip"
$ResourceGroupName ="powershell-grp"
$Location="North Europe"

# First we need to create the Public IP Address

$PublicIPAddress = New-AzPublicIpAddress -Name $PublicIPAddressName -ResourceGroupName $ResourceGroupName `
-Location $Location -Sku "Standard" -AllocationMethod "Static"

# Get the details of our network interface
$NetworkInterfaceName="app-interface"
$NetworkInterface= Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName

# Then we need to get the IP Config details of the network interface
$IpConfig=Get-AzNetworkInterfaceIpConfig -NetworkInterface $NetworkInterface

# Then we set the Network Interface with the new Public IP Address
$NetworkInterface | Set-AzNetworkInterfaceIpConfig -PublicIpAddress $PublicIPAddress `
-Name $IpConfig.Name

# And then finally we set the Network Interface with the new details
$NetworkInterface | Set-AzNetworkInterface
