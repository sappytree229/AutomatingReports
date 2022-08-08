$ADList = Import-Csv -Path '.\IPPhone-Users.csv'
$MicrosoftTeamsList = Import-Csv -Path '.\MicrosoftNumbers.csv'
$CiscoList = Import-Csv -Path '.\CiscoNumbers.csv'

$results = @()
$badresults = @()

foreach ($user in $CiscoList) {
    foreach ($item in $ADList) {
        if ($user.DeviceName -eq $item.SAMAccountName) {
            if ($user.DirectoryNumber1 -match $item.IPPhone) {
                $matchFound = [PSCustomObject]@{
                    FirstName            = $item.givenName
                    LastName             = $item.sn
                    CiscoNumber          = $user.DirectoryNumber1
                    TeamsNumber          = ""
                    Email                = $item.mail
                    SAMAccount           = $item.SAMAccountName
                    MatchStatus          = "Match Found"
                    CiscoAndTeamsNumbers = $false
                }
                $matchFound
                $results += $matchFound
            }
            else {
                $matchNotFound = [PSCustomObject]@{
                    FirstName            = $item.givenName
                    LastName             = $item.sn
                    CiscoNumber          = $user.DirectoryNumber1
                    TeamsNumber          = ""
                    Email                = $item.mail
                    SAMAccount           = $item.SAMAccountName
                    MatchStatus          = "Not a Match"
                    CiscoAndTeamsNumbers = $false
                }
                $matchNotFound
                $badresults += $matchNotFound
            }
        }
    }
}

foreach ($person in $MicrosoftTeamsList) {
    foreach ($item in $ADList) {
        if ($person.Alias -eq $item.SAMAccountName) {
            if ($person.DN -match $item.IPPhone) {
                $matchFound = [PSCustomObject]@{
                    FirstName            = $item.givenName
                    LastName             = $item.sn
                    CiscoNumber          = ""
                    TeamsNumber          = $person.DN
                    Email                = $item.mail
                    SAMAccount           = $item.SAMAccountName
                    MatchStatus          = "Match Found"
                    CiscoAndTeamsNumbers = $false
                }
                $matchFound
                $results += $matchFound
            }
            else {
                $matchNotFound = [PSCustomObject]@{
                    FirstName            = $item.givenName
                    LastName             = $item.sn
                    CiscoNumber          = ""
                    TeamsNumber          = $person.DN
                    Email                = $item.mail
                    SAMAccount           = $item.SAMAccountName
                    MatchStatus          = "Not a Match"
                    CiscoAndTeamsNumbers = $false
                }
                $matchNotFound
                $badresults += $matchNotFound
            }
        }
    }
}

$results | Export-Csv -Path '.\AllTeammatesCiscoTeamsPhoneNumber.csv'
$badresults | Export-Csv -Path '.\AllTeammatesCiscoTeamsPhoneNumber.csv' -Append
