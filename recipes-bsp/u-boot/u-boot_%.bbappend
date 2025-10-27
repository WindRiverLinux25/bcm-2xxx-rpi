FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS:append:rpi = " rpi-u-boot-scr rpi-bootfiles"

UBOOT_RPI4_SUPPORT_PATCHES = " \
    file://0001-rpi_4-defconfigs-Add-CONFIG_CMD_BOOT-menu.patch \
    file://0002-rpi.h-Add-ostree-default-variables.patch \
    file://boot_cmd.patch \
    file://pcie-usb-linux-yocto.patch \
    file://0001-qemu-arm64-Defaults-for-booting-with-ostree.patch \
    file://0002-usb_kbd-Do-not-fail-the-keyboard-if-it-does-not-have.patch \
    file://0003-common-usb.c-Work-around-keyboard-reporting-USB-devi.patch \
    file://0004-xhci-ring.c-Add-the-poll_pend-state-to-properly-abor.patch \
    file://0005-xhci-ring-Fix-crash-when-issuing-usb-reset.patch \
    file://0006-usb.c-Add-a-retry-in-the-usb_prepare_device.patch \
    file://0001-configs-rpi_arm64-Add-CONFIG_ENV_OVERWRITE-in-defcon.patch \
"

UBOOT_RPI5_SUPPORT_PATCHES = " \
    file://0001-include-dt-bindings-clk-introduce-bindings-for-rp1-c.patch \
    file://0002-include-dt-bindings-mfd-introduce-bindings-for-RP1-d.patch \
    file://0003-arch-arm-mach-bcm283x-add-pcie-memory-region-to-BCM2.patch \
    file://0004-arch-arm-mach-bcm283x-add-BCM2712-board-support.patch \
    file://0005-drivers-net-macb-do-not-include-arch-clk.h-when-cloc.patch \
    file://0006-drivers-pci-take-into-account-that-ofnode_read_pci_v.patch \
    file://0007-drivers-core-of_addr-fix-of_get_dma_range-translatio.patch \
    file://0008-board-raspberrypi-rpi-save-board_type-to-the-global_.patch \
    file://0009-drivers-pci-add-BCM2712-support-for-pcie_brcmstb-dri.patch \
    file://0010-drivers-mfd-introduce-RP1-chip-driver-for-RPI5.patch \
    file://0011-drivers-gpio-add-support-of-RP1-GPIO-for-Raspberry-P.patch \
    file://0012-drivers-reset-introduce-reset-drivers-for-brcmstb.patch \
    file://0013-drivers-clk-introduce-clock-driver-for-RP1.patch \
    file://0014-drivers-net-macb-introduce-ePCI-connection-support-f.patch \
    file://0015-configs-add-support-for-the-Raspberrypi-5-board-to-d.patch \
    file://0016-board-raspberrypi-rpi-request-RP1-in-late_init.patch \
    file://0017-HACK-drivers-mfd-set-bar-configuration-for-RP1-drive.patch \
    file://0018-drivers-pci-pcie_brcmstb-use-bus_base-to-config-PCI-.patch \
    file://0019-drivers-pci-pcie_brcmstb-set-correct-reset-state-on-.patch \
    file://0020-bcm2712-enable-linux-kernel-image-header.patch \
"

SRC_URI:append:raspberrypi4 = "${UBOOT_RPI4_SUPPORT_PATCHES}"
SRC_URI:append:raspberrypi5 = "${UBOOT_RPI5_SUPPORT_PATCHES}"

# Also build a specfic qemu-u-boot.bin

do_configure:append:rpi() {
    rm -rf ${B}-qemu
    mkdir -p ${B}-qemu
    oe_runmake -C ${S} O=${B}-qemu qemu_arm64_config
}

do_compile:append:rpi() {
    echo ${UBOOT_LOCALVERSION} > ${B}-qemu/.scmversion
    oe_runmake -C ${S} O=${B}-qemu ${UBOOT_MAKE_TARGET}
}

do_deploy:append:rpi() {
    ocwd=$PWD
    install -D -m 644 ${B}-qemu/${UBOOT_BINARY} ${DEPLOYDIR}/qemu-${UBOOT_IMAGE}
    cd ${DEPLOYDIR}
    rm -f qemu-${UBOOT_BINARY} qemu-${UBOOT_SYMLINK}
    ln -sf qemu-${UBOOT_IMAGE} qemu-${UBOOT_SYMLINK}
    ln -sf qemu-${UBOOT_IMAGE} qmeu-${UBOOT_BINARY}
    cd $ocwd
}
