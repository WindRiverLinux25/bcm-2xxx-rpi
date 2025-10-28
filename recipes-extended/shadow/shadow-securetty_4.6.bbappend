do_install:append:raspberrypi5 () {
        echo 'ttyAMA10' >> ${D}${sysconfdir}/securetty
}

