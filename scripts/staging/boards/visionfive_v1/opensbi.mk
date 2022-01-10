#==============================================================================
# Build Linux kernel for StarFive VisionFive V1.
#==============================================================================

visionfive_v1_opensbi_update: opensbi_update
visionfive_v1_opensbi_checkout: _board_opensbi_checkout
visionfive_v1_opensbi_devel: _board_opensbi_devel
visionfive_v1_opensbi_build: _board_opensbi_build

visionfive_v1_opensbi_install: _board_opensbi_install
	$(sdkdir)/fsz.sh $(_BOARD_OPENSBI_INSTALL_DIR)/fw_payload.bin

visionfive_v1_opensbi_all: visionfive_v1_opensbi_checkout visionfive_v1_opensbi_build visionfive_v1_opensbi_install
# visionfive_v1_opensbi_checkout visionfive_v1_opensbi_build visionfive_v1_opensbi_install
