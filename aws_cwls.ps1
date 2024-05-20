$startDateString = "20240520221000"
$endDateString = "20240522224047"

# 定义开始时间和结束时间
$startDate = [datetime]::ParseExact($startDateString, "yyyyMMddHHmmss", $null)
$endDate = [datetime]::ParseExact($endDateString, "yyyyMMddHHmmss", $null)

# 获取UNIX时间戳
$startUnixTime = [int][double]::Parse(($startDate).ToUniversalTime().Subtract((Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)
$endUnixTime = [int][double]::Parse(($endDate).ToUniversalTime().Subtract((Get-Date "1970-01-01T00:00:00Z")).TotalSeconds)

# 输出时间戳
Write-Output "Start Time (Unix): $startUnixTime"
Write-Output "End Time (Unix): $endUnixTime"

# 定义日志组名称和查询字符串
$logGroupName = "/aws/lambda/test"
#$queryString = 'filter @logStream="test" | fields @timestamp, @message | sort @timestamp desc | limit 20'
$queryString = 'fields @timestamp, @message | sort @timestamp desc | limit 5'

# 启动查询
$startQueryCommand = "aws logs start-query --log-group-name '$logGroupName' --start-time $startUnixTime --end-time $endUnixTime --query-string '$queryString'"
Write-Output $startQueryCommand
$queryResult = Invoke-Expression $startQueryCommand
$queryId = ($queryResult | ConvertFrom-Json).queryId

# 等待查询完成
Start-Sleep -Seconds 5  # 等待几秒钟以确保查询完成

# 获取查询结果
$getQueryResultsCommand = "aws logs get-query-results --query-id $queryId"
Write-Output $getQueryResultsCommand
$queryResults = Invoke-Expression $getQueryResultsCommand | ConvertFrom-Json

# 提取并转换结果
$csvData = @()
foreach ($result in $queryResults.results) {
    $obj = @{}
    foreach ($field in $result) {
        $obj[$field.field] = $field.value
    }
    $csvData += [pscustomobject]$obj
}

# 导出结果为CSV文件
$csvData | Export-Csv -Path "query_results.csv" -NoTypeInformation

# 输出CSV文件路径
Write-Output "CSV file created at: $(Get-Location)\query_results.csv"
