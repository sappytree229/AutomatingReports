$OriginalFile = '.\Calabrio Clean Up.xlsx'
$EditedFile   = '.\Calabrio Clean Up- Finished.xlsx'

$Comparison = Compare-Worksheet `
        -Referencefile $OriginalFile `
        -Differencefile $EditedFile `
        -WorksheetName 'Calabrio' `
        -Property "First Name", "Last Name", "Employee ID", "Email", "Login", "Deactivated", "User ID", "Display Time Zone", "Team", "Is Reconcile Only", "Activated", "Roles"

$Comparison | Where-Object {$_._Side -eq '=>' `
                            -and $_.Deactivated -eq '' `
                            -and $_."Employee ID" -ne '' `
                            -and $_.Email -ne '' `
                            -and $_.Login -ne ''} 
                            | Select-Object `
                            "Employee ID", `
                            "User ID", `
                            "Email", `
                            "First Name", `
                            "Last Name", `
                            "Login", `
                            "Team", `
                            "Roles"
                            | Export-Csv '.\ChangedRecords.csv'


