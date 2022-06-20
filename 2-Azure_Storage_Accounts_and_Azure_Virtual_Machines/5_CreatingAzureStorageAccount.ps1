<#
Command Reference
1. New-AzStorageAccount
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-7.3.0

#>

# ----------------------------------------------
# This snippet of code can be used to create a storage account
# Remember to change the AccountName so that its unique

$AccountName = "appstore40008989"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"
$ResourceGroupName="powershell-grp"
$Location = "North Europe"

$StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU

$StorageAccount

# ----------------------------------------------