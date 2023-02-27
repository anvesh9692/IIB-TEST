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
:: %3 = hostname
:: %4 = port
:: %5 = intergration server (execution group)
:: %6 = bar file
:: %7 = timeout Secs

mqsideploy %2 -i %3 -p %4 -e %5 -a %6 -w %7
