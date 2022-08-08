$teamsList = Import-Csv -Path '.\TeamsResults.csv'
$ciscoList = Import-Csv -Path '.\CiscoResults.csv'

$CiscoandTeamsArray = @()

foreach ($person in $ciscoList) {
    foreach ($item in $teamsList) {
        if ({ $item.SAMAccount -eq $person.SAMAccount } -and { $item.TeamsNumber -ne "" } -and { $person.CiscoNumber -ne "" }) {
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
            #$HasBothNumbers
            $CiscoandTeamsArray += $HasBothNumbers
        }
    }
}

$CiscoandTeamsArray