function WelcomeTestParse {
  param (
    [OutputType([object])]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    $JsonPath
  )

  try { # Testing if JSON file exist and JSON values
    $JsonObject = Get-Content -Raw $JsonPath | ConvertFrom-Json
  } catch {
    Write-Error "Failed to read or parse JSON file at '$JsonPath'.
    $_"
  }

  try { # Test if LOGO exist and display it (LOGO uses ASCII font 'Balckie' and 'Block in two lines')
    Get-Content -Raw $JsonObject[0].path | Write-Host -ForegroundColor Cyan
  } catch {
    Write-Error "Failed to read LOGO file"
    Write-Host "
    ＺＥＬＹＮＦ  ＣＯＮＦＩＧ   
        ＤＯＴ.  ＦＩＬＥＳ
  " -ForegroundColor Cyan
  }

  return $JsonObject
}

function Get-ProgramStatus () {
  param (
    [OutputType([PSCustomObject])]
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [PSCustomObject]$programInfo
  )

  $programStatus = [PSCustomObject]@{
      Name         = $false
      IsInstalled  = $false
      IsRunning    = $false
      IsConfigured = $false
    }

  # Check if programInfo is a program
  if ( $programInfo.isprogram ) {
    $programStatus.Name = $programInfo.name
  } else {
    Write-Error 'Not a program'
    return
  }
 
  # Check if program is in PATH (is installed)
  if ( Get-Command $programInfo.cmd -ErrorAction SilentlyContinue ) {
    $programStatus.IsInstalled = $true
    if ( Get-Process $programInfo.process -ErrorAction SilentlyContinue ){
      $programStatus.IsRunning = $true
    }
  }

  # Check if programInfo config folder exists
  $programStatus.IsConfigured = $(Test-Path -Path $programInfo.winpath)

  return $programStatus
}

$programs = WelcomeTestParse './programs.json'
foreach ($item in $programs) {
  if ($item.isprogram -eq $false) { continue }
  $item = Get-ProgramStatus -programInfo $item
  Write-Host "[ $($item.name) ] " -NoNewLine
  
  if ($item.isInstalled -eq $false){
    Write-Host '[NotInstalled]' -ForegroundColor Red
    continue
  }

  Write-Host '[Installed] ' -ForegroundColor Green -NoNewLine

  if ($item.IsRunning -eq $true) {
    Write-Host '[Running] ' -ForegroundColor Red -NoNewLine
  } else {
    Write-Host '[notRunning] ' -ForegroundColor Blue -NoNewLine
  }

  if ($item.IsConfigured -eq $true) {
      Write-Host '[Configured] ' -ForegroundColor Blue
  } else {
      Write-Host '[notConfigured]' -ForegroundColor Red
  }
}

Write-Host "
1. Pull zelynfConfig files to localUser
2. Push current configuration to zelynfConfig 
3. Exit the program

This actions cannot be undone" -ForegroundColor Cyan
