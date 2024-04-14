@echo off
title %~n0
echo %~n0.bat
echo By People smarter than me... :)


:: https://www.majorgeeks.com/content/page/show_more_options_11.html
:: https://www.elevenforum.com/t/disable-show-more-options-context-menu-in-windows-11.1589/

::Disable what has to be one of the DUMBEST W11 "features"
reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve

::Enable
:: reg delete "HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f​


timeout /t 5
exit