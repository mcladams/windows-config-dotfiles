# should be running elevated so
Set-Service ssh-agent -StartupType Manual

curl -O https://github.com/microsoft/cascadia-code/releases/download/v2407.24/CascadiaCode-2407.24.zip
unzip CascadiaCode-2407.24.zip

# Default
winget install hickford.git-credential-oauth
winget install --scope machine AntibodySoftware.WizTree
winget install notepad++.notepad++
winget install --scope machine open-shell.open-shell-menu
#winget install --scope machine DEVCOM.JetBrainsMonoNerdFont

winget install --scope machine HermannSchinagl.LinkShellExtension
winget install QL-Win.QuickLook

# Multimedia
winget install qbittorrent.qbittorrent
winget install XnSoft.XnView.Classic
#winget install ShareX.ShareX
winget install VideoLAN.VLC
#winget install --scope machine Gyan.FFmpeg

# Dev stuff
#winget install DevToys-app.DevToys
#winget install Microsoft.Sysinternals.PsTools
#winget install Github.cli
winget install Microsoft.PowerToys
#winget install --scope machine CodingWondersSoftware.DISMTools.Stable
#winget install --scope machine AutomatedLab.AutomatedLab

# Music stuff
#winget install --scope machine Soulseek.SoulseekQt
winget install lame.lame
winget install PeterPawlowski.foobar2000
winget install PeterPawlowski.foobar2000.EncoderPack
winget install --scope machine FlorianHeidenreich.Mp3tag

# Gaming
#winget install --scope machine Valve.Steam
#winget install --scope machine Dischord

# Utilities
#winget install --scope machine DominikReichl.KeePass
#winget install --scope machine KeePassXCTeam.KeePassXC
