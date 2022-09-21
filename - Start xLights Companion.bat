@echo off

REM Specify . as the ShowFolder to use the Script Root
pwsh.exe -ExecutionPolicy Bypass -File "%~dp0xLights-Main.ps1" -ShowFolder ".\Test Layout"

REM pause