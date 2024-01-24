Import-Module -Name .\Tagesordner.psm1 -Force

function New-ResubmissionFolders {
    param (
        [Parameter(Mandatory=$true, Position=0, HelpMessage="Specify the start date.")]
        [datetime]$FromDate,

        [Parameter(Mandatory=$true, Position=1, HelpMessage="Specify the end date.")]
        [datetime]$UntilDate,

        [Parameter(Position=2, HelpMessage="Specify the start directory.")]
        [string]$StartDirectory = (Get-Location).Path
    )

    for ($date = $FromDate; $date -le $UntilDate; $date = $date.AddDays(1)) {
        $folderPath = Get-DateFolderPath -Date $date -StartDirectory $StartDirectory
        Write-Host "Datum: $date - Ordnerpfad: $folderPath"
        New-Item -ItemType Directory -Path $folderPath -Force
    }
}

$FromDate = Read-Host "Enter the start date (yyyy-MM-dd):"
$UntilDate = Read-Host "Enter the end date (yyyy-MM-dd):"

New-ResubmissionFolders -FromDate $FromDate -UntilDate $UntilDate


