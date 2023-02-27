@echo off
@call "mqsiprofile.cmd" >NUL 2>NUL
mqsideploy %1 -e %2 -a %3 -w %4