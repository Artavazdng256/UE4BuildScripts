call "%CD%/Setup.bat" --force
call "%CD%/GenerateProjectFiles.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" "%CD%/UE4.sln" -target:"Engine\UE4" -property:Platform=Win64;Configuration="Development Editor" -verbosity:diagnostic
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" "%CD%/UE4.sln" -target:"Programs\UnrealLightmass" -property:Platform=Win64;Configuration="Development Editor" -verbosity:diagnostic
call "%CD%\Engine\Build\BatchFiles\RunUAT.bat" BuildGraph -target="Make Installed Build Win64" -script=Engine/Build/InstalledEngineBuild.xml -clean  -set:HostPlatformOnly=true -set:WithWin64=true -set:WithWin32=false -set:WithMac=false -set:WithAndroid=false -set:WithIOS=false -set:WithTVOS=false -set:WithLinux=false -set:WithLumin=false  -set:WithDDC=false -set:WithFullDebugInfo=true -set:WithClient=true -set:WithServer=true -set:VS2019=true

