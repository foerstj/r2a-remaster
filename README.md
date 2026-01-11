# R2A remaster
The original Return to Arhok map, remastered.

## What I did
This map is re-buildable and editable. I opened & saved every region in Siege Editor v1.7. The dsmap file can be rebuilt using the batch scripts, provided you have the folder structure of Dungeon Siege and TankCreator.
- Renamed the map so there are no conflicts with the original map.\
  The internal name is *world/maps/r2a*.\
  The generated file name is *Dungeon Siege/DSLOA/Return to Arhok.dsmap*.\
  The ingame name is *Return to Arhok (remastered)*.

## What I did (revisit)
The "revisited" map variant is based on the remaster, with these changes applied:
- Added translations to German, Spanish, and French.
- Renamed map ingame to *Return to Arhok (revisited)*.
- Enabled multiplayer mode, required level 10, start positions for 8 characters
  - Skipped skill scrolls step, so that characters are not broken
  - Made companions singleplayer-only
  - Adapted quest forwarding & conversations; Moht does not give presents
  - Added/fixed player world locations
- Added Veteran and Elite modes for multiplayer
- Included fix for overwritten Rector texture from https://www.nexusmods.com/dungeonsiege1/mods/65
- Fixed initial roof fade for Kron the Wide
- Made quest forward to final message
- Slower mood change during teleportation - looks better esp. with SeeFar
- Minor fixes
  - Cleaned up unused tutorial tip
  - Fixed tilted tree trunk behind hero's house
- Made some terrain nodes non-camera-blocking
- Added support for Thrillvilled's voices mod
- Fixed misaligned gizmos of teleport effects
- Fixed R2A overwriting the elevator/teleporter list of LoA (for auto-formations)
- Fixed Rowan's boots leftover in Arhok when returning after defeating Evil Rowan

## How to build
- Provide environment variables:
  - %DungeonSiege% - path to DS installation
  - %TankCreator% - path to TC installation
- Run the build.bat in the repo root

## Attribution
- This map was created by Gas-Powered Games, not me. I'm just doing minor changes here.
- German translation by me.
- Spanish translation by Nekurrot25.
- French translation by Jayijato.
