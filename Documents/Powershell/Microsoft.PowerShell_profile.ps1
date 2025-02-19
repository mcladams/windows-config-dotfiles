# ensure ssh-agent will work for gcm
start-service -name ssh-agent

Set-PSResourceRepository -Name PSGallery -Trusted

# Import our modules. We can use Get-Command -module <module_name> to interrogate
# We don't have to import all modules we have collectd in $PSModulePath
$modlist="pstools"
foreach ($psmod in $modlist) {
    Import-Module $psmod
}

# aliases
Set-Alias -Name "npp" -Option "AllScope" -Scope "Global" -Value "$env:PROGRAMFILES\Notepad++\notepad++.exe"
Set-Variable -Name "EDITOR" -Option "AllScope" -Scope "Global" -Value "npp"
# Set-Variable -Name "EDITOR" -Option "AllScope" -Scope "Global" -Value "nano"

# powershell profile for dotconf git; use 'conf' not 'git' in $HOME
function conf { git --git-dir="$HOME\.conf.git\" --work-tree=$HOME $args }

<<<<<<< HEAD
# aliases
  Set-Alias -Name npp -Value "$env:PROGRAMFILES\Notepad++\notepad++.exe"
# prevent conf rm removing from working tree
  Set-Alias -Name "conf rm" -Value "conf rm --cached"
function mtime {
    param (
        [ScriptBlock]$Command
    )
    
    $executionTime = [math]::round((Measure-Command {
        & $Command
    }).TotalSeconds, 2)
    
    Write-Output "`t`t`t$executionTime s"
}
=======
# source functions
. $HOME\dot-functions.ps1

# set prompt
$installed = winget list --id JanDeDobbeleer.OhMyPosh
if ( $installed -eq "No installed package found matching input criteria." ) {
    winget install --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
}
$HOME\AppData\Programs\oh-my-posh\bin\oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression

conf status --short
>>>>>>> 7f8bcc1d944a530f17bcdc0285cfb55788e9aad8
