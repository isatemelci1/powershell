<#
Command Reference

1. Invoke-WebRequest
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-7.2

#>

$Uri ="https://azure.microsoft.com/en-us/account/"

$Request=Invoke-WebRequest -Uri $Uri

'The status code is ' + $Request.StatusCode

$Request.Content
