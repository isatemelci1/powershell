<#
Command Reference
All of the commands stay the same as for the previous scripts

The different commands used in this script are

1. Get-AzSubscription
https://docs.microsoft.com/en-us/powershell/module/az.accounts/get-azsubscription?view=azps-7.3.0

2. Set-AzContext 
https://docs.microsoft.com/en-us/powershell/module/az.accounts/set-azcontext?view=azps-7.3.0

#>

# First log in with your service principal
# Change all of the application details accordingly

$AppId=""
$AppSecret=""

$SecureSecret = $AppSecret | ConvertTo-SecureString -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AppId,$SecureSecret

$TenantID=""

# Then connect to the Azure account
Connect-AzAccount -ServicePrincipal -Credential $Credential -Tenant $TenantID 

# Then set the subscription accordingly
# Add the name of your subscription accordingly

$SubscriptionName="Staging Subscription"
$Subcription=Get-AzSubscription -SubscriptionName $SubscriptionName
Set-AzContext -SubscriptionObject $Subcription
