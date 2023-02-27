@echo off
@call "mqsiprofile.cmd" >NUL 2>NUL
CALL mqsideploy.exe %1 -e %2 -a %3 -w %4