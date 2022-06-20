<#
Command Reference

1. Get-Credential
https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-credential?view=powershell-7.2

2. Get-AzNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.network/get-aznetworkinterface?view=azps-7.3.0

3. New-AzVMConfig
https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvmconfig?view=azps-7.3.0

4. Set-AzVMOperatingSystem
https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmoperatingsystem?view=azps-7.3.0

5. Set-AzVMSourceImage
https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmsourceimage?view=azps-7.3.0

6. Add-AzVMNetworkInterface
https://docs.microsoft.com/en-us/powershell/module/az.compute/add-azvmnetworkinterface?view=azps-7.3.0

7. Set-AzVMBootDiagnostic
https://docs.microsoft.com/en-us/powershell/module/az.compute/set-azvmbootdiagnostic?view=azps-7.3.0

8. New-AzVM
https://docs.microsoft.com/en-us/powershell/module/az.compute/new-azvm?view=azps-7.3.0
#>


$VmName="appvm"
$VMSize = "Standard_DS2_v2"
$Location ="North Europe"

# If you want to get the sizes of VM's available in a particular location
# Get-AzVMSize -Location $Location

# We are asking the user to specify the credentials that will be used for the virtual machine
$Credential = Get-Credential

# We are creating a new VM Configuration
$VmConfig=New-AzVMConfig -Name $VmName -VMSize $VMSize
Set-AzVMOperatingSystem -VM $VmConfig -ComputerName $VmName `
-Credential $Credential -Windows

# Here we specify what is the source image to be used
Set-AzVMSourceImage -VM $VmConfig -PublisherName "MicrosoftWindowsServer" `
-Offer "WindowsServer" -Skus "2019-Datacenter" -Version "latest"

# We need to add the existing network interface to the configuration of the Virtual Machine
$NetworkInterfaceName="app-interface"
$NetworkInterface= Get-AzNetworkInterface -Name $NetworkInterfaceName -ResourceGroupName $ResourceGroupName
$Vm=Add-AzVMNetworkInterface -VM $VmConfig -Id $NetworkInterface.Id

# We don't want boot diagnostics
Set-AzVMBootDiagnostic -Disable -VM $Vm

# Finally we can create the virtual machine
New-AzVM -ResourceGroupName $ResourceGroupName -Location $Location `
-VM $Vm
