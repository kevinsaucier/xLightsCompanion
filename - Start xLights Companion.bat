@echo off

REM Specify . as the ShowFolder to use the Script Root
IF EXIST "C:\Program Files\PowerShell\7\pwsh.exe" GOTO PowerShell7 


:PowerShell6
ECHO Execute Script Using PowerShell 6
powershell.exe -ExecutionPolicy Bypass -File "%~dp0xLights-Main.ps1" -ShowFolder ".\Test Layout"

GOTO END



:PowerShell7
ECHO Execute Script Using PowerShell 7
pwsh.exe -ExecutionPolicy Bypass -WindowStyle Minimized -File "%~dp0xLights-Main.ps1" -ShowFolder ".\Test Layout" 
GOTO END


ECHO.
ECHO Script Complete
ECHO.

:END

REM pause