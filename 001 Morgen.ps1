Import-Module -Name .\PowerShell\Tagesordner.psm1 -Force

Start-Process (Get-DateFolderPath -Date (Get-Date).AddDays(1))