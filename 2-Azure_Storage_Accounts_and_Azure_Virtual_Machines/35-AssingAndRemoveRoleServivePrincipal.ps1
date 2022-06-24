
<#
Command Reference
All of the commands stay the same as for the previous scripts
#>

$ResourceGroupName="powershell-grp"
$Location = "North Europe"

# We need to connect to our Azure account with Azure Administrator details
Connect-AzAccount

$ServicePrincipalName="app-principal"
$ServicePrincipal =Get-AzADServicePrincipal -DisplayName $ServicePrincipalName
$ServicePrincipalId=$ServicePrincipal.Id

# We add the rule for managing storage accounts
$Subcription=Get-AzSubscription -SubscriptionName "Azure Subscription 1"
$scope="/subscriptions/$Subcription/resourcegroups/$ResourceGroupName"
$RoleDefinition="Storage Account Contributor"

New-AzRoleAssignment -ObjectId $ServicePrincipalId -RoleDefinitionName $RoleDefinition `
-Scope $scope

# We then remove the role at the subscription level
$scope="/subscriptions/$Subcription"
$RoleDefinition="Contributor"

Remove-AzRoleAssignment -ObjectId $ServicePrincipalId -RoleDefinitionName $RoleDefinition `
-Scope $scope

# We then disconnect as the Azure Admin
Disable-AzContextAutosave
Disconnect-AzAccount

# We can then connect as the service principal and create the storage account

$AppId=$ServicePrincipal.AppId

$SecureSecret = $ServicePrincipalSecret | ConvertTo-SecureString -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AppId,$SecureSecret

$TenantID=""

Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantID 

$AccountName = "appstore5000338989"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"

New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU
