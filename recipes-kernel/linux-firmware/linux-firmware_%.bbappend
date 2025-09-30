do_install:append:rpi() {
	cd ${D}/${nonarch_base_libdir}/firmware/brcm/
	ln -sf brcmfmac43455-sdio.bin brcmfmac43455-sdio.raspberrypi,4-model-b.bin
	cd -
}
