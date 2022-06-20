<#
Command Reference

1. Get-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-7.3.0

2. Add-AzVMDataDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmdatadisk?view=azps-7.3.0

3. Update-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-7.3.0

#>
$VmName ="appvm"
$ResourceGroupName ="powershell-grp"
$DiskName="app-disk"

# First we need to get the details of our virtual machine

$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

# Then we add the data disk
$Vm | Add-AzVMDataDisk -Name $DiskName -DiskSizeInGB 16 -CreateOption Empty -Lun 0

# We need to update the virtual machine with the data disk
$Vm | Update-AzVM

