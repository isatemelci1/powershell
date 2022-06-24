
<#
Command Reference

1. Set-AzResource
https://docs.microsoft.com/en-us/powershell/module/az.resources/set-azresource?view=azps-7.3.0

#>

# We are deploying an application from GitHub onto an existing Web App
# Ensure to use your own GitHub repository URL

$ResourceGroupName="powershell-grp"
$WebAppName="companyapp10000"

$Properties =@{
    repoUrl="";
    branch="master";
    isManualIntegration="true";
}

Set-AzResource -ResourceGroupName $ResourceGroupName `
-Properties $Properties -ResourceType Microsoft.Web/sites/sourcecontrols `
-ResourceName $WebAppName/web -ApiVersion 2015-08-01 -Force
