@echo off

setlocal

set "CarNDEKFProjectPlatform=x86"
set "CarNDEKFProjectToolset=v140"
set "CarNDEKFProjectBuildType=Debug"

if NOT "%~1"=="" set "CarNDEKFProjectPlatform=%~1"
if NOT "%~2"=="" set "CarNDEKFProjectToolset=%~2"
if NOT "%~3"=="" set "CarNDEKFProjectBuildType=%~3" 

set "VcPkgDir=c:\vcpkg"
set "VcPkgTriplet=%CarNDEKFProjectPlatform%-windows"
rem set "VcPkgTriplet=%CarNDEKFProjectPlatform%-windows-%CarNDEKFProjectToolset%"

if defined VCPKG_ROOT_DIR if /i not "%VCPKG_ROOT_DIR%"=="" (
    set "VcPkgDir=%VCPKG_ROOT_DIR%"
)
if defined VCPKG_DEFAULT_TRIPLET if /i not "%VCPKG_DEFAULT_TRIPLET%"=="" (
    set "VcpkgTriplet=%VCPKG_DEFAULT_TRIPLET%"
)
set "VcPkgPath=%VcPkgDir%\vcpkg.exe"

echo. & echo Bootstrapping dependencies for triplet: %VcPkgTriplet% & echo.

rem ==============================
rem Update and Install packages
rem ==============================
call "%VcPkgPath%" update

rem Install latest uwebsockets
call "%VcPkgPath%" install uwebsockets --triplet %VcPkgTriplet%
rem Use adapted main.cpp for latest uwebsockets
copy main.cpp ..\..\src

rem ==============================
rem Configure CMake
rem ==============================

set "VcPkgTripletDir=%VcPkgDir%\installed\%VcPkgTriplet%"

set "CMAKE_PREFIX_PATH=%VcPkgTripletDir%;%CMAKE_PREFIX_PATH%"

echo. & echo Bootstrapping successful for triplet: %VcPkgTriplet% & echo CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH% & echo.

set "CarNDEKFProjectCMakeGeneratorName=Visual Studio 15 2017"

if "%CarNDEKFProjectPlatform%"=="x86" (
    if "%CarNDEKFProjectToolset%"=="v140" set "CarNDEKFProjectCMakeGeneratorName=Visual Studio 14 2015"
    if "%CarNDEKFProjectToolset%"=="v141" set "CarNDEKFProjectCMakeGeneratorName=Visual Studio 15 2017"
)

if "%CarNDEKFProjectPlatform%"=="x64" (
    if "%CarNDEKFProjectToolset%"=="v140" set "CarNDEKFProjectCMakeGeneratorName=Visual Studio 14 2015 Win64"
    if "%CarNDEKFProjectToolset%"=="v141" set "CarNDEKFProjectCMakeGeneratorName=Visual Studio 15 2017 Win64"
)

set "CarNDEKFProjectBuildDir=%~dp0\..\..\products\cmake.msbuild.windows.%CarNDEKFProjectPlatform%.%CarNDEKFProjectToolset%"
if not exist "%CarNDEKFProjectBuildDir%" mkdir "%CarNDEKFProjectBuildDir%"
cd "%CarNDEKFProjectBuildDir%"

echo: & echo CarNDEKFProjectBuildDir=%CD% & echo cmake.exe -G "%CarNDEKFProjectCMakeGeneratorName%" "%~dp0\..\.." & echo:

call cmake.exe -G "%CarNDEKFProjectCMakeGeneratorName%" "%~dp0\..\.."

call "%VcPkgPath%" integrate install

endlocal