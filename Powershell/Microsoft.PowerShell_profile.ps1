# Set PowerShell encoding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#######################################################
# Prompt Configuration
#######################################################

oh-my-posh --init --shell pwsh --config "$env:USERPROFILE\Documents\Powershell\oh-my-posh\BlueOwlNew.json" | Invoke-Expression

#######################################################
# Modules
#######################################################

Import-Module -Name Terminal-Icons
Import-Module -Name posh-git

#######################################################
# PSReadLine Configuration
#######################################################

Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ShellForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function ShellBackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function ShellBackwardKillWord
Set-PSReadLineOption -HistoryNoDuplicates:$True

#######################################################
# Aliases
#######################################################

Set-Alias npp 'notepad++'
Set-Alias ping Test-Connection
Set-Alias wget Invoke-WebRequest
New-Alias -Name iamhere -Value Send-Keystrokes

#######################################################
# Environment Variables
#######################################################

$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

#######################################################
# Autocomplete configurations
#######################################################

Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

#######################################################
# Custom Functions
#######################################################

function Send-Keystrokes {
  param (
    [switch]$Verbose = $false,
    [int]$KeystrokeInterval = 40,
    [int]$Until = 0
  )
  
  $wsh = New-Object -ComObject WScript.Shell
  $endTime = if ($Until -gt 0) { (Get-Date).AddMinutes($Until) } else { $null }
  
  while ($true) {
    if ($endTime -and (Get-Date) -ge $endTime) { break }
    if ($Verbose) {
      Write-Host "Sending keystroke at $(Get-Date -Format 'HH:mm:ss')"
    }
    $wsh.SendKeys('+{F15}')
    Start-Sleep -Seconds $KeystrokeInterval
  }
}
