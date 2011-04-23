                                                                     
                                                                     
                                                                     
                                             
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


rem ### if the N drive isn't mounted lets mount it
net use N: \\is-dfs.ischool.uw.edu\files

rem #### Configuration section

set LANPARTY=%USERPROFILE%\Desktop\Games
set LANPARTY_INSTALL=%LANPARTY%\programs
set LANPARTY_FILES=N:\Temporary Folders\LanParty
set LANPARTY_TORRENTS=%LANPARTY_FILES%\torrent_files_to_load
set TORRENT_WATCH_FOLDER=C:\LanParty\torrent_files
set ZIPPY=C:\Program Files\7-Zip\7z.exe




rem #### create the installation directories (make sure we are on the C drive first)
C:
mkdir "%LANPARTY%"
mkdir "%LANPARTY_INSTALL%"
mkdir C:\LanParty
mkdir "%TORRENT_WATCH_FOLDER%"




rem #### copy over the install files to the lanparty install directory

echo Copying Install files to %LANPARTY_INSTALL%...
copy /Y "%LANPARTY_FILES%\utorrent.exe" "%LANPARTY_INSTALL%"
copy /Y "%LANPARTY_FILES%\utorrent_settings.7z" "%LANPARTY_INSTALL%"
copy /Y "%LANPARTY_TORRENTS%" "%TORRENT_WATCH_FOLDER%"


rem #### Install the uTorrent settings that make this work... 7Zip requires to be parent directory

echo Extracting the uTorrent configuration settings... (aka silent install)
cd "%AppData%"
if not exist "%AppData%\uTorrent" ("%ZIPPY%" -y x "%LANPARTY_INSTALL%\utorrent_settings.7z")
cd "%LANPARTY%"

rem #### Run uTorrent (the start syntax allows it to run in background)
echo Running uTorrent...
start /B /D"%LANPARTY_INSTALL%" uTorrent.exe

rem #### TODO TODO TODO TODO TODO TODO create the torrent files and make copy/run scripts

echo Copying over the Torrent files...
@echo on
xcopy /E /Y "%LANPARTY_TORRENTS%" "%LANPARTY_INSTALL%"
@echo off

explorer "%LANPARTY%"
pause
