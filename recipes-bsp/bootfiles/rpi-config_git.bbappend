FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append:rpi = " \
	file://0001-config-add-BSP-specific-configuration-in-config.txt.patch \
"

VC4DTBO:rpi ?= "vc4-fkms-v3d"
ENABLE_UART:rpi ?= "1"

