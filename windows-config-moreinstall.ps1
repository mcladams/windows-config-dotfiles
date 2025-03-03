# should be running elevated so
Set-Service ssh-agent -StartupType Manual

# Default
winget install --scope machine hickford.git-credential-oauth
winget install --scope machine AntibodySoftware.WizTree
winget install --scope machine notepad++.notepad++
winget install --scope machine open-shell.open-shell-menu
winget install --scope machine DEVCOM.JetBrainsMonoNerdFont
winget install --scope machine JanDeDobbeleer.OhMyPosh
winget install --scope machine HermannSchinagl.LinkShellExtension
winget install --scope machine QL-Win.QuickLook

# Multimedia
winget install --scope machine qbittorrent.qbittorrent
winget install --scope machine XnSoft.XnView.Classic
winget install --scope machine ShareX.ShareX
winget install --scope machine VideoLAN.VLC
winget install --scope machine Gyan.FFmpeg

# Dev stuff
winget install --scope machine DevToys-app.DevToys
winget install --scope machine Microsoft.Sysinternals.PsTools
winget install --scope machine Github.cli
winget install --scope machine Microsoft.PowerToys
#winget install --scope machine CodingWondersSoftware.DISMTools.Stable
#winget install --scope machine AutomatedLab.AutomatedLab

# Music stuff
#winget install --scope machine Soulseek.SoulseekQt
#winget install --scope machine PeterPawlowski.foobar2000
#winget install --scope machine PeterPawlowski.foobar2000.EncoderPack
#winget install --scope machine FlorianHeidenreich.Mp3tag

# Gaming
#winget install --scope machine Valve.Steam
#winget install --scope machine Dischord

# Utilities
#winget install --scope machine DominikReichl.KeePass
#winget install --scope machine KeePassXCTeam.KeePassXC
