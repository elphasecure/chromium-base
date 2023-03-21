REM Copyright (C) 2023 Elpha Secure Inc.

@echo off
SETLOCAL
if not defined MSVC_PATH (
SET MSVC_PATH="C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin"
)

set BUILD_TYPE=%1
set ARCH_TYPE=%2

if "%BUILD_TYPE%"=="" (
    echo "Provide a valid build type as the first argument(Release|Debug)"
    echo "Usage: build.bat <BUILD_TYPE> <ARCH_TYPE>"
    goto FAIL
)

if "%ARCH_TYPE%"=="" (
    echo "Provide a valid arch type as the second argument(Win32|x64)"
    echo "Usage: build.bat <BUILD_TYPE> <ARCH_TYPE>"
    goto FAIL
)

set SRC_DIR=%cd%
echo "SRC_DIR[%SRC_DIR%]"
set OUT_DIR="%SRC_DIR%\build-win"

rd /s /q build-win
msbuild %SRC_DIR%\win\base.sln /t:Rebuild /p:Configuration=%BUILD_TYPE% /p:Platform=%ARCH_TYPE% /p:OutDir=%OUT_DIR% -fl -flp:logfile=buildLog\agentBuild_%ARCH_TYPE%.log
IF NOT errorlevel 0 (
	echo "Failed to build base"
	goto FAIL
)

xcopy /E /I /Y "%SRC_DIR%\src\*.h" "%OUT_DIR%\include\"

IF NOT errorlevel 0 (
	echo "Failed to build base"
	goto FAIL
)

:END
echo "Agent build finished"
ENDLOCAL
goto EXIT

:FAIL
echo "Build Failed"
exit /b 1
ENDLOCAl

:EXIT