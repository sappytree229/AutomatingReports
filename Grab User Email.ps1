$CSVFile = '.\teammate phone extension inventory.csv'
$NameOfUserCSV = Import-Csv -path $CSVFile

foreach ($UsersName in $NameOfUserCSV) {
    $Name = $UsersName.Name

    $UserInfo = Get-ADUser -Filter {mail -eq "Marlo.Batitis@insight.com"} -Properties mail, SAMAccountName
    | Select-Object name, mail, SAMAccountName
    
}
$UserInfo