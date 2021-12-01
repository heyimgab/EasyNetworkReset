@echo off
title SIMPLE & FAST NETWORK RESET

C:
CD\
CLS

:MENU 
CLS


ECHO ################ SIMPLE NETWORK RESET ###################
ECHO      Completly Reset your network cards easily !
ECHO                      --------
ECHO    github.com/heyimgab                       gab.#0001
ECHO ---------------------------------
ECHO     1. Reset your network cards and stack.
ECHO     2. Set Google DNS's
ECHO     3. Exit the program
ECHO ---------------------------------
ECHO.
ECHO.

SET INPUT=
SET /P INPUT=Please select a number:

IF /I '%INPUT%'=='1' GOTO Reset
IF /I '%INPUT%'=='2' GOTO dns
IF /I '%INPUT%'=='1' GOTO Exit
CLS 

PAUSE > NUL
GOTO MENU 

:Reset

NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
ECHO For Each StrArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
ECHO args = args ^& strArg ^& " " >> "%temp%\OEgetPrivileges.vbs"
ECHO Next >> "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*

:gotPrivileges
if '%1'=='ELEV' shift /1
setocal & pushd . 
cd /d %~dp0

netsh winsock reset 
netsh int ip reset
netsh advfirewall RESET
ipconfig /flushdns
ipconfig /release
ipconfig /renew

cls 


ECHO ############### PRESS ANY KEY TO CONTINUE #################
ECHO ###### PLEASE RESTART YOUR COMPUTER TO APPLY CHANGES ######

PAUSE > NUL 
GOTO MENU


:dns

NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

setlocal DisableDelayedExpansion
set "batchPath=%~0"
setlocal EnableDelayedExpansion
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\OEgetPrivileges.vbs"
ECHO args = "ELEV " >> "%temp%\OEgetPrivileges.vbs"
ECHO For Each StrArg in WScript.Arguments >> "%temp%\OEgetPrivileges.vbs"
ECHO args = args ^& strArg ^& " " >> "%temp%\OEgetPrivileges.vbs"
ECHO Next >> "%temp%\OEgetPrivileges.vbs"
ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%temp%\OEgetPrivileges.vbs"
"%SystemRoot%\System32\WScript.exe" "%temp%\OEgetPrivileges.vbs" %*

:gotPrivileges
if '%1'=='ELEV' shift /1
setocal & pushd . 
cd /d %~dp0


wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder ()
wmic nicconfig where (IPEnabled=TRUE) call SetDNSServerSearchOrder ("8.8.8.8", "8.8.4.4")

cls 

ECHO ############### PRESS ANY KEY TO CONTINUE #################
ECHO ###### PLEASE RESTART YOUR COMPUTER TO APPLY CHANGES ######

PAUSE > NUL
GOTO MENU

:Exit

CLS

ECHO ############### SETTINGS DONE :) ! ###############
ECHO --------------------------------------------------
ECHO ########### PRESS ANY KEY TO CONTINUE ############
PAUSE > NUL


start https://github.com/heyimgab

EXIT
