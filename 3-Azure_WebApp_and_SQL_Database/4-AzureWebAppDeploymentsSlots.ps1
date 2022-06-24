
<#
Command Reference

1. Set-AzAppServicePlan
https://docs.microsoft.com/en-us/powershell/module/az.websites/set-azappserviceplan?view=azps-7.3.0

2. New-AzWebAppSlot
https://docs.microsoft.com/en-us/powershell/module/az.websites/new-azwebappslot?view=azps-7.3.0

3. Switch-AzWebAppSlot
https://docs.microsoft.com/en-us/powershell/module/az.websites/switch-azwebappslot?view=azps-7.3.0

#>

# We are using an existing Azure Web App

$ResourceGroupName="powershell-grp"
$WebAppName="companyapp10000"
$AppServicePlanName="companyplan"

# For deployment slots, the App Service Plan needs to be standard or higher

Set-AzAppServicePlan -Name $AppServicePlanName -ResourceGroupName $ResourceGroupName `
-Tier Standard

# We then create a Web App slot

$SlotName="Staging"
New-AzWebAppSlot -Name $WebAppName -ResourceGroupName $ResourceGroupName `
-Slot $SlotName

# We then deploy an application onto the Staging slot
# Ensure to use your own GitHub URL

$Properties =@{
    repoUrl="";
    branch="master";
    isManualIntegration="true";
}

Set-AzResource -ResourceGroupName $ResourceGroupName `
-Properties $Properties -ResourceType Microsoft.Web/sites/slots/sourcecontrols `
-ResourceName $WebAppName/$SlotName/web -ApiVersion 2015-08-01 -Force

# The following can be used to switch slots

$TargetSlot="production"

Switch-AzWebAppSlot -Name $WebAppName -ResourceGroupName $ResourceGroupName `
-SourceSlotName $SlotName -DestinationSlotName $TargetSlot