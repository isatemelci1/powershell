<#
Command Reference
1. Remove-AzResourceGroup
https://docs.microsoft.com/en-us/powershell/module/az.resources/remove-azresourcegroup?view=azps-7.3.0

2. Get-AzResourceGroup
https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresourcegroup?view=azps-7.3.0

#>

# ----------------------------------------------
# This snippet of code can be used to remove a particular resource group

$ResourceGroupName ="powershell-grp"
Remove-AzResourceGroup $ResourceGroupName -Force
'Removed Resources Group ' + $ResourceGroupName

# ----------------------------------------------

# ----------------------------------------------
# Here we are recreating the resource group and then get a property of the resource group

$Location = "North Europe"
$ResourceGroup=New-AzResourceGroup -Name $ResourceGroupName -Location $Location

'Provisioning State ' + $ResourceGroup.ProvisioningState

# We can also get an existing resource group from Azure
$ResourceGroupExisting=Get-AzResourceGroup -Name $ResourceGroupName

$ResourceGroupExisting

# ----------------------------------------------

# ----------------------------------------------
# This snippet of code can be used to remove all resource groups

$AllResourceGroups=Get-AzResourceGroup

foreach($Group in $AllResourceGroups)
{
    'Removing Resource Group ' + $Group.ResourceGroupName
    Remove-AzResourceGroup -Name $Group.ResourceGroupName -Force
}

# ----------------------------------------------