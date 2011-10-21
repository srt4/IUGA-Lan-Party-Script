rem This script will run the appropriate commands to get Steam and uTorrent running on all the computers in the lab.
rem Requires: psexec.exe, utorrent.exe, SteamInstaller.exe (in a publicly-accessible samba share), torrent file.
rem Also needs a list of computers (compies.txt).
rem Created October 21, 2011 by Spencer Thomas <srt4@uw>

rem ### 

rem #### Install Steam on all the computers

start psexec @compies.txt -s -h -i msiexec.exe /i "\\is-m440m27-30\test\SteamInstall.msi" /q

rem ###  Add the user account for the LAN party

start psexec @compies.txt net user /add lan starcraft && net localgroup Administrators lan /add

rem ### Get uTorrent going and downloading some stuff

start psexec @compies.txt -c -v -d -s -i ../utorrent.exe /NOINSTALL /HIDE /DIRECTORY C:\LAN\ "http://dev.iuga.info/rivettracker/torrents/Counter-Strike Source.torrent"
