@echo off
title H-TWEAKS - by H1
chcp 65001 >nul

:: --- GLOBAL CONFIGURATION (IMPORTANT: CUSTOMIZE THESE PATHS!) ---
:: 1. Set the full path to your Notepad++ executable.
::    Example: set "NPP_PATH=C:\Program Files\Notepad++\notepad++.exe"
::    Make sure this path is correct for YOUR system.
set "NPP_PATH=C:\Program Files\Notepad++\notepad++.exe"

:: 2. Set the full path to the 'h1' directory.
::    This is the folder where you'll place PWRPLAN.bat, NvidiaProfileInspector.exe, etc.
::    Example: If your H-TWEAKS.bat is on your desktop, and 'h1' is next to it:
::    set "H1_TOOLS_DIR=%USERPROFILE%\Desktop\h1"
::    Adjust this to where YOUR 'h1' folder will be located.
set "H1_TOOLS_DIR=%~dp0h1"
:: The "%~dp0" variable gets the drive and path of the current batch script.
:: So, "%~dp0h1" means "the 'h1' folder located in the same directory as this script."
:: -------------------------------------------------------------


:: --- ADMIN PRIVILEGE CHECK (Ensures the main H-TWEAKS script runs as administrator) ---
:: This block checks if the script is running with elevated privileges.
:: If not, it relaunches itself with admin rights using a VBScript trick.
fsutil dirty query %SystemDrive% >nul 2>&1
if %errorlevel% NEQ 0 (
    echo.
    echo Requesting Administrator privileges for H-TWEAKS...
    echo.
    :: Relaunch the current batch script (%~s0) with 'runas' verb (triggers UAC).
    mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c ""%~s0""","","runas",1)(window.close)
    exit /b
)
:: If the script reaches this point, it means it is running with administrator privileges.
:: -----------------------------------------------------------------------------------


:: --- Change Directory to H1 Tools Folder ---
:: This command changes the current directory to where your tweak tools are.
:: It must happen *after* the admin check, as the admin check relaunches the script
:: from its original location. It includes an error check in case the directory doesn't exist.
cd "%H1_TOOLS_DIR%" || (
    echo.
    echo ERROR: Could not find the H1 tools directory: "%H1_TOOLS_DIR%"
    echo Please ensure the "h1" folder exists in the same location as this script.
    pause
    exit /b
)


:start
call :banner

:menu
echo ---------------------------------------------------
echo                    MAIN MENU
echo ---------------------------------------------------
echo.
echo :: SELECT THE TWEAK YOU DESIRE
echo.
echo 1) PWRPLAN
echo    - Applies a custom high-performance power plan for optimal system responsiveness.
echo      This can significantly improve performance in games and demanding applications.
echo.
echo 2) NvidiaProfileInspector
echo    - Opens Nvidia Profile Inspector and loads a custom profile (H1Tweaks.nip).
echo      This tool allows advanced tweaking of Nvidia driver settings for better
echo      performance or visual quality in specific games.
echo.
echo 3) Autoruns
echo    - Launches Autoruns, a powerful utility from Microsoft Sysinternals.
echo      It shows you all the programs configured to run during system startup
echo      or logon, giving you control over what loads with Windows.
echo.
echo 4) WindowsUpdateBlocker
echo    - Opens Windows Update Blocker, a tool to disable or enable automatic
echo      Windows updates. Useful for preventing unexpected updates during critical times.
echo.
echo 5) Notepad++ (Admin)
echo    - Launches Notepad++ with administrator privileges, allowing you to edit
echo      system files or perform actions requiring elevated access.
echo.
echo 6) Files Menu
echo    - Navigate to a submenu containing various system optimization files and scripts.
echo.
echo 0) Exit H1 TWEAKING UTILITY
echo.
echo :: PRESS ENTER TO CONTINUE....
echo ---------------------------------------------------
set /p input="Enter your choice: "

if /I "%input%" EQU "1" (
    :: Launch PWRPLAN.bat and import H1_POWERPLAN.pow simultaneously
    start "" PWRPLAN.bat
    start "" H1_POWERPLAN.pow
    echo.
    echo Power plan applied. Press any key to return to menu...
    pause >nul
) else if /I "%input%" EQU "2" (
    :: Launch NvidiaProfileInspector.exe and load H1Tweaks.nip simultaneously
    start "" NvidiaProfileInspector.exe
    start "" H1Tweaks.nip
    echo.
    echo Nvidia Profile Inspector launched. Press any key to return to menu...
    pause >nul
) else if /I "%input%" EQU "3" (
    :: Launch Autoruns.exe
    start "" Autoruns.exe
    echo.
    echo Autoruns launched. Press any key to return to menu...
    pause >nul
) else if /I "%input%" EQU "4" (
    :: Launch WindowsUpdateBlocker.exe
    start "" WindowsUpdateBlocker.exe
    echo.
    echo Windows Update Blocker launched. Press any key to return to menu...
    pause >nul
) else if /I "%input%" EQU "5" (
    :: Launch Notepad++ using the globally defined NPP_PATH
    start "" "%NPP_PATH%"
    echo.
    echo Notepad++ launched as administrator. Press any key to return to menu...
    pause >nul
) else if /I "%input%" EQU "6" (
    :: Go to the Files Menu submenu
    goto :files_menu
) else if /I "%input%" EQU "0" (
    :: Exit the script
    exit /b
) else (
    :: Handle invalid input
    echo.
    echo Invalid choice. Please enter a number from the menu.
    pause >nul
)

:: Clear screen and return to the main menu loop
cls
goto start


:banner
cls
echo.         ██╗  ██╗    ████████╗██╗    ██╗███████╗ █████╗ ██╗  ██╗███████╗
echo.         ██║  ██║    ╚══██╔══╝██║    ██║██╔════╝██╔══██╗██║ ██╔╝██╔════╝
echo           ███████║      ██║   ██║ █╗ ██║█████╗  ███████║█████╔╝ ███████╗
echo           ██╔══██║      ██║   ██║███╗██║██╔══╝  ██╔══██║██╔═██╗ ╚════██║
echo           ██║  ██║      ██║   ╚███╔███╔╝███████╗██║  ██║██║  ██╗███████║
echo           ╚═╝  ╚═╝      ╚═╝    ╚══╝╚══╝ ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝
echo.
echo.
pause >nul


:files_menu
cls
echo ---------------------------------------------------
echo                    FILES MENU
echo ---------------------------------------------------
echo.
echo This menu is a placeholder for your specific file-based optimizations.
echo You can add options here to:
echo - Run specific .reg files for registry tweaks (e.g., "reg import MyTweak.reg")
echo - Execute cleanup scripts (e.g., "start "" CleanTempFiles.bat")
echo - Open specific configuration files in Notepad++ (e.g., "start "" "%NPP_PATH%" "C:\Path\To\MyConfig.ini"")
echo.
echo **EXAMPLE (Uncomment and modify to use):**
echo :: 1) Run Registry Tweak X
echo ::    - Imports a .reg file to apply a specific registry modification.
echo ::      if /I "%%input%%" EQU "1" (
echo ::         reg import "MyRegistryTweak.reg"
echo ::         echo.
echo ::         echo Registry tweak applied. Press any key to return...
echo ::         pause >nul
echo ::      )
echo.
echo 9) Back to Main Menu
echo 0) Exit
echo.
echo ---------------------------------------------------
set /p input="Enter your choice: "

if /I "%input%" EQU "9" (
    :: Return to the main menu
    goto :start
) else if /I "%input%" EQU "0" (
    :: Exit the script
    exit /b
) else (
    :: Handle invalid input in the files menu
    echo.
    echo Invalid choice. Please enter a number from the menu.
    pause >nul
)
goto :files_menu