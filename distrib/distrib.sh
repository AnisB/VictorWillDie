#!/bin/bash

rm vwd.love 
rm -rf  output/VWD.app
rm VWD_OSX.zip

cd ../Code
zip -r vwd.love .
mv vwd.love ../distrib/
cd ../distrib



# MAC App
rm -rf  output/VWD.app
mkdir output/VWD.app
cp -R mac/love.app/ output/VWD.app
cp vwd.love output/VWD.app/Contents/Resources/
cd output
zip -r VWD_OSX.zip VWD.app/
cd ..
#deletion
rm -rf output/VWD.app


# Window exe
mkdir output/VWD_WIN32
cp windows/* output/VWD_WIN32
cd output/VWD_WIN32
cat love.exe ../../vwd.love > vwd.exe
rm love.exe
cd ..
zip -r VWD_WIN32.zip VWD_WIN32/
rm -rf VWD_WIN32
cd ..

# Window exe
zip output/VWD_LINUX.zip vwd.love


#common deletion
rm vwd.love 
