#!/bin/bash
# replace a few things in ramdisk
rm ~/voltunotoolkit/AIK-Linux/ramdisk/default.prop
cp ~/voltunotoolkit/tools/default.prop ~/voltunotoolkit/AIK-Linux/ramdisk/
rm ~/voltunotoolkit/AIK-Linux/ramdisk/init.rc
cp ~/voltunotoolkit/tools/init.rc ~/voltunotoolkit/AIK-Linux/ramdisk/
# delete old modules, zip and boot image
rm voltunov33.zip
rm boot.img
rm -r system
mkdir -p ~/voltunotoolkit/system/lib/
# build kernel
# get to the right directory
cd kernel
# clean up old stuff
make clean
make mrproper
# kernel and modules build
export TARGET_PRODUCT=x5_spr_us
export DTS_TARGET=msm8226-x5_spr_us
export PATH=$PATH:tools/lz4demo
make voltuno_defconfig
make -j4
# back to main dir
cd ..
# get to the right directory, delete old boot image
cd AIK-Linux
rm image-new.img
# copy zimage to AIK, rename it properly
cd split_img
rm boot.img-zImage
cp ~/voltunotoolkit/kernel/arch/arm/boot/zImage ~/voltunotoolkit/AIK-Linux/split_img/
mv zImage boot.img-zImage
# back to main AIK directory
cd ..
# repack boot image
./repackimg.sh
# bump it
python2 ~/voltunotoolkit/tools/bump.py image-new.img
# rename it
mv image-new_bumped.img boot.img
# copy to main directory, go there
cp boot.img ~/voltunotoolkit/
rm ~/voltunotoolkit/AIK-Linux/boot.img
cd ..
# copy the modules from the build to a modules directory in voltunotoolkit
# Put modules into central folder
cd kernel
mkdir -p modules
cp ~/voltunotoolkit/kernel/arch/arm/mach-msm/reset_modem.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/arch/arm/mach-msm/dma_test.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/arch/arm/mach-msm/msm-buspm-dev.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/crypto/ansi_cprng.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/scsi/scsi_wait_scan.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/spi/spidev.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/misc/gpio_event.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/misc/gpio_matrix.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/misc/gpio_input.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/misc/gpio_output.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/misc/gpio_axis.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/input/evbug.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tuner-xc2028.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tuner-simple.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tuner-types.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mt20xx.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda8290.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tea5767.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tea5761.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda9887.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda827x.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda18271.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/xc5000.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/xc4000.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mt2060.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mt2063.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mt2266.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/qt1010.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mt2131.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mxl5005s.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mxl5007t.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/mc44s803.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/max2165.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda18218.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/common/tuners/tda18212.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/video/gspca/gspca_main.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/media/radio/radio-iris-transport.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/mmc/card/mmc_test.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/crypto/msm/qcedev.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/crypto/msm/qcrypto.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/gud/mckernelapi.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/drivers/gud/mcdrvmodule.ko ~/voltunotoolkit/kernel/modules/
cp ~/voltunotoolkit/kernel/arch/arm/oprofile/oprofile.ko ~/voltunotoolkit/kernel/modules/
# Move modules folder to main folder
cp -avr modules ~/voltunotoolkit/system/lib/modules/
rm -r modules
# Move back to default dir
cd ..
# zip everything up to ship out
zip voltunov33.zip boot.img -r system -r META-INF

