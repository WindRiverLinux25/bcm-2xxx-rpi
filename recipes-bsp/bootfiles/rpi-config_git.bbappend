FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append:rpi = " \
	file://0001-config-add-BSP-specific-configuration-in-config.txt.patch \
"

VC4DTBO:bcm-2xxx-rpi4 ?= "vc4-fkms-v3d"
VC4DTBO:bcm-2xxx-rpi5 ?= "vc4-kms-v3d-pi5"
ENABLE_UART:rpi ?= "1"

