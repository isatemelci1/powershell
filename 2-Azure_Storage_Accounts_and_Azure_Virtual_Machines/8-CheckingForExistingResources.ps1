<#
Command Reference
1. Get-AzStorageAccount
https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-7.3.0

2. New-AzStorageAccount
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageaccount?view=azps-7.3.0

3. New-AzStorageContainer
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-7.3.0

4. Get-AzStorageContainer
https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstoragecontainer?view=azps-7.3.0

5. Set-AzStorageBlobContent
https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-7.3.0

6. Set-AzStorageBlobCont
https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-7.3.0

#>

$AccountName = "appstore40008989"
$AccountKind="StorageV2"
$AccountSKU="Standard_LRS"
$ResourceGroupName="powershell-grp"
$Location = "North Europe"


# First we are checking for the existence of the storage account
# Always a good idea to initialize the variables that are going to be used

$StorageAccount=$null
if(Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName -ErrorAction SilentlyContinue)
{
    'Storage Account already exists'
    $StorageAccount=Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName
}
else {

    'Creating the storage account'
    $StorageAccount = New-AzStorageAccount -ResourceGroupName $ResourceGroupName -Name $AccountName `
-Location $Location -Kind $AccountKind -SkuName $AccountSKU

}

# We are then checking for the existence of a container in the storage account
$ContainerName="data"
$Container=$null

if(Get-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context -ErrorAction SilentlyContinue)
{
    'Container already exists'
    $Container=Get-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context
}
else {
    'Creating the container'
    $Container=New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context `
-Permission Blob

}

# Then finally we will upload the blob object

$BlobObject=@{
    FileLocation="sample.txt"
    ObjectName ="sample.txt"
}

$Blob=$null
if(Get-AzStorageBlob -Context $StorageAccount.Context -Container $ContainerName -Blob $BlobObject.ObjectName -ErrorAction SilentlyContinue) 
{
    'Blob does exists'
    $Blob=Get-AzStorageBlob -Context $StorageAccount.Context -Container $ContainerName -Blob $BlobObject.ObjectName
}
else {
    'Creating the Blob'
    $Blob=Set-AzStorageBlobContent -Context $StorageAccount.Context -Container $ContainerName `
-File $BlobObject.FileLocation -Blob $BlobObject.ObjectName

}

