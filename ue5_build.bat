call "%CD%/Setup.bat" --force
call "%CD%/GenerateProjectFiles.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" "%CD%/UE5.sln" -target:"Engine\UE5" -property:Platform=Win64;Configuration="Development Editor" -verbosity:diagnostic
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" "%CD%/UE5.sln" -target:"Programs\UnrealLightmass" -property:Platform=Win64;Configuration="Development Editor" -verbosity:diagnostic

