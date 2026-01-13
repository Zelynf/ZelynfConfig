. ./Write-Menu.ps1 # Import the Write-Menu function

Get-Content ./logo.txt -ErrorAction SilentlyContinue | Write-Host -ForegroundColor Cyan # Display logo

# Convert $programs into an Object
$programs = Get-Content -Raw .\programs.json -ErrorAction SilentlyContinue | ConvertFrom-Json -ErrorAction SilentlyContinue
if (-not ($programs)) { Write-Error ".\programs.json: Failed to parse file"; exit} # Prints error if JSON parse fails

foreach ($program in $programs) { # Display every program in $programs and if it's configured
    if ($program.isprogram -eq $false) { # If the item is not a program continue
        continue
      }
    Write-Host "[$($program.name)] " -NoNewLine

    if (-not (Get-Command $program.cmd -ErrorAction SilentlyContinue)) { # If the item is not installed continue
        Write-Host "[NotInstalled]" -ForegroundColor Red
        continue
      }
    Write-Host "[Installed] " -ForegroundColor Green -NoNewline

    if (Test-Path $program.winpath) { # Checks if item is configured and displays it
      Write-Host "[Configured] " -ForegroundColor Yellow -NoNewline
    } else {
      Write-Host "[notConfigured]" -ForegroundColor Green -NoNewline
      }

    if (Get-Process $program.process -ErrorAction SilentlyContinue) { #Check if item is running and displays it
        Write-Host "[Running]" -ForegroundColor Red
      } else {
        Write-Host "[notRunning]" -ForegroundColor Green 
        }
  }



$selection = Write-Menu -options @( # Options to show on the menu
  "Install Porgrams"
  "Install Config"
  "Copy Config to dotfiles" 
  "Exit"
) -exitOption 3
Write-Host
switch ($selection) {
  0 {
    foreach ($program in $programs) {
      if (-not ($program.isProgram)) { continue }
      Write-Host "Installing $($program.name)" -ForegroundColor Cyan
      winget.exe install $program.name --source winget
    }
  }
    
  1 {
      Write-Warning "This will overwrite any existing configuration and CANNOT be undone [y/N]"
      if (-not ($(Read-Host) -eq "y")) { exit(1) }

      foreach ($program in $programs) {
        if (-not ($program.isProgram)) { continue }
        Write-Host "Applying config for $($program.name)" -ForegroundColor Cyan
        Remove-Item -Path $program.winpath -Recurse -ErrorAction Ignore
        Copy-Item -Path "$($program.path)" -Destination $program.winpath -Recurse 
      }
    }
  2 {
      foreach ($program in $programs) {
        if (-not ($program.isProgram)) { continue }
        Write-Host "Starting copy for $($program.name)" -ForegroundColor Cyan
        Remove-Item -Path $program.path -Recurse -ErrorAction Ignore
        Copy-Item -Path "$($program.winpath)" -Destination $program.path -Recurse 
      }
    }
  3 { exit(0) }
  Default { Write-Host "Option wasn't specified" }
}
