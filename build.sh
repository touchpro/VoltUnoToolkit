#!/bin/bash
# replace default.prop
rm ~/voltunotoolkit/AIK-Linux/ramdisk/default.prop
cp ~/voltunotoolkit/tools/default.prop ~/voltunotoolkit/AIK-Linux/ramdisk/
rm ~/voltunotoolkit/AIK-Linux/ramdisk/init.rc
cp ~/voltunotoolkit/tools/init.rc ~/voltunotoolkit/AIK-Linux/ramdisk/
# build kernel
# get to the right directory
cd kernel
# clean up old stuff
make clean
make mrproper
rm -r out
mkdir -p out
# using linaro 4.9.3
export ARCH=arm
export TARGET_PRODUCT=x5_spr_us
export DTS_TARGET=msm8226-x5_spr_us
export PATH=$PATH:tools/lz4demo
export CROSS_COMPILE=~/voltunotoolkit/linaro4.9.3/bin/arm-cortex_a15-linux-gnueabihf-
make  O=./out ARCH=arm voltuno_defconfig
# make the kernel
make O=./out -j4
# back to main dir
cd ..
# get to the right directory, delete old boot image
cd AIK-Linux
rm image-new.img
# copy zimage to AIK, rename it properly
cd split_img
rm boot.img-zImage
cp ~/voltunotoolkit/kernel/out/arch/arm/boot/zImage ~/voltunotoolkit/AIK-Linux/split_img/
mv zImage boot.img-zImage
# back to main AIK directory
cd ..
# repack boot image
./repackimg.sh
# bump it
python2 ~/voltunotoolkit/tools/bump.py image-new.img
# rename it
mv image-new_bumped.img voltunov3.img
# copy to main directory, go there
cp voltunov3.img ~/voltunotoolkit/
rm ~/voltunotoolkit/AIK-Linux/voltunov3.img
cd ..
