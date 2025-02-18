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
Set-Service ssh-agent -StartupType Manual

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

Set-PSResourceRepository -Name PSGallery -Trusted
Install-PSResource pstools
Install-PSResource Winget
Install-PSResource Takeown
Install-PSResource RoboCopy
Install-PSResource Wsl

winget install AntibodySoftware.WizTree
winget install notepad++.notepad++
winget install open-shell.open-shell-menu
winget install DEVCOM.JetBrainsMonoNerdFont
winget install JanDeDobbeleer.OhMyPosh
winget install HermannSchinagl.LinkShellExtension
winget install QL-Win.QuickLook

# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\kali.omp.json" | Invoke-Expression
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
