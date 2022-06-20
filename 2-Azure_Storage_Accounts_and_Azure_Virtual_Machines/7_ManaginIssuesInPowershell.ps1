$ResourceGroupName="powershell-grp"
$AccountName="demoaccount203040"
$Location="North Europe"

$StorageAccount=New-AzStorageAccount -ResourceGroupName $ResourceGroupName `
-Name $AccountName -Location $Location -SkuName 'Standard_LRS' `
-Kind "StorageV2" -Debug 

$StorageAccount=Get-AzStorageAccount -ResourceGroupName $ResourceGroupName `
-Name $AccountName