$teamsList = Import-Csv -Path '.\TeamsResults.csv'
$ciscoList = Import-Csv -Path '.\CiscoResults.csv'

$CiscoandTeamsArray = @()


foreach ($item in $teamsList) {
    $person = $ciscoList | where { $item.SAMAccount -eq $_.SAMAccount `
            -and $item.TeamsNumber -ne "" `
            -and $_.CiscoNumber -ne "" }
    if ($person) {
        $HasBothNumbers = [PSCustomObject]@{
            FirstName            = $item.FirstName
            LastName             = $item.LastName
            CiscoNumber          = $person.CiscoNumber
            TeamsNumber          = $item.TeamsNumber
            Email                = $item.Email
            SAMAccount           = $item.SAMAccount
            MatchStatus          = "Match Found"
            CiscoAndTeamsNumbers = $true
        }
        $CiscoandTeamsArray += $HasBothNumbers
    }
}

$CiscoandTeamsArray | Export-Csv -Path '.\AllTeammatesCiscoTeamsPhoneNumber.csv' -Append
