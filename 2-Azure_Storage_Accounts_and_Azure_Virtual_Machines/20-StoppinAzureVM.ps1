<#
Command Reference

1. Get-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-7.3.0

2. Stop-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/stop-azvm?view=azps-7.3.0

#>

$VmName="appvm"
$ResourceGroupName="powershell-grp"

# First get the statuses assigned to the Azure Virtual Machine

$Statuses=(Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Status).Statuses

if($Statuses[1].Code -eq "PowerState/running")
{
    # If the VM is still in the running state then go ahead and stop the VM
    'Shutting down the virtual machine'
    Stop-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName -Force
}
else {
    'The machine is not in the running state'
}