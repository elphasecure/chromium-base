# Chromium-Base
Provides cross platform utility functions.

Windows Build:
--------------
For building base.lib use command:

x86: build.bat<br />
x64: build.bat x64<br />

Binary and header will be generated inside build_win folder

Notes: 
1) Project where base.lib needs to be consume either add NOMINMAX to the preprocessor directive or define NOMINMAX in the source file
2) To modify the project settings or add new files use base.sln present in win folder.
3) In order to regenrate the fresh base.sln file use follwing command:

 gyp --depth=. base.gyp -f msvs -G msvs_version=2022 --generator-output=win -I src/build/common.gypi<br/>
 (Freshly generated base.sln will not have x64 configuration, needs to be added manually through sln file.)
 
 gyp location: https://github.com/elphasecure/gyp
 
 Mac and Linux Support:
 ---------------------
 Will update later.
