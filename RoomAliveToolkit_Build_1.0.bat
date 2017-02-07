title ProCam Ensemble Build Script
@echo on

REM Check Command Line Vars
SET BUILDTYPE="%1"
IF %BUILDTYPE%=="" (
  SET BUILDTYPE="DEBUG"
  )

REM Find Project Directory
IF NOT DEFINED ROOMALIVETK (
  REM PLEASE set up environment variable for Room alive tookkit.
  exit /b
  )

REM Setting Env Vars
SET msVCVarsDir=%ProgramFiles(x86)%\Microsoft Visual Studio 14.0\Common7\Tools
SET ProjectorServerDir=%ROOMALIVETK%\ProCamCalibration\ProjectorServer\bin\%BUILDTYPE%
SET KinectServerDir=%ROOMALIVETK%\ProCamCalibration\KinectServer\bin\%BUILDTYPE%
SET CurrentDir=%CD%

REM Call and set all environment variables for VS 2015
if not defined DevEnvDir (
    CALL "%msVCVarsDir%\vsvars32.bat"

)

REM Killtasks
taskkill /FI "IMAGENAME eq ProjectorServer.exe" /F
taskkill /FI "IMAGENAME eq KinectServer.exe" /F

CHDIR  %ROOMALIVETK%\ProCamCalibration
IF %BUILDTYPE%=="DEBUG" (
  REM Debug Build
  CALL MSBuild ProCamEnsembleCalibration.sln /p:Configuration=Debug /t:Clean;Rebuild /l:FileLogger,Microsoft.Build.Engine;logfile=../Manual_MSBuild_Debug_LOG.log
  )

IF %BUILDTYPE%=="RELEASE" (
  REM Release Build
  CALL MSBuild ProCamEnsembleCalibration.sln /p:Configuration=Release /t:Clean;Rebuild /l:FileLogger,Microsoft.Build.Engine;logfile=../Manual_MSBuild_Release_LOG.log
  )

REM Run Servers
START %ProjectorServerDir%\ProjectorServer.exe
START %KinectServerDir%\KinectServer.exe
CHDIR %CurrentDir%
exit
