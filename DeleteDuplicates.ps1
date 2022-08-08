$finalList = Import-Csv -Path 'FileName.csv'
$duplicateList = Import-Csv -Path 'FileName2.csv'

$newCSV = @()

foreach ($item in $finalList) {
    $personToRemove = $duplicateList | where {$item.SAMAccount -eq $_.SAMAccount}
    if ($personToRemove -eq $null) {
        <# Action to perform if the condition is true #>
        $newCSV += $item
    }
}

$newCSV | Export-Csv -Path '.\DeletedDuplicates.csv'
