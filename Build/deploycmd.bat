@REM Windows batch file to set the mqsi environment
@REM and execute the mqsiprofile command.

@REM Saves the current working directory and enter the directory where 'mqsiprofile' generally lives.

@pushd %1

@call "mqsiprofile.cmd" >NUL 2>NUL

:: Get back to the project directory

@popd

:: Now mqsideploy can be called.

::
:: %2 = integration node
:: %3 = intergration server (execution group)
:: %4 = bar file
:: %5 = timeout Secs

mqsideploy %2 -e %3 -a %4 -w %5 