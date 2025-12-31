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
Write-Host "
  " # Break line for readeability

$option = @( # Options to show on the menu
  "Install Porgrams (1)"
  "Install Config (2)"
  "Pull Config to Repo (3)"
  "Exit (Q)"
)

$KeyPress = $null # Variable to register KeyPress
$temp = $null # Temporal variable to store last keypress
$pos = $Host.UI.RawUI.CursorPosition # Stores current cursor position
$allowedKeys = @($null) # Variable to store which keys are allowed to be pressed


for ($i = 1; $i -lt $option.Count+1; $i++) { # Adds allowed keypresses from $options.Count
  $allowedKeys += "D$i"
}
while (-not ($KeyPress.key -eq "Q")) { # Displays options (exit when 'Q' is pressed)
  $Host.UI.RawUI.CursorPosition = @{X=0; Y=$pos.Y - 1} # Reset cursor position
  if (-not ($KeyPress.key -in $allowedKeys)) { # Checks if the key is allowed 
    $KeyPress = $temp # Restores to previos key
    continue
  }
  for ($i = 1; $i -lt $option.Count+1; $i++) { # Displays options 
    if ($KeyPress.key -eq "D$i") { # Display selected option
      Write-Host " > $($option[$i-1]) " -ForegroundColor Black -BackgroundColor Gray -NoNewline
    } else { # Display non selected options
      Write-Host "   $($option[$i-1]) " -NoNewLine
    }
    Write-Host "  " -NoNewline
  }
    $temp = $KeyPress
    $KeyPress = [System.Console]::ReadKey() # Reads the user's keypress 
    Write-Host ""
}
