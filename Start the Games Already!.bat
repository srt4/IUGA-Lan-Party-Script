                                                                     
                                                                     
                                                                     
                                             
@echo off
echo #############################################################################
echo ####                                                                     ####
echo ####                 iSchool LanParty Script Goodness...                 ####
echo ####   Feel free to provide updates/feedback to Harrison (h4rr@uw.edu)   ####
echo ####                                                                     ####
echo #############################################################################


rem #############################################################################
rem ####                                                                     ####
rem #### After many years of difficult to setup lans, behold... a better way ####
rem ####                 Harrison Weingard (h4rr@uw.edu) 2010                ####     
rem ####                                                                     ####
rem #############################################################################




rem #### Configuration section

set LANPARTY=C:\LanParty
set LANPARTY_INSTALL=%LANPARTY%\Install Files
set LANPARTY_FILES=N:\Temporary Folders\LanParty
set LANPARTY_TORRENTS=%LANPARTY_FILES%\Torrent Files
set ZIPPY=C:\Program Files\7-Zip\7z.exe
set STEAM=C:\Program Files (x86)\Steam




rem #### create the installation directories (make sure we are on the C drive first)
C:
mkdir "%LANPARTY%"
mkdir "%LANPARTY_INSTALL%"




rem #### copy over the install files to the lanparty install directory

echo Copying Install files to %LANPARTY_INSTALL%...
@echo on
copy /Y "%LANPARTY_FILES%\SteamInstall.msi" "%LANPARTY_INSTALL%"
copy /Y "%LANPARTY_FILES%\utorrent.exe" "%LANPARTY_INSTALL%"
copy /Y "%LANPARTY_FILES%\utorrent_settings.7z" "%LANPARTY_INSTALL%"
copy /Y "%LANPARTY_FILES%\bittorrent_settings.7z" "%LANPARTY_INSTALL%"
@echo off




rem #### Install the uTorrent settings that make this work... 7Zip requires to be parent directory

echo Extracting the uTorrent configuration settings... (aka silent install)
cd "%AppData%"
"%ZIPPY%" -y x "%LANPARTY_INSTALL%\utorrent_settings.7z"
cd "%LANPARTY%"




rem #### Install the Steam client for the masses.  It will require updates, can't avoid that.. I Think...

echo Silently installing steam... Please approve of this action (UAC sucks...)
"%LANPARTY_INSTALL%\SteamInstall.msi" /qb




rem #### Run uTorrent (the start syntax allows it to run in background)
echo Running uTorrent...
start /B /D"%LANPARTY_INSTALL%" uTorrent.exe



rem #### TODO TODO TODO TODO TODO TODO create the torrent files and make copy/run scripts

echo Copying over the Torrent files
xcopy /E /Y "%LANPARTY_TORRENTS%" "%LANPARTY_INSTALL%"

rem After the torrents are done, we need to extract the 7z files into %STEAM%\steamapps
rem which should restore the gcf files.


echo #############################################################################
echo ####                                                                     ####
echo ####  To login to a Steam account again, click the "Steam Login"    ####
echo ####  file on your desktop.                                    ####
echo ####                                                                     ####
echo ####  In your C:\LanParty\ Folder you will have a list of all the games  ####
echo ####  that have been provided and shared.  Feel free to install your     ####
echo ####  own as well.  In order to use the Steam Backup feature, you need   ####
echo ####  to be LOGGED in to a steam account                          ####
echo ####                                                                     ####
echo #############################################################################

rem #### LAN party auto-login script, 
FOR /F "delims=- tokens=1,2,3" %%g IN ("%computername%") DO (CALL :PARSE2 %%g %%h %%i)
:PARSE2
set _RM=%2
SET _RM=%_RM:~1,3%

REM Detect if it's in room 440 and if so give it a 42-72 username. 
IF %_RM% EQU 430 (SET _PCNum=%3) else (SET /A _PCNum=%3 + 42)
IF %_PCNum% LSS 10 (SET /A _PCNum=%_PCNum% + 10 - 10)


REM #### The password will change for each LAN as well as username format
SET SteamUser=tu0100244pc%_PCNum%
SET SteamPW=2756474

copy /Y "%LANPARTY_FILES%\Steam Logon.cmd" "%USERPROFILE\Desktop\"

rem #### Open up the folder that will contain all the torrents when downloaded....

echo When your torrents are done downloading, they will be available in this directory. Have fun!
echo feel free to provide feedback to Harrison (h4rr@uw.edu) about this script if you have improvements.
explorer "%LANPARTY%"
pause








rem ####################################### everything below is not used currently or used to help create files ######



rem #### TODO TODO TODO TODO TODO TODO create the torrent files and make copy/run scripts

rem echo Copying over the Torrent files
rem xcopy 


rem "%LANPARTY_INSTALL%\utorrent.exe" /DIRECTORY "%LANPARTY%" c:\Users\%USERNAME%\Desktop\SteamApps_Mega.torrent
rem "%LANPARTY_INSTALL%\utorrent.exe" /DIRECTORY "%LANPARTY%" c:\Users\%USERNAME%\Desktop\Both_L4Ds.torrent





rem #### Extra commands that may be useful later

rem "c:\Program Files\7-Zip\7z.exe" x H:\Downloads\utorrent_settings.7zip
rem "c:\Program Files\7-Zip\7z.exe" x H:\Downloads\bittorrent_settings.7zip

rem "C:\Program Files\7-Zip\7z.exe" a H:\Downloads\utorrent_settings.7z "%AppData%\uTorrent"
rem "C:\Program Files\7-Zip\7z.exe" a H:\Downloads\bittorrent_settings.7z "%AppData%\BitTorrent"



rem Old hack to disable UAC temporarily.. fuck its broken. fucking uac, fuck fuck fuck
rem C:\Windows\System32\cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f