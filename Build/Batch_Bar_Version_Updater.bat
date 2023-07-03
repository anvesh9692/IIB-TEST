@echo off
Set AppName=APP_EMPLOYEE_DETAILS
set BarName=BAR_%AppName%
Set WorkDir=C:\Users\Admin\AppData\Local\Jenkins\.jenkins\workspace\IIB-TEST\Bars
Set KeywordsDir=C:\Users\Admin\AppData\Local\Jenkins\.jenkins\workspace\IIB-TEST\Build

echo Appliction Name - %AppName%
echo Bar File Name - %BarName%
@echo Working Directory - %WorkDir%
copy %WorkDir%\DEV\%BarName%.bar %WorkDir%\DEV\%BarName%.zip
powershell Expand-Archive -Path %WorkDir%\DEV\%BarName%.zip -DestinationPath %WorkDir%\TempBar
copy %WorkDir%\TempBar\%AppName%.appzip %WorkDir%\TempBar\%AppName%.zip
del %WorkDir%\TempBar\%AppName%.appzip
powershell Expand-Archive -Path %WorkDir%\TempBar\%AppName%.zip -DestinationPath %WorkDir%\TempBar\%AppName%
del %WorkDir%\TempBar\%AppName%.zip
copy %KeywordsDir%\keywords.txt %WorkDir%\TempBar\%AppName%\META-INF\keywords.txt
powershell Compress-Archive -Path %WorkDir%\TempBar\%AppName%\* -DestinationPath %WorkDir%\TempBar\%AppName%.zip
rmdir /s /q %WorkDir%\TempBar\%AppName%
copy %WorkDir%\TempBar\%AppName%.zip %WorkDir%\TempBar\%AppName%.appzip
del %WorkDir%\TempBar\%AppName%.zip
powershell Compress-Archive -Path %WorkDir%\TempBar\* -DestinationPath %WorkDir%\TempBar\%BarName%.zip
copy %WorkDir%\TempBar\%BarName%.zip %WorkDir%\DEV\%BarName%.bar
rmdir /s /q %WorkDir%\TempBar
del %WorkDir%\DEV\%BarName%.zip
echo Version update for %BarName%.bar is successful
