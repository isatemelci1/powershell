# Here we don't want to save the Login information
 
Disable-AzContextAutosave

# Here we are connecting to our Azure Account

Connect-AzAccount

# Here we are creating a resource group

$ResourceGroupName ="powershell-grp"
$Location = "West Europe"

New-AzResourceGroup -Name $ResourceGroupName -Location $Location
