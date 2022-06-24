
<#
Command Reference

1. Set-AzWebApp
https://docs.microsoft.com/en-us/powershell/module/az.websites/set-azwebapp?view=azps-7.3.0

#>

# We are enabling logging for an existing Azure Web App

$ResourceGroupName="powershell-grp"
$WebAppName="companyapp10000"

Set-AzWebApp -ResourceGroupName $ResourceGroupName -Name $WebAppName `
-RequestTracingEnabled $True -HttpLoggingEnabled $True `
-DetailedErrorLoggingEnabled $True
