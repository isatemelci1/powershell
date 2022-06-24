<#
Command Reference

1. New-AzADServicePrincipal
https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azadserviceprincipal?view=azps-7.3.0

2. New-AzRoleAssignment
https://docs.microsoft.com/en-us/powershell/module/az.resources/new-azroleassignment?view=azps-7.3.0

3. Disconnect-AzAccount
https://docs.microsoft.com/en-us/powershell/module/az.accounts/disconnect-azaccount?view=azps-7.3.0

#>

Disable-AzContextAutosave

# We need to connect to our Azure account with Azure Administrator details
# This will allow us to create the service principal
Connect-AzAccount

# We then create the service principal
$ServicePrincipalName="app-principal"
$ServicePrincipal=New-AzADServicePrincipal -DisplayName $ServicePrincipalName

# We generate a new secret for the service principal and get the Id
$ServicePrincipalId=$ServicePrincipal.Id
$ServicePrincipalSecret=$ServicePrincipal.PasswordCredentials.SecretText

$Subcription=Get-AzSubscription -SubscriptionName "Azure Subscription 1"
$scope="/subscriptions/$Subcription"
$RoleDefinition="Contributor"

# We then assign the required role to the service principal

New-AzRoleAssignment -ObjectId $ServicePrincipalId -RoleDefinitionName $RoleDefinition `
-Scope $scope

# We then disconnect as the Azure Admin

Disconnect-AzAccount

# And then connect as the new service principal
$AppId=$ServicePrincipal.AppId
$SecureSecret = $ServicePrincipalSecret | ConvertTo-SecureString -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AppId,$SecureSecret

$TenantID=""

Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantID 

# We can create a new resource group as the service principal
New-AzResourceGroup -Name "demo-grp" -Location $Location
