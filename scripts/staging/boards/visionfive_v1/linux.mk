#==============================================================================
# Build Linux kernel for StarFive VisionFive V1.
#==============================================================================

visionfive_v1_linux_update: linux_update
visionfive_v1_linux_checkout: _board_linux_checkout
visionfive_v1_linux_devel: _board_linux_devel
visionfive_v1_linux_defconfig: _board_linux_defconfig
visionfive_v1_linux_menuconfig: _board_linux_menuconfig
visionfive_v1_linux_mkdefconfig: _board_linux_mkdefconfig
visionfive_v1_linux_dtbs: _board_linux_dtbs
visionfive_v1_linux_dtb_install: _board_linux_dtb_install
visionfive_v1_linux_build: _board_linux_build
visionfive_v1_linux_install_modules: _board_linux_install_modules
visionfive_v1_linux_install_zimage: _board_linux_install_zimage
visionfive_v1_linux_install_all: _board_linux_install_all
visionfive_v1_linux_clean: _board_linux_clean
visionfive_v1_linux_all: visionfive_v1_linux_checkout visionfive_v1_linux_defconfig visionfive_v1_linux_menuconfig visionfive_v1_linux_build visionfive_v1_linux_install_all