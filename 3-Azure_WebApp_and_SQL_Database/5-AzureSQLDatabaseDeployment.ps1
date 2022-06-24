<#
Command Reference

1. New-AzSQLServer
https://docs.microsoft.com/en-us/powershell/module/az.sql/new-azsqlserver?view=azps-7.3.0

2. New-AzSqlDatabase
https://docs.microsoft.com/en-us/powershell/module/az.sql/new-azsqldatabase?view=azps-7.3.0

3. New-AzSqlServerFirewallRule
https://docs.microsoft.com/en-us/powershell/module/az.sql/new-azsqlserverfirewallrule?view=azps-7.3.0

4. Get-AzSqlServerServiceObjective
https://docs.microsoft.com/en-us/powershell/module/az.sql/get-azsqlserverserviceobjective?view=azps-7.3.0

#>

$ResourceGroupName="powershell-grp"

$Location="North Europe"
$ServerName="dbserver" + (New-Guid).ToString().Substring(1,6)
$AdminUser="sqladmin"
$AdminPassword="Azure@123"

$PasswordSecure=ConvertTo-SecureString -String $AdminPassword -AsPlainText -Force

$Credential = New-Object -TypeName System.Management.Automation.PSCredential `
-ArgumentList $AdminUser,$PasswordSecure

# We first need to deploy the Azure SQL Database server

New-AzSQLServer -ResourceGroupName $ResourceGroupName -ServerName $ServerName `
-Location $Location -SqlAdministratorCredentials $Credential

# Then we can deploy our database

$DatabaseName="appdb"

New-AzSqlDatabase -ResourceGroupName $ResourceGroupName -DatabaseName $DatabaseName `
-RequestedServiceObjectiveName "S0" -ServerName $ServerName

# We need to add out client IP address to the firewall so that we can connect to the database

$IPAddress=Invoke-WebRequest -uri "https://ifconfig.me/ip" | Select-Object Content

New-AzSqlServerFirewallRule -ResourceGroupName $ResourceGroupName `
-ServerName $ServerName -FirewallRuleName "Allow-Client" `
-StartIpAddress $IPAddress.Content -EndIpAddress $IPAddress.Content

# If you just want to view the different Service Level Objectives available in a location

Get-AzSqlServerServiceObjective -Location $Location