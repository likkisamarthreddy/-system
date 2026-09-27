# -system

powershell -ExecutionPolicy Bypass -File "$env:USERPROFILE\Desktop\ai.ps1"


powershell -ExecutionPolicy Bypass -File "$([Environment]::GetFolderPath('Desktop'))\ai.ps1"
