$RoutePattern = Import-Csv -Path '.\Route Pattern - Numbers to Compare.csv'
$AllNumbers = Import-Csv -Path '.\All Numbers - 10 Digits Only.csv'

<#$Comparison = Compare-Worksheet `
            -Referencefile  $AllNumbers `
            -Differencefile $RoutePattern `
            -WorksheetName  "All Numbers - 10 Digits Only" `
            -Property "ROUTE PATTERN"

$Comparison | Where-Object _File -eq '.\Route Pattern - Numbers to Compare.csv'
| Select-Object "ROUTE PATTERN"
| Export-Csv '.\Microsoft Teams Numbers - Reverse Reference.csv'
#>

$CompareDis = Compare-Object `
            -ReferenceObject $AllNumbers `
            -DifferenceObject $RoutePattern `
            -Property "ROUTE PATTERN" `
            -ExcludeDifferent

$CompareDis | Export-Csv '.\Microsoft Teams Numbers.csv'