:: This script is supposed to be executed from your DS installation folder.
:: TankCreator is expected to be in a sibling dir.

:: name of map
set map=r2a
:: name of map, case-sensitive
set map_cs=Return to Arhok
:: path of DSLOA documents dir (where Bits are)
set doc_dsloa=%USERPROFILE%\Documents\Dungeon Siege LoA
:: path of DS installation
set ds=.
:: path of TankCreator
set tc=..\TankCreator

set copyright=GPG 2002
set author=Mad Doc Software
set title=%map_cs%

:: Compile map file
rmdir /S /Q "%tmp%\Bits"
robocopy "%doc_dsloa%\Bits\world\maps\%map%" "%tmp%\Bits\world\maps\%map%" /E
%tc%\RTC.exe -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsmap" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

:: Compile main resource file
rmdir /S /Q "%tmp%\Bits"
robocopy "%doc_dsloa%\Bits\art" "%tmp%\Bits\art" /E
robocopy "%doc_dsloa%\Bits\sound" "%tmp%\Bits\sound" /E
robocopy "%doc_dsloa%\Bits\world\ai" "%tmp%\Bits\world\ai" /E
robocopy "%doc_dsloa%\Bits\world\contentdb" "%tmp%\Bits\world\contentdb" /E
robocopy "%doc_dsloa%\Bits\world\global" "%tmp%\Bits\world\global" /E
%tc%\RTC.exe -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

:: Cleanup
rmdir /S /Q "%tmp%\Bits"
