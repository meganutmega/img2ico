@echo off
setlocal enabledelayedexpansion

:checkmagick
where magick >nul 2>nul
if %errorlevel% neq 0 (
	choice /m "ImageMagick, which %~n0 requires to run, either isn't installed or isn't in PATH. Install now?"
	if %errorlevel% equ 1 (goto getmagick) else (
		echo %~n0 cannot run without ImageMagick. Please download and install it, then rerun.
		timeout 10
	)
) else (goto getfolder)

:getmagick
if exist "C:\Program Files" (
	powershell -command invoke-webrequest -uri https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-49-Q16-HDRI-x64-dll.exe -outfile $env:TEMP\magickinstall.exe
	echo Once ImageMagick has finished installing, press any key to exit %~n0. Then, restart %~n0 to continue.
	%temp%\magickinstall.exe
	pause >nul
) else (
	powershell -command invoke-webrequest -uri https://imagemagick.org/archive/binaries/ImageMagick-7.1.0-49-Q16-HDRI-x86-dll.exe -outfile $env:TEMP\magickinstall.exe
	echo Once ImageMagick has finished installing, press any key to exit %~n0. Then, restart %~n0 to continue.
	%temp%\magickinstall.exe
	pause >nul
)
exit /b

:getfolder
for /F "tokens=* usebackq" %%a in (`powershell -executionpolicy bypass -file openfiledialog.ps1`) do if not "%%a" == "Cancel" if not "%%a" == "OK" set folder=%%a
if "%folder%" == "" (
	echo Failed to find folder! Please try again.
	goto getfolder
) else (echo Found the folder!)

:prompt
choice /m "Are you sure you want to convert EVERY .PNG file in this folder?"
if %errorlevel% equ 2 (goto :eof) else (goto create)

:checkfiles
if not exist "%folder%\Icons" (
	echo Didn't find Icons folder!
	timeout /t 1 >nul
	goto create
) else (
	echo Found Icon folder!
	set icondir="%folder%\Icons"
	goto foundfile
)
	
:create
echo Making icon directory within "%folder%".
md "%folder%\Icons"
goto checkfiles

:foundfile
for %%f in ("%folder%\"*.png) do (call :convertfile "%%f")
echo Successfully converted all files! Thank you for using %~n0! Press any key to exit.
pause >nul
goto :eof

:convertfile
set filedir=%~d1%~1
set filedir=%filedir:~2%
set filedir="%filedir%"
magick convert %filedir% -define icon:auto-resize=256,128,64,48,32,16 -interpolate Nearest -filter point %icondir%\\"%~n1".ico >nul
if %errorlevel% equ 1 (
	echo Something went wrong when trying to convert. Please double-check your files, and run %~n0 again.
	pause
)
echo Converted %~n1.ico successfully!