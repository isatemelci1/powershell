<#
Command Reference

1. Get-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-7.3.0

2. Update-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-7.3.0

#>

$VmName="appvm"
$ResourceGroupName="powershell-grp"
$DesiredVMSize="Standard_DS1_v2"

# First we need to get the details of our virtual machine

$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

# Then check the current Hardware profile of the virtual machine
if($Vm.HardwareProfile.VmSize -ne $DesiredVMSize)
{
    # If the size of the VM is not the desired size then go ahead and update the VM
    $Vm.HardwareProfile.VmSize=$DesiredVMSize
    $Vm | Update-AzVM
    'The size of the VM has been modified'
}
else {
    'The VM is already of the desired size'
}