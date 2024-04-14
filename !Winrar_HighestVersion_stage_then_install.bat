@echo off
title %~n0 - By RickyMoose (STM)
echo. 
echo       %~n0.bat
echo                    By RickyMoose (STM)
echo.
set dest=%temp%\Winrar_Install_Temp\

echo NOTE: This script is USUALLY only needed if you are running the install 
echo from inside a VM using shared folders OR maybe from a USB key. 
echo.
echo It will copy the payload to %dest%
echo Then it will start the install process from there.
echo.
echo If you are running this payload directly from your hard drive then you can instead run: 
echo.
echo Winrar_Silent_Install-HighestVersionVariant.bat
echo. 
echo Or you can just continue from here if you like.
echo.
echo Just remember when you are done to manually clean up the temp folder:
echo %dest%
echo.

timeout /t 60


copy *.* %tempdir%
pushd %tempdir%
echo CD =  %CD%
echo DP0 =  %~dp0

timeout /t 2

:: start "" explorer.exe %dest%

mkdir %dest%
::copy *.* %dest%
robocopy /E . %dest%

pushd %dest%

 

echo what now
title %~n0

rem get out of the current Cd to prevet file locks
cd /dc:\
start "" "%dest%Winrar_Silent_Install-HighestVersionVariant.bat"
REM exit /b
exit