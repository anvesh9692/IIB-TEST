@echo off
::set LOGFILE=D:\Work\ACE12\batch.log
::call :LOG > %LOGFILE%
::exit /B

::LOG
set FILE_PATH=C:\ProgramData\Jenkins\.jenkins\workspace\IIB-Integrations\Build\build.properties

for /f "usebackq tokens=1,2 delims==" %%A in ("%FILE_PATH%") do (
    if "%%A"=="application_name" (
        set "APPLICATION_NAME=%%B"
    )
	if "%%A"=="workspace_dir" (
        set "WORKSPACE_DIR=%%B"
    )
)
for %%I in ("%WORKSPACE_DIR%") do (
    set "REPLACED_DIR=%%~I"
)

set "REPLACED_DIR=%REPLACED_DIR:/=\%"
Set KEYWORDS_DIR=%REPLACED_DIR%\Build

echo Application Name: %APPLICATION_NAME%
echo Workspace Dir: %REPLACED_DIR%
echo BarFile Name :BAR_%APPLICATION_NAME%

copy %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.zip
powershell Expand-Archive -Path %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.zip -DestinationPath %REPLACED_DIR%\Bars\TempBar
copy %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.appzip %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip
del %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.appzip
powershell Expand-Archive -Path %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip -DestinationPath %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%
del %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip
copy %KEYWORDS_DIR%\keywords.txt %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%\META-INF\keywords.txt
powershell Compress-Archive -Path %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%\* -DestinationPath %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip
rmdir /s /q %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%
copy %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.appzip
del %REPLACED_DIR%\Bars\TempBar\%APPLICATION_NAME%.zip
powershell Compress-Archive -Path %REPLACED_DIR%\Bars\TempBar\* -DestinationPath %REPLACED_DIR%\Bars\TempBar\BAR_%APPLICATION_NAME%.zip
copy %REPLACED_DIR%\Bars\TempBar\BAR_%APPLICATION_NAME%.zip %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar
rmdir /s /q %REPLACED_DIR%\Bars\TempBar
del %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.zip
copy %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar %REPLACED_DIR%\Bars\SIT
copy %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar %REPLACED_DIR%\Bars\UAT
copy %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar %REPLACED_DIR%\Bars\PERF
copy %REPLACED_DIR%\Bars\DEV\BAR_%APPLICATION_NAME%.bar %REPLACED_DIR%\Bars\PROD
echo Version update for BAR_%APPLICATION_NAME%.bar is successful
