
<#
The below command-let gets information about the underlying computer system

Reference - https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-computerinfo?view=powershell-7.2

#>
Get-ComputerInfo

<#
The below command-let gets information about the underlying services running on a Windows machine

Reference - https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-7.2

#>

Get-Service -Name "App*"