$NumbersThatNeedLocation = Import-csv '.\Microsoft Teams Numbers.csv'
$Locations = Import-csv '.\NumbersAndLocations.csv' 

# $CompareNumbers = Compare-Object `
#     -DifferenceObject $Locations `
#     -ReferenceObject $NumbersThatNeedLocation `
#     -IncludeEqual `
#     -ExcludeDifferent

# $ExpandedNestedArray = $CompareNumbers | Select-Object -First 10 -ExpandProperty InputObject 
# | Select-Object -Property "ROUTE PATTERN", "SideIndicator", "Location"

# Foreach ($Number in $ExpandedNestedArray) {
#     If ($Locations.Numbers -contains $Number.'Route Pattern') 
#     {   
#        $NumbersThatNeedLocation."Location" = $Locations."Location"
#     }
# }

#$CompareNumbers.Location #| Export-Csv -Path '.\Microsoft Teams Numbers With Location' -Append

$results = @()

foreach ($item in $NumbersThatNeedLocation) {
    $match = $Locations | Where { $_.Numbers -eq $item.'ROUTE PATTERN' }
   
    if($match -eq $null) {
        continue
    } 

    $result = [PSCustomObject]@{
        Number = $item.'ROUTE PATTERN'
        Location = $match.Location
    }
    
    $result
    $results += $result
}

$results | Export-CSV .\FinalResults.csv