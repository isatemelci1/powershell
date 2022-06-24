<#
Command Reference

1. Get-AzSqlServer
https://docs.microsoft.com/en-us/powershell/module/az.sql/get-azsqlserver?view=azps-7.3.0

2. Invoke-SqlCmd
https://docs.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps

#>

$ResourceGroupName="powershell-grp"
$DatabaseName="appdb"

$AdminUser="sqladmin"
$AdminPassword="Azure@123"

# We want to get the full qualified server name to connect to

$ServerFQDN=$null

$SQLServers=Get-AzSqlServer -ResourceGroupName $ResourceGroupName

foreach($SQLServer in $SQLServers)
{
    if(($SQLServer.ServerName.Contains("dbserver")))
    {
        $ServerFQDN=$SQLServer.FullyQualifiedDomainName
        'The Servers FQDN is ' + $ServerFQDN
    }
}

# Install the Module prior - Install-Module -Name SqlServer
# Install-Module -Name SqlServer
# We can use Invoke-SqlCmd to run the script file

$ScriptFile="init.sql"

Invoke-SqlCmd -ServerInstance $ServerFQDN -Database $DatabaseName `
-Username $AdminUser -Password $AdminPassword -InputFile $ScriptFile