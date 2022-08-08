$ExcelFile = '.\Calabrio Clean Up- Finished.xlsx'
$ExcelSheet = 'Calabrio'
$CSVFile = '.\Users.csv'

$ImportedExcelFile = Import-Excel -path $ExcelFile -WorksheetName $ExcelSheet | Where-Object `
{ $_."Employee ID" -like $null `
        -and $_."Deactivated" -like $null}

$ImportedCSVFile = Import-Csv -Path $CSVFile

foreach ($User in $ImportedExcelFile) {
    foreach ($Data in $ImportedCSVFile) {
        If($User."Login" -eq $Data."SAMAccountName") {
            If($User."Email" -like $null){
                Write-Host $Data.mail
            }
            Else{   Write-Host $User."Email"}
        }
        elseif ($User."Email" -eq $Data."mail") {
            Write-Host $User."Email"
        }
    }

}