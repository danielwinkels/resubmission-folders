$FromDate = Get-Date "2024-01-01"
$UntilDate = Get-Date "2029-12-31"
# Encoding is Windows 1252 (März)
# Set the encoding to UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::InputEncoding = [System.Text.Encoding]::UTF8

Function Get-DateFolderPath {
    param (
        [Parameter(Mandatory=$true)]
        [DateTime]$Date,
        [Parameter(HelpMessage="Specify the start directory.")]
        [string]$StartDirectory = (Get-Location).Path
    )
    
    $months = @("Januar", "Februar", "M�rz", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
    $weekdays = @("Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag")

    $monthName = $months[$Date.Month - 1]
    $weekdayName = $weekdays[$Date.DayOfWeek.value__] # Add this line

    Write-Debug "Month: $monthName"

    $path = "{0:yyyy}\{0:MM} $monthName\{0:dd} $weekdayName" -f $Date

    $fullPath = Join-Path -Path $StartDirectory -ChildPath $path
    return $fullPath
}

Function Get-DateFolderPathFullDate {
    param (
        [Parameter(Mandatory=$true)]
        [DateTime]$Date,
        [Parameter(HelpMessage="Specify the start directory.")]
        [string]$StartDirectory = (Get-Location).Path
    )
    $months = @("Januar", "Februar", "M�rz", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
    $weekdays = @("Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag")

    $monthName = $months[$Date.Month - 1]
    $weekdayName = $weekdays[$Date.DayOfWeek.value__] # Add this line

    $path = "{0:yyyy}\{0:MM} $monthName\{0:dd.MM.yyyy} $weekdayName" -f $Date

    $fullPath = Join-Path -Path $StartDirectory -ChildPath $path
    return $fullPath
}

for ($date = $FromDate; $date -le $UntilDate; $date = $date.AddDays(1)) {
    $originalPath = Get-DateFolderPath $date
    $newPath = Get-DateFolderPathFullDate $date
    if (Test-Path $newPath) {
        continue
    } else {
        Rename-Item -Path $originalPath -NewName $newPath
        Write-Host "$originalPath -> $newPath"
    }
}

