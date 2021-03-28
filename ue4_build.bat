call "%CD%/Setup.bat" --force
call "%CD%/GenerateProjectFiles.bat"
call "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\MSBuild\Current\Bin\MSBuild.exe" "%CD%/UE4.sln" -target:"Engine\UE4" -property:Platform=Win64;Configuration="Development Editor" -verbosity:diagnostic
