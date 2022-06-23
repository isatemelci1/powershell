
<#
Command Reference

1. Update-AzStorageAccountNetworkRuleSet
https://docs.microsoft.com/en-us/powershell/module/az.storage/update-azstorageaccountnetworkruleset?view=azps-7.3.0

2. Invoke-WebRequest
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2

3. Add-AzStorageAccountNetworkRule
https://docs.microsoft.com/en-us/powershell/module/az.storage/add-azstorageaccountnetworkrule?view=azps-7.3.0


#>

# Here we assume that we have the following storage account in place
$ResourceGroupName ="powershell-grp"
$StorageAccountName="appstore465656"

# Here we are first setting the default action to deny in the network rules

Update-AzStorageAccountNetworkRuleSet -ResourceGroupName $ResourceGroupName `
-Name $StorageAccountName -DefaultAction Deny

# We get the IP address assigned to our machine
$IPAddress=Invoke-WebRequest -uri "https://ifconfig.me/ip" | Select-Object Content

# We then add the rule accordingly
Add-AzStorageAccountNetworkRule -ResourceGroupName $ResourceGroupName `
-AccountName $StorageAccountName -IPAddressOrRange $IPAddress.Content

# The following code snippet is used to allow access to a virtual network
# -----------------------------------------------------------------------

$VirtualNetworkName="app-network"

$VirtualNetwork=Get-AzVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VirtualNetworkName

$SubnetConfig = $VirtualNetwork | Get-AzVirtualNetworkSubnetConfig

# Add the service endpoint

Set-AzVirtualNetworkSubnetConfig -Name $SubnetConfig[0].Name `
-ServiceEndpoint "Microsoft.Storage" -VirtualNetwork $VirtualNetwork `
-AddressPrefix $SubnetConfig[0].AddressPrefix `
| Set-AzVirtualNetwork

Add-AzStorageAccountNetworkRule -ResourceGroupName $ResourceGroupName `
-AccountName $StorageAccountName -VirtualNetworkResourceId $SubnetConfig[0].Id

# -----------------------------------------------------------------------