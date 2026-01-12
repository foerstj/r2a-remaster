:: name of map
set map=r2a
:: name of map, case-sensitive
set map_cs=Return to Arhok

:: path of Bits dir
set bits=%~dp0.
:: path of DS installation
set ds=%DungeonSiege%
:: path of TankCreator
set tc=%TankCreator%

set copyright=GPG 2002
set author=Mad Doc Software
set title=%map_cs%

:: param
set mode=%1
echo %mode%

:: pre-build checks
pushd %gaspy%
setlocal EnableDelayedExpansion
if not "%mode%"=="light" (
  robocopy "%bits%\original\templates" "%bits%\world\contentdb\templates\original" /S
  set checks=standard
  if "%mode%"=="release" (
    set checks=all
  )
  venv\Scripts\python -m build.pre_build_checks %map% --check !checks! --bits "%bits%"
  set pre_build_checks_errorlevel=!errorlevel!
  rmdir /S /Q "%bits%\world\contentdb\templates\original"
  if !pre_build_checks_errorlevel! neq 0 pause
  popd
)
endlocal
popd

:: Compile map file
rmdir /S /Q "%tmp%\Bits"
robocopy "%bits%\world\maps\%map%" "%tmp%\Bits\world\maps\%map%" /E
pushd %gaspy%
venv\Scripts\python -m build.fix_start_positions_required_levels %map% --bits "%tmp%\Bits"
if %errorlevel% neq 0 pause
setlocal EnableDelayedExpansion
if "%mode%"=="release" (
  robocopy "%bits%\original\templates" "%bits%\world\contentdb\templates\original" /S
  venv\Scripts\python -m build.add_world_levels %map% --bits "%tmp%\Bits" --template-bits "%bits%" --template-base original
  set add_world_levels_errorlevel=!errorlevel!
  rmdir /S /Q "%bits%\world\contentdb\templates\original"
  if !add_world_levels_errorlevel! neq 0 pause
)
endlocal
popd
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsmap" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

:: Compile main resource file
rmdir /S /Q "%tmp%\Bits"
robocopy "%bits%\art" "%tmp%\Bits\art" /E /xf *.lqd20 /xf *.exe /xf *.psd
robocopy "%bits%\sound" "%tmp%\Bits\sound" /E
robocopy "%bits%\world\ai" "%tmp%\Bits\world\ai" /E
robocopy "%bits%\world\contentdb" "%tmp%\Bits\world\contentdb" /E
robocopy "%bits%\world\global" "%tmp%\Bits\world\global" /E /xd map_expansion
"%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
if %errorlevel% neq 0 pause

set copyright=CC-BY-SA 2025
set author=Johannes Förstner

:: Compile German language resource file
setlocal EnableDelayedExpansion
if not "%mode%"=="light" (
 rmdir /S /Q "%tmp%\Bits"
 robocopy "%bits%\language" "%tmp%\Bits\language" *.de.gas /E
 "%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.de.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
 if !errorlevel! neq 0 pause
 :: Compile Spanish language resource file
 rmdir /S /Q "%tmp%\Bits"
 robocopy "%bits%\language" "%tmp%\Bits\language" *.es.gas /E
 "%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.es.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
 if !errorlevel! neq 0 pause
 :: Compile French language resource file
 rmdir /S /Q "%tmp%\Bits"
 robocopy "%bits%\language" "%tmp%\Bits\language" *.fr.gas /E
 "%tc%\RTC.exe" -source "%tmp%\Bits" -out "%ds%\DSLOA\%map_cs%.fr.dsres" -copyright "%copyright%" -title "%title%" -author "%author%"
 if !errorlevel! neq 0 pause
)
endlocal

:: Cleanup
rmdir /S /Q "%tmp%\Bits"
