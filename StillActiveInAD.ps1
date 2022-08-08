$SAMList = Import-Csv -Path '.\FileName.csv'
$EmailList = Import-Csv -Path '.\FileName.csv'
$ADList = Import-Csv -Path '.\ADQuery.csv'

$SAMArray = @()
$EmailArray = @()

foreach ($item in $SAMList) {
    $person = $ADList | where { $item.LoginName -eq $_.SamAccountName }
    if ($person) {
        $StillActive = [PSCustomObject]@{
            FirstName       = $item.FirstName
            LastName        = $item.LastName
            Agent           = $item.Agent
            AgentID         = $item.AgentID
            LoginName       = $item.LoginName
            FinesseTeamName = $item.FinesseTeamName
            SkillTargetID   = $item.SkillTargetID
            SupervisorY     = $item.SupervisorY
            AccountActive   = $true
        }
        $StillActive
        $SAMArray += $StillActive
    }
    else {
        $NotActive = [PSCustomObject]@{
            FirstName       = $item.FirstName
            LastName        = $item.LastName
            Agent           = $item.Agent
            AgentID         = $item.AgentID
            LoginName       = $item.LoginName
            FinesseTeamName = $item.FinesseTeamName
            SkillTargetID   = $item.SkillTargetID
            SupervisorY     = $item.SupervisorY
            AccountActive   = $false
        }
        $NotActive
        $SAMArray += $NotActive
    }
}

foreach ($item in $EmailList) {
    $person = $ADList | where { $item.LoginName -eq $_.SamAccountName }
    if ($person) {
        $StillActive = [PSCustomObject]@{
            FirstName       = $item.FirstName
            LastName        = $item.LastName
            Agent           = $item.Agent
            AgentID         = $item.AgentID
            LoginName       = $item.LoginName
            FinesseTeamName = $item.FinesseTeamName
            SkillTargetID   = $item.SkillTargetID
            SupervisorY     = $item.SupervisorY
            AccountActive   = $true
        }
        $StillActive
        $EmailArray += $StillActive
    }
    else {
        $NotActive = [PSCustomObject]@{
            FirstName       = $item.FirstName
            LastName        = $item.LastName
            Agent           = $item.Agent
            AgentID         = $item.AgentID
            LoginName       = $item.LoginName
            FinesseTeamName = $item.FinesseTeamName
            SkillTargetID   = $item.SkillTargetID
            SupervisorY     = $item.SupervisorY
            AccountActive   = $false
        }
        $NotActive
        $EmailArray += $NotActive
    }
}

$SAMArray | Export-Csv -Path '.\ActiveAndInactiveUsers.csv'
$EmailArray | Export-Csv -Path '.\ActiveAndInactiveUsers.csv' -Append
