<#
Command Reference
1. Get-AzStorageAccount
https://docs.microsoft.com/en-us/powershell/module/az.storage/get-azstorageaccount?view=azps-7.3.0

2. New-AzStorageShare
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstorageshare?view=azps-7.3.0

3. New-AzStorageDirectory
https://docs.microsoft.com/en-us/powershell/module/az.storage/new-azstoragedirectory?view=azps-7.3.0

4. Set-AzStorageFileContent
https://docs.microsoft.com/en-us/powershell/module/az.storage/set-azstoragefilecontent?view=azps-7.3.0

#>

# We are first going to retrieve the details of our existing storage account

$AccountName = "appstore40008989"
$ResourceGroupName="powershell-grp"

$StorageAccount = Get-AzStorageAccount -Name $AccountName `
-ResourceGroupName $ResourceGroupName

# We are constructing an object on the concept of splatting

$FileShareConfig=@{
    Context=$StorageAccount.Context
    Name ="data"
}

# And create the file share

New-AzStorageShare @FileShareConfig

# Then we are going to create a directory in the file share

$DirectoryDetails=@{
    Context=$StorageAccount.Context
    ShareName = "data"
    Path="files"
}


New-AzStorageDirectory @DirectoryDetails

# Finally we will upload a file to the file share

$FileDetails=@{
    Context=$StorageAccount.Context
    ShareName = "data"
    Source="sample.txt"
    Path="/files/sample.txt"
}

Set-AzStorageFileContent @FileDetails