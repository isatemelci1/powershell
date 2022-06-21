
<#
Command Reference

1. Get-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-7.3.0

2. Remove-AzVmDataDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvmdatadisk?view=azps-7.3.0

3. Update-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/update-azvm?view=azps-7.3.0

4. Get-AzDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/get-azdisk?view=azps-7.3.0

5. Remove-AzDisk
https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azdisk?view=azps-7.3.0

6. Get-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-7.3.0

7. Get-AzResource
https://docs.microsoft.com/en-us/powershell/module/az.resources/get-azresource?view=azps-7.3.0

8. Set-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/set-aznetworkinterface?view=azps-7.3.0

9. Remove-AzPublicIpAddress
https://docs.microsoft.com/en-us/powershell/module/az.network/remove-azpublicipaddress?view=azps-7.3.0

10. Remove-AzVm
https://docs.microsoft.com/en-us/powershell/module/az.compute/remove-azvm?view=azps-7.3.0

11. Remove-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/remove-aznetworkinterface?view=azps-7.3.0
#>

# We first need to get the details of our virtual machine
$VmName="appvm"
$ResourceGroupName="powershell-grp"

$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName
'Deleting the data disks'

# First we can delete any data disks on the machine

foreach($DataDisk in $Vm.StorageProfile.DataDisks)
{
    # We first need to delete the disk from the VM
    'Removing Data disk ' + $DataDisk.Name
    Remove-AzVmDataDisk -VM $Vm -DataDiskNames $DataDisk.Name
    $Vm | Update-AzVM

    # Then we need to get the disk and delete the disk resource itself
    Get-AzDisk -ResourceGroupName $ResourceGroupName -Name $DataDisk.Name | Remove-AzDisk -Force 

}

# Then we can delete the Public IP Addresses

' Deleting the Public IP Address'

# Lets refresh our VM object after deleting the data disks
$Vm=Get-AzVM -ResourceGroupName $ResourceGroupName -Name $VmName

foreach($Interface in $Vm.NetworkProfile.NetworkInterfaces)
{
    $NetworkInterface=Get-AzNetworkInterface -ResourceId $Interface.Id
    $PublicAddress=Get-AzResource -ResourceId $NetworkInterface.IpConfigurations.publicIPAddress.Id
    
    $NetworkInterface.IpConfigurations.publicIPAddress.Id=$null
    $NetworkInterface | Set-AzNetworkInterface
    
    'Removing Public IP address' + $PublicAddress.Name
    Remove-AzPublicIpAddress -ResourceGroupName $ResourceGroupName `
    -Name $PublicAddress.Name -Force

}

# Then we can get the details of the OS Disk
' Get a handle to the OS Disk '

$OSDisk=$Vm.StorageProfile.OsDisk

# Then we can delete the virtual machine
'Deleting the virtual machine'
Remove-AzVm -Name $VmName -ResourceGroupName $ResourceGroupName -Force

# Then we can delete the network interface
'Deleting the Network Interface'
$NetworkInterface | Remove-AzNetworkInterface -Force

# Then we can delete the OS Disk
'Delete the OS Disk'
Get-AzDisk -ResourceGroupName $ResourceGroupName -Name $OSDisk.Name | Remove-AzDisk -Force