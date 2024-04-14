@echo off
title %~n0

echo.
echo Get ready to restart explorer shell and CD into current dir

timeout /t 20


::set cd=%cd%

taskkill /f /im explorer.exe

timeout /t 4


start "" explorer.exe 

start "" explorer.exe %CD%

