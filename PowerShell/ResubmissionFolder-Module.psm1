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

# Wähle zwischen den beiden Funktionen Get-DateFolderPathDayOnly und Get-DateFolderPathFullDate
Function Get-DateFolderPath {
    param (
        [Parameter(Mandatory=$true)]
        [DateTime]$Date,
        [Parameter(HelpMessage="Specify the start directory.")]
        [string]$StartDirectory = (Get-Location).Path
    )
    # Switch implementation
    return Get-DateFolderPathFullDate -Date $Date -StartDirectory $StartDirectory
    #return Get-DateFolderPathDayOnly -Date $Date -StartDirectory $StartDirectory
}

Function Get-DateFolderPathDayOnly {
    param (
        [Parameter(Mandatory=$true)]
        [DateTime]$Date,
        [Parameter(HelpMessage="Specify the start directory.")]
        [string]$StartDirectory = (Get-Location).Path
    )
    $months = @("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
    $weekdays = @("Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag")

    $monthName = $months[$Date.Month - 1]
    $weekdayName = $weekdays[$Date.DayOfWeek.value__] # Add this line

    $path = "{0:yyyy}\\{0:MM} $monthName\\{0:dd} $weekdayName" -f $Date

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
    $months = @("Januar", "Februar", "März", "April", "Mai", "Juni", "Juli", "August", "September", "Oktober", "November", "Dezember")
    $weekdays = @("Sonntag", "Montag", "Dienstag", "Mittwoch", "Donnerstag", "Freitag", "Samstag")

    $monthName = $months[$Date.Month - 1]
    $weekdayName = $weekdays[$Date.DayOfWeek.value__] # Add this line

    $path = "{0:yyyy}\\{0:MM} $monthName\\{0:dd.MM.yyyy} $weekdayName" -f $Date

    $fullPath = Join-Path -Path $StartDirectory -ChildPath $path
    return $fullPath
}

# Wird in den Skripten bemnötigt, um den korrekten Ordner zu öffnen.
function Get-NextDayFolderPath {
    param(
        [Parameter(Mandatory=$true)]
        [int]$targetDayOfWeek
    )
    $currentDayOfWeek = (Get-Date).DayOfWeek.value__
    $daysToAdd = 7
    if ($currentDayOfWeek -ne $targetDayOfWeek) {   
        $daysToAdd = ($targetDayOfWeek - $currentDayOfWeek) + 7
    }
    Start-Process (Get-DateFolderPath -Date (Get-Date).AddDays($daysToAdd))
}

