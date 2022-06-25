<#
Command Reference

1. New-AzAppServicePlan
https://docs.microsoft.com/en-us/powershell/module/az.websites/new-azappserviceplan?view=azps-7.3.0

2. New-AzWebApp
https://docs.microsoft.com/en-us/powershell/module/az.websites/new-azwebapp?view=azps-7.3.0

#>

$ResourceGroupName="powershell-grp"
$Location="North Europe"
$AppServicePlanName="companyplan"
$WebAppName="companyapp10000"

# We first need to create an App Service Plan

New-AzAppServicePlan -ResourceGroupName $ResourceGroupName `
-Location $Location -Tier "B1" -NumberofWorkers 1 -Name $AppServicePlanName

# Then we can create the Azure Web App

New-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName `
-Location $Location -AppServicePlan $AppServicePlanName
