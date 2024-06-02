function Get-Servers-Config {
  # Specifies a path to one or more locations.
  [Parameter(HelpMessage = "Server config file.")]
  [string]  $configPath = "./config.yml"

  return (Get-Content -Path $configPath -Raw) | ConvertFrom-Yaml
}

function Get-SQLServer-Report {
  Param(
    [Parameter(Mandatory = $True, Position = 0, HelpMessage = "Server")]
    [PSObject]  $Server
  )

  $query = @"
  SELECT * FROM DatabaseStatus
"@
  
  # Execute the query
  $report = @()
  try {
    $databases = $Server.Databases

    $databases | % {
      $results = Invoke-Sqlcmd -ServerInstance $Server.ServerName -Database $_ -Username $Server.Username -Password $Server.Password -Query $query

      # Convert results to PSObject
      $results | ForEach-Object {
        $rows = [PSCustomObject]@{
          ServerName        = $_.ServerName
          DatabaseName      = $_.DatabaseName
          State             = $_.State
          RecoveryMode      = $_.RecoveryMode
          LastFullBackup    = $_.LastFullBackup
          DaysSinceLastFull = $_.DaysSinceLastFull
          DaysSinceLastDiff = $_.DaysSinceLastDiff
        }

        $report = $report + @($rows)
      }
    }

    return $report
  }
  catch {
    Write-Host "An error occurred:" -ForegroundColor Red
    Write-Host $_.Exception.Message
  }
}