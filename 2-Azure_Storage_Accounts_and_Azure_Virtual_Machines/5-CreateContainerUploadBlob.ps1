<#
Command Reference
1. Get-AzStorageAccount
https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-7.3.0

2. New-AzStorageContainer
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragecontainer?view=azps-7.3.0

3. Set-AzStorageBlobContent
https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstorageblobcontent?view=azps-7.3.0

#>

# The first step is to create the storage container
$AccountName = "appstore40008989"
$ResourceGroupName="powershell-grp"
$ContainerName="data"

$StorageAccount=Get-AzStorageAccount -Name $AccountName -ResourceGroupName $ResourceGroupName

New-AzStorageContainer -Name $ContainerName -Context $StorageAccount.Context `
-Permission Blob

# The next step is to upload our blob
# Ensure that you have a sample.txt file in place

$BlobObject=@{
    FileLocation="sample.txt"
    ObjectName ="sample.txt"
}

Set-AzStorageBlobContent -Context $StorageAccount.Context -Container $ContainerName `
-File $BlobObject.FileLocation -Blob $BlobObject.ObjectName

<#
OR
Set-AzStorageBlobContent -Context $StorageAccount.Context -Container $ContainerName `
-File $BlobObject['FileLocation'] -Blob $BlobObject['ObjectName']
#>