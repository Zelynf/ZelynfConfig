#2025 Made by Zelynf and DeepSeek (R1).

# Terminal title to "PowerShell"
$host.ui.rawui.windowtitle = "PowerShell"

# Zoxide Implementation (init)
# try {
#     Invoke-Expression (& { (zoxide init powershell | Out-String) })
# } catch { 
#     Write-Host "Zoxide init: Failed"
# }

function prompt {
    # Cached user/identity check
    if (-not $script:cachedUser) {
        $script:cachedUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    }
    $IsAdmin = [Security.Principal.WindowsPrincipal]::new($script:cachedUser).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $CmdPromptUser = $script:cachedUser.Name.Split("\")[1]
    $user = whoami

    # Robust path handling
    try {
        $currentPath = (Get-Location).Path.TrimEnd('\')
        $homePath = $env:USERPROFILE.TrimEnd('\')
    }
    catch {
        $currentPath = $pwd.Path.TrimEnd('\')
    }

    # Decorate the prompt
    Write-Host "╭─(" -ForegroundColor DarkGray -NoNewLine
    Write-Host "$user" -ForegroundColor White -NoNewline 
    Write-Host ")─" -ForegroundColor DarkGray -NoNewLine
    if ($IsAdmin) {
	Write-Host "#" -ForegroundColor Yellow -NoNewLine
	Write-Host "─" -ForegroundColor DarkGray -NoNewLine
    }
    Write-Host "[" -ForegroundColor DarkGray -NoNewLine

    # Path display logic
    if ($currentPath -like '\\*') {
        Write-Host "$currentPath\" -ForegroundColor Cyan -NoNewline  # UNC path
    }
    elseif ($currentPath -eq $homePath -or $currentPath -eq (Resolve-Path $homePath -ErrorAction SilentlyContinue).Path.TrimEnd('\')) {
        Write-Host "~\" -ForegroundColor White -NoNewline
    }
    elseif ($currentPath.StartsWith($homePath + '\')) {
        $relativePath = $currentPath.Substring($homePath.Length + 1)
        Write-Host "~\$relativePath\" -ForegroundColor White -NoNewline
    }
    else {
        Write-Host "$currentPath\" -ForegroundColor Cyan -NoNewline
    }

    # Prompt decoration
    Write-Host "]" -ForegroundColor DarkGray
    Write-Host "╰─" -ForegroundColor DarkGray -NoNewLine
    Write-Host ' >' -ForegroundColor White -NoNewLine
    return " "
}
