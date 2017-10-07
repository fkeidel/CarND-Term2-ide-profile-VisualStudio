# CarND-Term2-ide-profile-VisualStudio
Visual Studio solution/project and install script to download and install uWebSocket on Windows natively, without need to use Ubuntu Bash.

Perform these steps to setup your Visual Studio project for SDCND term 2:\
_if you use Power Shell add .\\ before a batch name (bootstrap-vcpkg.bat -> .\\bootstrap-vcpkg.bat)_

1. Install cmake
* Download and run windows installer (see https://cmake.org/download/)

2. Install make
* Download setup from http://gnuwin32.sourceforge.net/packages/make.htm
* Select 'Complete package, except sources - Setup'
* Run downloaded setup

3. Clone and install vcpkg
* The install script used in the next step will asume that you installed vckpgk in c:\\vcpkg. You can choose another location, but then you have to adapt VcPkgDir in line 13 in install-windows.bat
* cd c:\\
* git clone https://github.com/Microsoft/vcpkg.git
* cd vcpkg
* call bootstrap-vcpkg.bat

4. Download ide profile
* Download zip of this repository and unpack content
* copy the VisualStudio directory to your project's ide_profiles directory.

5. Adapt and call the install script for windows
* cd to directory ide_profiles\\VisualStudio
* Open install-windows.bat and adjust lines 5 to 7 to the settings you will use when building your Visual Studio project (platform, toolset, buildtype)
* You could also pass these settings as command line arguments to install-windows.bat
* If you have more than one toolset installed, comment line 14 and uncomment line 15
* call install-windows.bat
* the install scipt will
** set the build parameters for the libraries to install (platform, toolset, buildtype)
** use vcpkg to download, build and install uWebSockets
*** it will download the latest version of uWebSockets
** copy a customized main.cpp from  ide_profile\\VisualStudio to the project src folder.

6. Open solution and adapt toolset settings
* Open CarND-Extended-Kalman-Filter-Project.sln
* Open project properties
* Adapt target platform version and platform toolset (use the same setting that you used in the install script)

7. Build project in Visual Studio
* Build the project for the platform and buildtype you used in the install script

