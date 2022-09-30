@echo off
setlocal enabledelayedexpansion

echo Please choose a folder containing your icons.

:GETFOLDER
for /F "tokens=* usebackq" %%a in (`powershell -executionpolicy bypass -file openfiledialog.ps1`) do if not "%%a" == "Cancel" if not "%%a" == "OK" set folder=%%a
if "%folder%" == "" (call:NOTFOUND) else (call:MAKEICONS)

:MAKEICONS
echo Found folder!
call :PROMPT
exit /b

:PROMPT
choice /m "Are you sure you want to convert EVERY .PNG in this folder?"
IF "%ERRORLEVEL%" NEQ "1" (call :EXIT) else (call :CREATE)

:NOTFOUND
echo Could not get folder! Please try again...
pause
GOTO GETFOLDER

:CREATE
if not exist "%folder%"\Icons (
    echo Making icon directory in "%folder%"
    md "%folder%"\Icons
    GOTO :CHECKFORFILE
)

:CHECKFORFILE
if not exist "%folder%"\Icons (
    TIMEOUT /T 1 >nul
    GOTO CHECKFORFILE
) else (
    set icondir="%folder%"\Icons
    echo Icon directory found!
    GOTO :FILEFOUND
)

:FILEFOUND
WHERE magick >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ImageMagick is not installed! Please install it and try again.
    pause
) else (
    for %%f in ("%folder%\"*.png) do (call :CONVERTFILE "%%f")
    echo All files converted!
    pause
    EXIT
)

:CONVERTFILE
set filedir="%~d1%~1"
set filedir=!filedir:~1,-1!
magick "convert !filedir!" -define icon:auto-resize=256,128,64,48,32,16 -interpolate nearest-neighbor -filter point %icondir%\%~n1.ico >nul
echo Converted %~n1.ico successfully!