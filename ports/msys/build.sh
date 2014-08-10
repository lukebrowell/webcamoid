#!/bin/sh

s7zVersion=920
ffmpegVersion=2.2.3
mainPath="$PWD"

function get7Z()
{
    cd ../../build
    wget -c http://downloads.sourceforge.net/sevenzip/7za$s7zVersion.zip
    unzip -u 7za$s7zVersion.zip
}

function getFFmpeg() 
{
    cd ../../build
    wget -c http://ffmpeg.zeranoe.com/builds/win32/dev/ffmpeg-$ffmpegVersion-win32-dev.7z
    7za x -y ffmpeg-$ffmpegVersion-win32-dev.7z
}

function compileWebcamoid()
{
    cd ../..

    /qttools/qmake Webcamoid.pro \
        FFMPEGINCLUDES="$mainPath/build/ffmpeg-$ffmpegVersion-win32-dev/include" \
        FFMPEGLIBS="-L$mainPath/build/ffmpeg-$ffmpegVersion-win32-dev/lib"

    mingw32-make CXXFLAGS="-I$mainPath/build/ffmpeg-$ffmpegVersion-win32-dev/include -L$mainPath/build/ffmpeg-$ffmpegVersion-win32-dev/lib"
}

export PATH="$mainPath:$PATH"

get7Z
cd "$mainPath"
getFFmpeg
cd "$mainPath"
compileWebcamoid