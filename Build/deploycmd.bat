@echo off
CALL mqsiprofile.cmd
CALL mqsideploy.exe %1 -e %2 -a %3