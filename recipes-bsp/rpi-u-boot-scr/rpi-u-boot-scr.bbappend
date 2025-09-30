EXTERNAL_BOOT_CMD_IN ??= ""
do_compile:rpi() {
    if [ -n "${EXTERNAL_BOOT_CMD_IN}" -a -f "${EXTERNAL_BOOT_CMD_IN}" ]; then
        sed -e 's/@@KERNEL_IMAGETYPE@@/Image/' \
            -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
            -e 's/@@BOOT_MEDIA@@/${BOOT_MEDIA}/' \
            -e '/if test ! -e mmc 0:1 uboot.env; then saveenv; fi;/d' \
            "${EXTERNAL_BOOT_CMD_IN}" > "${WORKDIR}/boot.cmd"
    else
        sed -e 's/@@KERNEL_IMAGETYPE@@/Image/' \
            -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
            -e 's/@@BOOT_MEDIA@@/${BOOT_MEDIA}/' \
            -e '/if test ! -e mmc 0:1 uboot.env; then saveenv; fi;/d' \
            "${S}/boot.cmd.in" > "${WORKDIR}/boot.cmd"
    fi
    mkimage -A arm -T script -C none -n "Boot script" -d "${WORKDIR}/boot.cmd" boot.scr
}

do_deploy:rpi() {
    install -d ${DEPLOYDIR}
    if ${@bb.utils.contains('DISTRO_FEATURES', 'ostree', 'true', 'false', d)}; then
        install -m 0644 boot.scr ${DEPLOYDIR}/boot-rpi.scr
    else
        install -m 0644 boot.scr ${DEPLOYDIR}
    fi
}

addtask do_deploy after do_compile before do_build

PACKAGE_ARCH = "${MACHINE_ARCH}"
