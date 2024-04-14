@echo off
title %~n0 - By RickyMoose (STM)
echo. 
echo       %~n0.bat
echo                    By RickyMoose (STM)
echo.

::::::::::::::::::::::::::::::::::::::::::::
:: Automatically check & get admin rights V3.1
::::::::::::::::::::::::::::::::::::::::::::
@echo off
title %~n0

::CLS

ECHO.
ECHO =============================
ECHO Running Admin Shell
ECHO =============================

:init
setlocal DisableDelayedExpansion
set "batchPath=%~0"
for %%k in (%0) do set batchName=%%~nk
set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
ECHO.
ECHO **************************************
ECHO Invoking UAC for Privilege Escalation
ECHO **************************************

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
ECHO args = "ELEV " >> "%vbsGetPrivileges%"
ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
ECHO Next >> "%vbsGetPrivileges%"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*
title CLOSE ME - %~n0
exit 
rem /B


:gotPrivileges
setlocal & pushd .
cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

::::::::::::::::::::::::::::
::START
::::::::::::::::::::::::::::
REM Run shell as admin (example) - put here code as you like
ECHO %batchName% Arguments: %1 %2 %3 %4 %5 %6 %7 %8 %9



:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto noPrivileges )

:noPrivileges
color 47
echo %~n0 is NOT running as admin !!
timeout /t 100
ping localhost -n 2 >nul
goto top

:gotPrivileges
color 27
echo %~n0 IS running as Admin
ping localhost -n 1 >nul
color 02
:Top
echo at Top



title %~n0

if exist "Disable_Show_more_options_context_menu_for_all_users-v2.reg.bat" (
	echo RUN: Disable_Show_more_options_context_menu_for_all_users-v2.reg.bat
	start "" "Disable_Show_more_options_context_menu_for_all_users-v2.reg.bat"
	timeout /t 2
)
 
@echo off
setlocal enabledelayedexpansion
set max=0

for %%x in (winrar-x64-*.exe) do (
    set "FN=%%~nx"
    set "FN=!FN:winrar-x64-=!"
    if !FN! GTR !max! set max=!FN!
)


if not exist winrar-x64-%max%.exe (
color 47
echo.
echo.
echo ERROR: No Winrar installer found, Aborting...
echo.
echo You can download WinRAR from https://www.rarlab.com/download.htm
echo.
echo.
pause
goto end
)


echo The highest version filename is: winrar-x64-%max%.exe

echo ----- All Files -----
dir /b winrar-x64-*.exe
echo ----- All Files -----


echo DEFAULT Install in 10 seconds
choice /t 10 /D I  /c IE /m "Do you want to (I)nstall the file winrar-x64-%max%.exe or (E)xit?"
if errorlevel 2 goto end

if errorlevel 1 (

echo Proceed with installation:  winrar-x64-%max%.exe
winrar-x64-%max%.exe /s

echo Import Winrar Settings Phase 01
regedit /s Winrar_Settings.reg
timeout /t 1
regedit /s Winrar_Settings_Enable_Legacy_ContextMenus.reg
timeout /t 3

)




REM Check if the file WinRarKeys.exe exists.
REM This file is a Winrar SFX which will expand into "C:\Program Files\WinRAR\" where the key files would go.
REM If you do not create this on your own you will have to manually copy over your own files or modify this script.

if exist "WinRarKeys.exe" (
    echo.
    echo File WinRarKeys.exe found. Executing...
    rem   start "" "WinRarKeys.exe" /s -O+
    rem REMINDER: The -O+ method does not work for me so you have to add  Overwrite=1 to the sfx comments
    "WinRarKeys.exe" /s
) else (
    echo.
    echo File WinRarKeys.exe not found you will have to supply your on registration files manually.
    timeout /t 3
)


REM copy shortcut to desktop
copy  "WinRAR.exe - Shortcut.lnk" %USERPROFILE%\desktop\WinRAR.lnk


REM change WD to any other path to prevent file locks 
cd /d c:\

REM start Winrar 1 time to let it do its own 1st run reg settings
start "" "C:\Program Files\WinRAR\WinRAR.exe"
echo.
echo Get ready to kill Winrar Process
timeout /t 3
taskkill /f /im winrar.exe


REM now that winrar has modified any reg keys on 1st run - RE-Import my settings
echo Import Settings Phase 02
regedit /s Winrar_Settings.reg
regedit /s Winrar_Settings_Enable_Legacy_ContextMenus.reg
timeout /t 3


start "" "C:\Program Files\WinRAR\WinRAR.exe"

set dest=%temp%\Winrar_Install_Temp\
:: explorer.exe %dest%
if exist %dest% (
explorer.exe %temp%
)

:end
echo ============================
echo End of  %~nx0
echo Have a Happy...
echo ============================
timeout /t 10
