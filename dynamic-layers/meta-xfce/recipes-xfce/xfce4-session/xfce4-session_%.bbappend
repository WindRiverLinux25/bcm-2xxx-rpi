FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:rpi4 = " file://hidden-suspend-button.patch"
