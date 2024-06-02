. .\utilites.ps1
$Servers = Get-Servers-Config

$report = @()

$Servers | % {
  $report = $report + (Get-SQLServer-Report -Server $_)
}

$date_report =(Get-Date).ToString("ddMMyyyyHHmmss")
(Get-Content .\report-template.html -Raw) -replace '@@report_data@@',($report | ConvertTo-Json  -Compress) | Out-File "report_$date_report.html"