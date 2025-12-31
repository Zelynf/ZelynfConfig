Remove-Item -Recurse -Force .\nvim\*
Remove-Item -Recurse -Force .\PowerShell\*
Remove-Item -Recurse -Force .\wezterm\*

Copy-Item C:\Users\xmerv\AppData\Local\nvim\* .\nvim\
Copy-Item C:\Users\xmerv\.config\wezterm\* .\wezterm\
Copy-Item C:\Users\xmerv\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 .\PowerShell\Microsoft.PowerShell_profile.ps1
