# Building PYNQ 2.7 for the ZCU216

This repository provides files and instructions for building an SD Card image with PYNQ 2.7 for the ZCU216 evaluation board.
The repository contains:
* Instructions
* ZCU216 board folder with updated device tree. 
* tics folder with files that program the LMK/LMX PLLs for the ZCU216 RFDCs. 

## Prequisites for building PYNQ
1. Setup a machine with Ubuntu 18.04 or 20.04 for building OR setup an equivalent virtual machine by following these instructions: https://pynq.readthedocs.io/en/latest/pynq_sd_card.html#prepare-the-building-environment
2. Recursively clone this repository: `git clone --recursive https://github.com/UniHD-CEG/ZCU216-PYNQ`
3. Install dependencies by running the following from the root folder of this repository: `bash PYNQ/sdbuild/scripts/setup_host.sh`
4. Install Vivado and Vitis 2020.2 from here: https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vitis/archive-vitis.html
   1. Note that both Vitis and Vivado are installed at the same time with the same installer.
   2. Also make sure that the necessary licenses are available to the Vitis installation.
5. Install PetaLinux 2020.2 by following this guide from step 4 and onwards: https://www.fpgadeveloper.com/how-to-install-petalinux-2020.1/
   1. IMPORTANT: Make sure to replace '2020.1' with '2020.2' wherever the version number is referenced. This includes the download link!

## Prequisites for building PYNQ for the ZCU216 specifically
1. Download the rootfs from here: https://www.xilinx.com/bin/public/openDownload?filename=focal.aarch64.2.7.0_2021_11_17.tar.gz
2. Find and Download the ZCU216 Petalinux 2020.2 BSP from here: https://xilinx-wiki.atlassian.net/wiki/spaces/A/pages/1065451521/2020.2+Release
   1. The exact link should be: https://www.xilinx.com/member/forms/download/xef.html?filename=xilinx-zcu216-v2020.2-final.bsp 
3. Configure the `config.sh` file to match your specific installation.
   1. Here the paths to the different tools and files, that were downloaded previously, are set.

## Building the SD Card image
1. Make sure all prequisites have been taken care of.
2. Execute the build script: `bash build_ZCU216.sh`
   1. This method automatically places the correct tics files into the correct folder as indicated above. Depending on your system this will take between 1.5 and 4 hours.
   2. Note: The build process will run sudo commands about four times during the build. This may require manual insertion of your password.
