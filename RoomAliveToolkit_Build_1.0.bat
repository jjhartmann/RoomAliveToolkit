title ProCam Ensemble Build Script

@echo on

@REM Setting msBuild Command: set msBuildDir=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools
set msVCVarsDir=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools

@REM Call and set all environment variables for VS 2015
@REM Evoke: call "%msVCVarsDir%\"vsvars32.bat
call "%msVCVarsDir%\vsvars32.bat"
