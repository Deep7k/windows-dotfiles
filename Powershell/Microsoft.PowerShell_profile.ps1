# Set PowerShell encoding to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# Prompt Configuration
$MyDocuments = [Environment]::GetFolderPath("MyDocuments")
oh-my-posh --init --shell pwsh --config "$MyDocuments\Powershell\oh-my-posh\catppuccin_mocha.omp.json" | Invoke-Expression

# Import modules
Import-Module -Name Terminal-Icons
Import-Module -Name posh-git
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# PSReadLine Configuration
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key Ctrl+RightArrow -Function ShellForwardWord
Set-PSReadLineKeyHandler -Key Ctrl+LeftArrow -Function ShellBackwardWord
Set-PSReadLineKeyHandler -Key Ctrl+Backspace -Function ShellBackwardKillWord
Set-PSReadLineOption -HistoryNoDuplicates:$True

# Aliases
Set-Alias npp 'C:\Program Files\Notepad++\notepad++.exe'
Set-Alias wget Invoke-WebRequest
New-Alias -Name iamhere -Value Send-Keystroke

# Environment Variables
$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Autocomplete configurations for winget
Register-ArgumentCompleter -Native -CommandName winget -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  [Console]::InputEncoding = [Console]::OutputEncoding = $OutputEncoding = [System.Text.Utf8Encoding]::new()
  $Local:word = $wordToComplete.Replace('"', '""')
  $Local:ast = $commandAst.ToString().Replace('"', '""')
  winget complete --word="$Local:word" --commandline "$Local:ast" --position $cursorPosition | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# Custom Functions
function Send-Keystroke {
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
