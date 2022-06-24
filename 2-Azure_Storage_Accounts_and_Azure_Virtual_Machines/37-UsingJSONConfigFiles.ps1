
# We first define a parameter to take the environment name from the user
param(

[Parameter(Mandatory=$true)]
[string]$Environment
)

$Object=Get-Content -Raw -Path "Config.json" | ConvertFrom-Json

# We can offhand set all of our variables

$VirtualNetworkName=$null
$VirtualNetworkAddressSpace=$null
$SubnetNames=@()
$SubnetIPAddressSpace=@()

# About the switch statement
# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_switch?view=powershell-7.2

switch($Environment)
{
    "Development"
    {
        $VirtualNetworkName=$Object.Development.VirtualNetwork.Name
        $VirtualNetworkAddressSpace=$Object.Development.VirtualNetwork.AddressSpace
        $SubnetNames+=$Object.Development.Subnets.Name
        $SubnetIPAddressSpace+=$Object.Development.Subnets.AddressSpace
    }

    "Staging"
    {
        $VirtualNetworkName=$Object.Staging.VirtualNetwork.Name
        $VirtualNetworkAddressSpace=$Object.Staging.VirtualNetwork.AddressSpace
        $SubnetNames+=$Object.Staging.Subnets.Name
        $SubnetIPAddressSpace+=$Object.Staging.Subnets.AddressSpace

    }
}

# We can then create our resources accordingly

$Subnet=@()
$Count=$SubnetNames.Count
for($i=1;$i -le $Count;$i++)
{
    $Subnet+=New-AzVirtualNetworkSubnetConfig -Name $SubnetNames[$i-1] `
    -AddressPrefix $SubnetIPAddressSpace[$i-1]
}

$ResourceGroupName="powershell-grp"
$Location="North Europe"

New-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName `
-Location $Location -AddressPrefix $VirtualNetworkAddressSpace -Subnet $Subnet


