# ubuntu 13 10 _x64
$ sudo apt-get install cmake build-essential gcc-multilib g++-multilib libx11-dev libxrandr-dev libasound2-dev libgl1-mesa-dev
$ cmake_gcc.sh -DANDROID_ABI=armeabi -DENABLE_SAMPLES=1 -DENABLE_64BIT=1
