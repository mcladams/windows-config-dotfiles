# ensure ssh-agent will work for gcm
try {
	start-service -name ssh-agent
}
catch {
	# install service
}

# Below causes a requirement for nuget qich f's up everythign don't us it.
#Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

Set-PSResourceRepository -Name PSGallery -Trusted

# Import our modules. We can use Get-Command -module <module_name> to interrogate
# We don't have to import all modules we have collectd in $PSModulePath
# $modlist="pstools"
# foreach ($psmod in $modlist) {
#     Import-Module $psmod
# }

# aliases
Set-Alias -Name "npp" -Option "AllScope" -Scope "Global" -Value "C:\Program Files\Notepad++\notepad++.exe"
Set-Variable -Name "EDITOR" -Option "AllScope" -Scope "Global" -Value "npp"
# Set-Variable -Name "EDITOR" -Option "AllScope" -Scope "Global" -Value "nano"

# powershell profile for dotconf git; use 'conf' not 'git' in $HOME
function conf { git --git-dir=$HOME\.conf.git\ --work-tree=$HOME $args }

# source functions
. $HOME\dot-functions.ps1

# set prompt
try {
    oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\kali.omp.json | Invoke-Expression
#    ohmy-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
#    oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\night-owl.omp.json" | Invoke-Expression
}
catch {
	winget install --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh
	oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\kali.omp.json | Invoke-Expression
}

# conf status --short
