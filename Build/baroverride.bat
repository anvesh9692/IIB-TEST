@echo off
CALL mqsiprofile.cmd
CALL mqsiapplybaroverride -b %1 -p %2 -r