# WARNING: this script is incomplete
# $DOTFOLDER = <path to folder> 
# Setup notepad++
Move-Item -Path $ENV:APPDATA\Notepad++ -Destination $ENV:APPDATA\Notepad++.old
New-Item -Type SymbolicLink -Path $ENV:APPDATA\Notepad++ -Target $env:USERPROFILE\.dotfiles\Notepad++
$addPath = "C:\Program Files\Notepad++" # not working


# setup powershell 7
New-Item -Type SymbolicLink -Path $ENV:USERPROFILE\Documents\Powershell -Target $env:USERPROFILE\.dotfiles\Powershell

Unblock-File "$env:USERPROFILE\.dotfiles\Powershell\Microsoft.PowerShell_profile.ps1"
Unblock-File $env:USERPROFILE\.dotfiles\Powershell\UserScripts\removeHistDuplicates.ps1


# setup windows terminal
Move-Item -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Destination $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json.old

New-Item -Type SymbolicLink -Path $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target $env:USERPROFILE\.dotfiles\windows-terminal-settings.json

# setup vscode 
Move-Item -Path $ENV:APPDATA\Code\User\settings.json -Destination $ENV:APPDATA\Code\User\settings.json.old
New-Item -Type SymbolicLink -Path $ENV:APPDATA\Code\User\settings.json -Target $env:USERPROFILE\.dotfiles\vs-code-settings.json
code --install-extension formulahendry.code-runner
code --install-extension GitHub.github-vscode-theme
code --install-extension PKief.material-icon-theme

# setup git
Move-Item -Path $env:USERPROFILE\.gitconfig -Destination $env:USERPROFILE\.gitconfig.old
New-Item -Type SymbolicLink -Path $env:USERPROFILE\.gitconfig -Target $env:USERPROFILE\.dotfiles\.gitconfig

# winget install
winget import -i $env:USERPROFILE\.dotfiles\winget-packages.json


# to-do
# instead of linking gitconfig set it using commands in setup.ps1 (first check if git is installed if not install) and warn user that name will be the systems username
# this script must install the ps modules
# script must install app dependencies
# refactor the working of user script. remove the userscript folder and place it in scripts folder