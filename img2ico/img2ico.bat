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
) else (goto choosemode)

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

:choosemode
choice /c sb /m "Would you like to convert a single image, or a whole folder in bulk? [S]INGLE, [B]ULK"
if %errorlevel% equ 1 (
	goto getfile
)
if %errorlevel% equ 2 (
	goto getfolder
)

:getfile
for /F "tokens=* usebackq" %%a in (`powershell -executionpolicy bypass -file openfiledialog.ps1`) do if not "%%a" == "Cancel" if not "%%a" == "OK" set file=%%a
if "%file%" == "" (
	echo Failed to find file! Please try again.
	goto getfile
) else (
	echo File found.
	goto promptsingle
)

:getfolder
for /F "tokens=* usebackq" %%a in (`powershell -executionpolicy bypass -file openfolderdialog.ps1`) do if not "%%a" == "Cancel" if not "%%a" == "OK" set folder=%%a
if "%folder%" == "" (
	echo Failed to find folder! Please try again.
	goto getfolder
) else (
	echo Found your folder.
	goto getext
)

:getext
choice /c pjs /m "What file type do you want to convert from? [P]NG, [J]PG, [S]VG"
if %errorlevel% equ 1 (
	set fileext="png"
)
if %errorlevel% equ 2 (
	set fileext="jpg"
)
if %errorlevel% equ 3 (
	set fileext="svg"
)
goto promptbulk

:promptbulk
choice /m "Are you ready to convert these files? It'll be in an Icons folder where you specified."
if %errorlevel% equ 2 (goto choosemode) else (goto createbulk)

:promptsingle
choice /m "Are you ready to convert this file? It'll be in the same folder as the original file."
if %errorlevel% equ 2 (goto choosemode) else (goto createsingle)

:checkfilesinfolder
if not exist "%folder%\Icons" (
	echo Didn't find Icons folder!
	timeout /t 1 >nul
	goto createbulk
) else (
	echo Found Icon folder!
	set icondir="%folder%\Icons"
	goto foundfiles
)
	
:createbulk
echo Making icon directory within "%folder%".
md "%folder%\Icons"
goto checkfilesinfolder

:createsingle
echo Creating icon file...
set absolutefiledir=%file%\\..
set absolutefiledir="%absolutefiledir%"
call :convertfile "%file%" %absolutefiledir%
goto finished

:finished
choice /c ce /m "[C]onvert more files, or [e]xit?"
if %errorlevel% equ 1 (
	goto choosemode
)
if %errorlevel% equ 2 (
	goto thankyouprompt
)

:foundfiles
for %%f in ("%folder%\"*.%fileext%) do (call :convertfile "%%f" %icondir%)
goto finished

:thankyouprompt
echo Successfully converted all files. Thank you for using %~n0^^! Press any key to exit.
pause >nul
goto :eof

:convertfile
set filedir=%~d1%~1
set filedir=%filedir:~2%
set filedir="%filedir%"
magick convert %filedir% -define icon:auto-resize=256,180,128,96,72,64,48,32,24,16 -interpolate Nearest -filter point "%~2"\\"%~n1".ico >nul
if %errorlevel% equ 1 (
	echo Something went wrong when trying to convert. Please double-check your files, and run %~n0 again.
	pause
)
echo Converted %~n1.ico successfully!