<#
.SYNOPSIS
    Script to configure Dotfiles
.DESCRIPTION
    This script sets up configuration files from this Dotfiles repository. It can also install fonts and use Winget to install applications. This script can be only run in powershell 7+ and requires Administrative privilege to run
.NOTES
    Author: Deepak N A
.LINK
    https://github.com/Deep7k/windows-dotfiles/blob/master/README.md
.EXAMPLE
    .\setup.ps1 -WithFonts
    .\setup.ps1 -WithFonts -WithOptionalApps
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [switch]
    $WithFonts,
    [Parameter(Mandatory = $false)]
    [switch]
    $WithOptionalApps
)

# Check if powershell is running as administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as an Administrator!" -ForegroundColor Red
    Exit 1
}

# Check the powershell version
$version = $PSVersionTable.PSVersion
if ($version.Major -ne 6) {
    Write-Host "This script requires PowerShell 7. The current version is $version." -ForegroundColor Red
    Exit 1
}

# Test for internet availability
function Test-InternetConnection {
    try {
        Test-Connection -ComputerName www.google.com -Count 1 -ErrorAction Stop > $null
        return $true
    }
    catch {
        Write-Error "Internet connection is required but not available. Please connect to WiFi/Ethernet."
        return $false
    }
}
if (-not (Test-InternetConnection)) {
    return 
}

# Check and install App Dependencies
Write-Host "Installing App Dependencies..."
try {
    winget install -e --accept-source-agreements --accept-package-agreements Microsoft.WindowsTerminal > $null
    winget install -e --accept-source-agreements --accept-package-agreements JanDeDobbeleer.OhMyPosh > $null
}
catch {
    Write-Error "Failed to install Dependencies. Error: $_"
}

# Install optional apps if parameter is specified
try {
    if ($WithOptionalApps) {
        Write-Host "Installing Optional Apps..."
        winget import ".\optional-apps.json" --accept-source-agreements --accept-package-agreements --ignore-versions
    }
}
catch {
    Write-Error "Failed to install Optinal apps Error: $_"
}

# Install NerdFonts which is Required for Oh-my-posh prompt and JetBrainsMono
try {
    [void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
    $fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families.Name
    
    if (($fontFamilies -notcontains "CaskaydiaCove NF") -and ($WithFonts) ) {

        Write-Host "Installing Cascadiacode NF..."
        Invoke-WebRequest -Uri "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/CascadiaCode.zip" -OutFile ".\CascadiaCode.zip"

        Expand-Archive -Path ".\CascadiaCode.zip" -DestinationPath ".\CascadiaCode" -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path ".\CascadiaCode" -Recurse -Filter "*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
                $destination.CopyHere($_.FullName, 0x10)
            }
        }
        Remove-Item -Path ".\CascadiaCode" -Recurse -Force
        Remove-Item -Path ".\CascadiaCode.zip" -Force
    }
    if (($fontFamilies -notcontains "JetBrains Mono") -and ($WithFonts) ) {

        Write-Host "Installing JetBrains Mono..."
        Invoke-WebRequest -Uri "https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip" -OutFile ".\JetBrainsMono.zip"

        Expand-Archive -Path ".\JetBrainsMono.zip" -DestinationPath ".\JetBrainsMono" -Force
        $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
        Get-ChildItem -Path ".\JetBrainsMono\fonts\ttf" -Recurse -Filter "*.ttf" -Exclude "*NL*.ttf" | ForEach-Object {
            If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
                $destination.CopyHere($_.FullName, 0x10)
            }
        }
        Remove-Item -Path ".\JetBrainsMono" -Recurse -Force
        Remove-Item -Path ".\JetBrainsMono.zip" -Force
    }
}
catch {
    Write-Error "Failed to download or install the Nerd font. Error: $_"
}

Write-Host "Configuring Dotfiles..."
$wtSettingsPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$wtSettingsTarget = (Resolve-Path "$PSScriptRoot\windows-terminal-settings.json").Path
$powershellDirPath = Join-Path ([System.Environment]::GetFolderPath('MyDocuments')) 'Powershell'
$powershellDirTarget = (Resolve-Path "$PSScriptRoot\Powershell").Path
$gitconfigPath = "$env:USERPROFILE\.gitconfig"
$gitconfigTarget = (Resolve-Path "$PSScriptRoot\gitconfig").Path
$notepadDataPath = "$env:APPDATA\Notepad++"
$notepadTarget = (Resolve-Path "$PSScriptRoot\Notepad++").Path

function BackupAndLink {
    param (
        [string]$path,
        [string]$target
    )

    if (Test-Path $path) {
        $timestamp = Get-Date -Format "yyyyMMddHHmmss"
        $backupName = $path + ".old." + $timestamp
        Rename-Item -Path $path -NewName $backupName -Force -ErrorAction Stop > $null

        Write-Host "Backup created: $backupName"
    }

    New-Item -ItemType SymbolicLink -Path $path -Target $target -ErrorAction Stop > $null
    Write-Host "Symbolic link created: $path -> $target"
}

try {
    BackupAndLink -path $wtSettingsPath -target $wtSettingsTarget
    BackupAndLink -path $powershellDirPath -target $powershellDirTarget
    BackupAndLink -path $gitconfigPath -target $gitconfigTarget
}
catch {
    Write-Error "Unable to create symlinks Error: $_"
}

Compress-Archive -Path $notepadDataPath -DestinationPath $env:APPDATA\Notepad++\ConfigBackup$(Get-Date -Format "yyyyMMddHH") -CompressionLevel Fastest
Copy-Item -Path $notepadTarget -Destination $notepadDataPath -Force

# Check and install PS Modules
Write-Host "Installing Powershell modules..."
try {
    Install-Module -Name Terminal-Icons -Repository PSGallery -Force
    Install-Module -Name posh-git -Repository PSGallery -Force
}
catch {
    Write-Error "Failed to install Terminal Icons and posh git. Error: $_"
}

Write-Host "Setup Complete. Please restart Windows Terminal for the changes to take effect"