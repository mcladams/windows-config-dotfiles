function CompactAll_Vhd {
    # check if search locations given in args, otherwise find valid local drives
    if ($args.Count -eq 0) {
        $drives = Get-PSDrive -PSProvider FileSystem | Where-Object { `
          $_.Root -match '^[A-Z]:\\$' }
        $args = ($drives.Root) -join ' '
    }
     Write-Host "args are $args"
	 # find all the vhdx files using fd-find fd.exe (scoop install fd)
    $vhdpaths = fd.exe -H -a -i -tf -g *.vhdx $args
    foreach ($vhdx in $vhdpaths) {
        Write-Host "Processing $vhdx... "
        if ( $(fsutil sparse queryFlag $vhdx) -eq "This file is set as sparse" ) {
            $sparseVhds += $vhdx + " "
            fsutil sparse setFlag $vhdx 0
            Write-Host "Unset sparse flag. "
        }
        [int]$origSize= (Get-Item -Path $vhdx).Length
        Optimize-Vhd -Path $vhdx -Mode Full
        [int]$newSize= (Get-Item -Path $vhdx).Length
		$sizeGB = [math]::round($newSize / 1GB, 2)
        [int]$cRatio = $origSize * 100 / $newSize
        Write-Host "Size $sizeGB GB, compessed $cRatio %"
    }
}