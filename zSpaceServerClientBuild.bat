::set UE5_PATH=C:\UnrealEngine\
::set UE5_PATH=D:\UE5\UnrealEngine-ue5-early-access
set UE5_PATH=C:\UE5\


set PROJECT_NAME=zSpace


If EXIST  "C:\zSpace_Server"  rmdir C:\zSpace_Server /s /q
IF EXIST  "C:\zSpace_Client"  rmdir C:\zSpace_Client /s /q
IF EXIST  "C:\zSpaceArchive"  rmdir C:\zSpaceArchive /s /q

set PROJECT_PATH=%CD%\%PROJECT_NAME%.uproject

set CLIENTCONFIG=%1



set ARCHIVEDIRECTORY_SERVER=C:\%PROJECT_NAME%_Server
set ARCHIVEDIRECTORY_CLIENT=C:\%PROJECT_NAME%_Client


set FINAL_SERVER_PATH=%ARCHIVEDIRECTORY_SERVER%\zSpaceDedicatedServer

IF NOT EXIST %ARCHIVEDIRECTORY_SERVER% mkdir "%ARCHIVEDIRECTORY_SERVER%"

IF NOT EXIST "C:\%PROJECT_NAME%_Client" mkdir "C:\%PROJECT_NAME%_Client"


call "%UE5_PATH%\Engine\Build\BatchFiles\Build.bat" "%PROJECT_NAME%Editor" win64 Development "%PROJECT_PATH%" -WaitMutex 
if %errorlevel% NEQ 0 exit /b %errorlevel%

:::call "%CD%\BuildLighting.bat" 
::if %errorlevel% NEQ 0 exit /b %errorlevel%

call "%UE5_PATH%\Engine\Build\BatchFiles\RunUAT.bat" -ScriptsForProject="%PROJECT_PATH%" BuildCookRun -nocompileeditor -installed -nop4 -project="%PROJECT_PATH%" -cook -allmaps -stage -pak -archive -archivedirectory=%ARCHIVEDIRECTORY_CLIENT% -package -ue5exe="%UE5_PATH%\Engine\Binaries\Win64\UE5Editor-Cmd.exe"  -ddc=InstalledDerivedDataBackendGraph -prereqs -nodebuginfo -targetplatform=Win64 -build -target=%PROJECT_NAME% -clientconfig=%CLIENTCONFIG% -utf8output -createreleaseversion=1.0 -UNATTENDED
if %errorlevel% NEQ 0 exit /b %errorlevel%


call "%UE5_PATH%\Engine\Build\BatchFiles\RunUAT.bat" -ScriptsForProject="%PROJECT_PATH%" BuildCookRun -nocompileeditor -nop4 -project="%PROJECT_PATH%" -cook -allmaps -stage -pak -archive -archivedirectory=%ARCHIVEDIRECTORY_SERVER% -package -ue5exe="%UE5_PATH%\Engine\Binaries\Win64\UE5Editor-Cmd.exe" -ddc=DerivedDataBackendGraph -prereqs -nodebuginfo -targetplatform=Win64 -build -target=%PROJECT_NAME%Server -serverconfig=%CLIENTCONFIG% -utf8output -compile -UNATTENDED
if %errorlevel% NEQ 0 exit /b %errorlevel%


if %1 == Development (set SERVER_EXE_PATH=%ARCHIVEDIRECTORY_SERVER%\WindowsServer\%PROJECT_NAME%\Binaries\Win64\%PROJECT_NAME%Server.exe) ^
else if %1 == Shipping (set SERVER_EXE_PATH=%ARCHIVEDIRECTORY_SERVER%\WindowsServer\%PROJECT_NAME%\Binaries\Win64\%PROJECT_NAME%Server-Win64-Shipping.exe) ^
else (echo "Error: wrong argument" && exit 11)

echo ***SERVER_EXE_PATH: %SERVER_EXE_PATH%

set MOVE_SERVER_EXE_PATH=%ARCHIVEDIRECTORY_SERVER%\Windows\%PROJECT_NAME%\Binaries\Win64\

if exist ( "%SERVER_EXE_PATH%" ) (
	echo "Z Space: copying exe" 
	xcopy /Y /E /I "%CD%\OWSInstanceLauncher" "%ARCHIVEDIRECTORY_SERVER%\OWSInstanceLauncher"
	if %errorlevel% NEQ 0 exit /b %errorlevel%
	copy "%CD%\appsettings.json" "%ARCHIVEDIRECTORY_SERVER%\OWSInstanceLauncher\appsettings.json"
	if %errorlevel% NEQ 0 exit /b %errorlevel%
	copy "%CD%\RunOWS.bat" "%ARCHIVEDIRECTORY_SERVER%\OWSInstanceLauncher\RunOWS.bat"
	if %errorlevel% NEQ 0 exit /b %errorlevel%
)


