function Get-FSNL($TargetPath,$TargetFilter){
    $outputencoding=[console]::outputencoding
    get-childitem -file -Filter $TargetFilter -Path $TargetPath| select-Object Name | % {$.Name="・"+$_.Name;return $_;} | select-Object -expandproperty Name | clip
}