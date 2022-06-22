<#
Command Reference

1. Get-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-7.3.0

2. Get-AzDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-7.3.0

3. Remove-AzVMDataDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmdatadisk?view=azps-7.3.0

4. Update-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-7.3.0

5. Add-AzVMDataDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmdatadisk?view=azps-7.3.0

6. Update-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-7.3.0
#>


$ResourceGroupName ="powershell-grp"

$SourceVmName="appvm1"
$DestinationVmName="appvm2"

$DataDiskName="app-disk1"
'Removing the data disk from appvm1'

$SourceVm =Get-AzVM -ResourceGroupName $ResourceGroupName -Name $SourceVmName
$DataDisk =Get-AzDisk -ResourceGroupName $ResourceGroupName -DiskName $DataDiskName

# We first remove the disk from the source VM
Remove-AzVMDataDisk -VM $SourceVm -DataDiskNames $DataDisk.Name
$SourceVm | Update-AzVM

# And then attach the disk onto the destination VM
' Lets attach the data disk onto appvm2'
$DestinationVm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $DestinationVmName

Add-AzVMDataDisk -VM $DestinationVm -Name $DataDisk.Name -Lun 0 `
-CreateOption Attach -ManagedDiskId $DataDisk.Id

$DestinationVm | Update-AzVM
