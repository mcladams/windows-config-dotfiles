# Setup Powershell Environment

# function to test if a command is installed
function need_command {
    param ([string]$cmdname)
    $doInstall = $true
    $command = Get-Command $cmdname -ErrorAction SilentlyContinue
    if ($command) { $doInstall = $false }
    return $doInstall
}

function install_scoop {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

if ( need_command scoop -eq $true ) { install_scoop }

# scoop install essentials
scoop install 7zip curl aria2 git-with-openssh
scoop config aria2-warning-enabled false

# note: later scoop installs of a command overwrite previous shim
scoop install busybox
scoop install gow
scoop install coreutils diffutils binutils
scoop install uutils-coreutils

# scoop buckets
scoop bucket add extras
scoop install lxrunoffline vcredist2022

# linux utils
scoop install grep sed gawk nano vim psutils
scoop install fd ripgrep bat duf dust lsd broot
scoop install delta zoxide czkawka hyperfine

#scoop install concfg
#concfg export terminal-config-backup.json

# set sudo alias from psutils and enable ssh-agent
#set-alias -Name ssudo -Value $HOME\scoop\shims\sudo.ps1
#ssudo Set-Service ssh-agent -StartupType Manual

Set-PSResourceRepository -Name PSGallery -Trusted
Install-PSResource powershellget
Install-PSResource pstools
Install-PSResource Winget
Install-PSResource Takeown
Install-PSResource RoboCopy
Install-PSResource Wsl


# oh-my-posh won't be in the current path
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
# oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression


#Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "&{Set-Location -Path $PWD; Start-Sleep -Milliseconds 500}"
#Start-Process -FilePath "powershell.exe" -ArgumentList "-NoExit", "-Command", "&{Set-Location -Path $PWD; Start-Sleep -Milliseconds 500}" -File "$HOME\windows-config-moreinstall.ps1" -Verb RunAs

$restartCommand = "pwsh.exe -NoExit -Command `"&{Set-Location -Path $PWD; Start-Process pwsh.exe -ArgumentList '-File', 'C:\Users\Mike\windows-config-moreinstall.ps1' -Verb RunAs}`""
Invoke-Expression $restartCommand
exit