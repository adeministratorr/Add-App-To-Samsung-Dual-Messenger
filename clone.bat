@echo off
setlocal enabledelayedexpansion

:: Variables
set "USER_ID=95"

:: Package list - add your desired packages here
set "PACKAGES=com.binance.dev com.ykb.android com.cloud.tr com.twitter.android"

:: Working directory for APK files
set "WORK_DIR=pulled_apks"
if not exist "%WORK_DIR%" mkdir "%WORK_DIR%"

for %%p in (%PACKAGES%) do (
    echo Processing package: %%p
    
    :: Create directory for each package
    set "PKG_DIR=%WORK_DIR%\%%p"
    if not exist "!PKG_DIR!" mkdir "!PKG_DIR!"
    
    echo 1. Pulling APKs for %%p...
    :: Extract APKs from device
    for /f "tokens=*" %%a in ('adb shell pm path %%p ^| find "package:"') do (
        set "line=%%a"
        set "line=!line:package:=!"
        for /f "tokens=*" %%b in ('echo !line! ^| find /v /n "" ^| find "[1]"') do (
            set "clean_name=%%~nxb"
        )
        echo Pulling: !line! to !PKG_DIR!\!clean_name!
        adb pull "!line!" "!PKG_DIR!\!clean_name!"
    )
    
    echo.
    echo 2. Installing APKs for %%p ^(user %USER_ID%^)...
    cd /d "!PKG_DIR!"
    
    :: Check for base.apk and split APKs
    if exist "base.apk" (
        echo Installing APKs...
        
        :: Create a list of APK files
        set "apk_files=base.apk"
        for %%f in (split_*.apk) do (
            if exist "%%f" set "apk_files=!apk_files! %%f"
        )
        
        :: Install all APKs
        echo Installing APK files...
        adb install-multiple --user %USER_ID% -r -d !apk_files!
        echo ✅ Installation completed for %%p
    ) else (
        echo ❌ base.apk not found for %%p
    )
    
    cd /d "%~dp0"
    echo ------------------------
    echo.
)

echo All packages processed!
echo Installed packages for user %USER_ID%:
adb shell pm list packages --user %USER_ID%

endlocal