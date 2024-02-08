$set = @{}
Get-Content $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt | %{
    if (!$set.Contains($_)) {
        $set.Add($_, $null)
        $_
    }
} | Set-Content $env:TEMP\removeHistDuplicates.tmp

Remove-Item $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

Get-Content $env:TEMP\removeHistDuplicates.tmp | Set-Content $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

Remove-Item $env:TEMP\removeHistDuplicates.tmp