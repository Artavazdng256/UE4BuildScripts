::set UE5_PATH=C:\UnrealEngine\
::set UE5_PATH=D:\UE5\UnrealEngine-ue5-early-access
set UE5_PATH=C:\UE5\



set PROJECT_NAME=zSpace

set TEST_MAP_NAME=FourZoneMap

set PROJECT_PATH=%CD%\%PROJECT_NAME%.uproject


call %UE5_PATH%\Engine\Binaries\Win64\UnrealEditor-Cmd.exe ^
 "%PROJECT_PATH%" ^
 -Run=ResavePackages ^
 -IgnoreChangeLis ^
 -BuildLighting ^
 -Quality=Production ^
 -MapsOnly ^
 -ProjectOnly ^
 -AllowCommandletRendering ^
 -UNATTENDED
 
 if %errorlevel% NEQ 0 exit /b %errorlevel%
 
 
 
