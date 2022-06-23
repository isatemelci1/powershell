$Disk = Get-Disk | Where-Object PartitionStyle -eq 'RAW'

$InitializedDisk = Initialize-Disk -Number $Disk.Number `
-PartitionStyle MBR -PassThru

$Partition = New-Partition -DiskNumber $Disk.Number `
-UseMaximumSize -DriveLetter F

Format-Volume -Partition $Partition -FileSystem NTFS `
-NewFileSystemLabel "Data" -Force -Confirm:$false