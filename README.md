# Automated Custom WinRAR setup with Legacy Context Menus Enabled for Windows 11

By Ricky Moose (STM)

This READ ME will illustrate the process of performing a WinRAR silent install with the custom settings that I use. Under Windows 11 we have the new and **LESS** **improved** “**show more options**” context menu.   
This automation will install WinRAR using the **LEGACY context menus** option along with some custom entries like **RAR with DATE**.


EG:
![image](https://github.com/RickeyMoose/CustomWinRarSetup-01/assets/167007057/cda4134b-fb4e-4990-a51b-c105d20c821b)


In the WinRAR GUI you would set these manually via these 2 options:
![image](https://github.com/RickeyMoose/CustomWinRarSetup-01/assets/167007057/72492283-f2cb-40cb-912c-b5e662a87b38)


There are 2 main bat files you can run. Because my normal use case is running this install from within a VM via shared folders. and because of a VMware security limitation there is the file staging bat file called: “**!Winrar_HighestVersion_stage_then_install.bat**” which is used to stage the files to **%temp%** folder on my VM and then will run the primary file “**Winrar_Silent_Install-HighestVersionVariant.bat**” which one you run to kick off the process is up to you as they essentially have the same end result but the stager is required as a VM workaround. Under the VM, if I had instead just copied the payload to the desktop for example I could have skipped using the stager bat file.

The primary file requires elevation to import registry keys and will attempt to self-elevate, you will need to allow the UAC warning if your UAC is enabled.

![image](https://github.com/RickeyMoose/CustomWinRarSetup-01/assets/167007057/c71e13a0-699d-4e70-9363-da62216e2826)



Once the process starts, it will scan the current directory for the most current build of WinRAR, you will see in the example I have 3 versions with 7.0 being the most current. If for some reason I had these files and wanted a different version like 6.24 I could simply rename any of the higher builds to exclude them from **winrar-x64-\*.exe.**

You will then be given a 10 second warning on what build the script will install, then the custom settings that I use will get imported via the files:

**Winrar_Settings.reg** and **Winrar_Settings_Enable_Legacy_ContextMenus.reg**

The Legacy reg file is meant for Windows 11, so if you are not using win11 just rename the file to skip importing it.

Moving on, WinRAR will get ran one time to allow it to do any 1st time run setup and will then be closed after a few seconds. Afterwards the custom registry files will be imported a 2nd time to re-apply any changes that WinRAR may have modified on 1st run such as the context menu settings.

Because I used the stager, it will then open **%temp%** so that you can manually delete the staged files if you so choose to do.

**NOTE:** If after the install you notice that the “**show more options**” context menu is still enabled for example when you right click on your desktop but not in the temp folder that opens at the end of the process, to fix this you will need to reboot OR you can run the file “**RestartExplorerShell_And_CD.cmd**” to apply the settings everywhere without rebooting.

Enjoy!!!



File list:

![image](https://github.com/RickeyMoose/CustomWinRarSetup-01/assets/167007057/eb177fe2-2caa-484d-84f4-0dc24bb6d5fc)


**IMPORTANT: You will need to download your own WinRAR binary files from** <https://www.rarlab.com/download.htm> like in the above example. The script only knows to look for x64 so you will have to modify if using 32bit builds but then you are not using Win 11 at that point.

EG: **winrar-x32-700.exe** VS **winrar-x64-700.exe**

EOF


