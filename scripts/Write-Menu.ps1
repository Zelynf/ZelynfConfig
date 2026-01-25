function Write-Menu {
  param (
    [Parameter(Mandatory)]
    [System.Object[]]$options,
    [string]$exitKey = 'Q',
    [int16]$exitOption = -1
  )
  Write-Host "
    " -NoNewline
  $selected = 0 # Set selected option to 0
  $cursor = $Host.UI.RawUI.CursorPosition # Save current cursor position
  $keyPress = $null 
  # Continue when 'Enter' key is pressed
  while ($keyPress -ne 'Enter') {
    # Returns cursor to default positon
    $Host.UI.RawUI.CursorPosition = $cursor
    # Print options 
    for ($i = 0; $i -lt $options.Count; $i++) {
      if ($selected -eq $i) { # Selected option highlight
        Write-Host " > $($options[$i]) " -ForegroundColor Black -BackgroundColor Gray -NoNewline
      } else { # Non-selected option print
        Write-Host "   $($options[$i]) " -NoNewline
      }
      Write-Host '  ' -NoNewLine
    }

    # Hides KeyPress
    $endCursor = $Host.UI.RawUI.CursorPosition
    # record KeyPress
    $keyPress = [System.Console]::ReadKey().key
    $Host.UI.RawUI.CursorPosition = $endCursor
    Write-Host ' ' -NoNewline
    # Check which key is pressed
    if ($keyPress -eq 'RightArrow') { 
      if ($selected -ne $options.Count-1) {
        $selected++
      }
    } elseif ($keyPress -eq 'LeftArrow') {
      if ($selected -ne 0) {
        $selected--
      }
    } elseif ($keyPress -eq $exitKey) {
      $selected = $exitOption
      break
    }
  }
  Write-Host
  return $selected
}
