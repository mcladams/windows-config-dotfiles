#Requires -RunAsAdministrator

<#PSScriptInfo
 
.VERSION 1.0.1
 
.GUID b2930808-0381-4d63-b721-e94de2f7db83
 
.AUTHOR Jimmy Briggs
 
.COMPANYNAME jimbrig
 
.COPYRIGHT Jimmy Briggs | 2023
 
.TAGS Windows Drivers Cleanup Admin
 
.LICENSEURI https://github.com/jimbrig/PSScripts/blob/main/LICENSE
 
.PROJECTURI https://github.com/jimbrig/PSScripts/tree/main/Remove-OldDrivers.ps1/
 
.ICONURI
 
.EXTERNALMODULEDEPENDENCIES
 
.REQUIREDSCRIPTS
 
.EXTERNALSCRIPTDEPENDENCIES
 
.RELEASENOTES
 
  1.0.1 - Added WhatIf parameter
   
  1.0.0 - Initial Release
 
.PRIVATEDATA
 
#>

<#
 
  .DESCRIPTION
    Delete old drivers using the `Get-WindowsDriver` CmdLet.
   
  .PARAMETER Force
    Remove the drivers without prompting for confirmation.
 
  .PARAMETER WhatIf
    Show what would be removed without actually removing anything.
#> 
[CmdletBinding()]
Param(
  [Parameter()]
  [switch]$Force,
  [Parameter()]
  [switch]$WhatIf
)

$OriginalFileName = @{
  Name       = "OriginalFileName"
  Expression = { $_.OriginalFileName | Split-Path -Leaf }
}

$Date = @{
  Name       = "Date"
  Expression = { $_.Date.Tostring().Split("")[0] }
}

$AllDrivers = Get-WindowsDriver -Online -All | `
  Where-Object -FilterScript { $_.Driver -like 'oem*inf' } | `
  Select-Object -Property $OriginalFileName, Driver, ClassDescription, ProviderName, $Date, Version

Write-Verbose "`nAll installed third-party drivers" -Verbose
($AllDrivers | Sort-Object -Property ClassDescription | Format-Table -AutoSize -Wrap | Out-String).Trim()

$DriverGroups = $AllDrivers | Group-Object -Property OriginalFileName | `
  Where-Object -FilterScript { $_.Count -gt 1 }

Write-Verbose "`nDuplicate drivers" -Verbose
($DriverGroups | ForEach-Object -Process { $_.Group | Sort-Object -Property Date -Descending | Select-Object -Skip 1 } | Format-Table | Out-String).Trim()

$DriversToRemove = $DriverGroups | ForEach-Object -Process { $_.Group | Sort-Object -Property Date -Descending | Select-Object -Skip 1 }

Write-Verbose "`nDrivers to remove" -Verbose
($DriversToRemove | Sort-Object -Property ClassDescription | Format-Table | Out-String).Trim()

foreach ($item in $DriversToRemove) {
  $Name = $($item.Driver).Trim()
  Write-Verbose "Removing $Name" -Verbose
  if ($WhatIf) {
    Write-Verbose "Would remove $Name" -Verbose
    continue
  }
  if ($Force) {
    pnputil.exe /delete-driver "$Name" /force
  }
  else {
    Read-Host -Prompt "Remove $Name? (y/n)"
    if ($_.Trim().ToLower() -eq 'y') {
      Write-Verbose "Removing $Name" -Verbose
      pnputil.exe /delete-driver "$Name" /force
    }
    else {
      Write-Verbose "Skipping $Name" -Verbose
    }
  }
}
