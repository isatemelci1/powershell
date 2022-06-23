<#
Command Reference
All of the commands stay the same as for the previous scripts
#>

# Here we assume that we have a virtual machine named appvm

$VmName ="appvm"
$ResourceGroupName ="powershell-grp"
$DiskName="app-disk"
$Location="North Europe"

# We first add a data disk onto the VM

$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

$Vm | Add-AzVMDataDisk -Name $DiskName -DiskSizeInGB 16 -CreateOption Empty -Lun 0

$Vm | Update-AzVM

# Setting the Custom Script Extensions
# Here we assume that we already have a storage account in place
# and the container and the script file in the storage account

$AccountName = "vmstore40008989"
$ContainerName="scripts"

$StorageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName `
-AccountName $AccountName

$Blob=Get-AzStorageBlob -Context $StorageAccount.Context -Container $ContainerName `
-Blob "InitializeDisk.ps1"

$blobUri=@($Blob.ICloudBlob.Uri.AbsoluteUri)
$StorageAccountKey=(Get-AzStorageAccountKey -ResourceGroupName $ResourceGroupName `
-AccountName $AccountName) | Where-Object {$_.KeyName -eq "key1"}

$settings=@{"fileUris"=$blobUri}

$StorageAccountKeyValue=$StorageAccountKey.Value

$protectedSettings=@{"storageAccountName" = $AccountName;"storageAccountKey"= $StorageAccountKeyValue; `
"commandToExecute" ="powershell -ExecutionPolicy Unrestricted -File InitializeDisk.ps1"};

Set-AzVmExtension -ResourceGroupName $ResourceGroupName -Location $Location `
-VMName $VmName -Name "InitializeDisk" -Publisher "Microsoft.Compute" `
-ExtensionType "CustomScriptExtension" -TypeHandlerVersion "1.10" `
-Settings $settings -ProtectedSettings $protectedSettings

