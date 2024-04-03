Import-Module -Name .\PowerShell\ResubmissionFolder-Module.psm1 -Force

Start-Process (Get-DateFolderPath -Date (Get-Date).AddDays(0))