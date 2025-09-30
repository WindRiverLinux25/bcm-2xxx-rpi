do_deploy:append:rpi() {
    # Add LICENSE file with disclaimer
    (cd ${S} ; ls -C -w 80 *.bin *.dat *.elf) > ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/LICENSE.broadcom
    cat<<EOF>> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/LICENSE.broadcom

========================================================================
The following applies to the files found in this directory listed above.
========================================================================

EOF
    cat ${S}/LICENCE.broadcom >> ${DEPLOYDIR}/${BOOTFILES_DIR_NAME}/LICENSE.broadcom
}

# Recently, Yocto require to use git protocol for the github download address, otherwise report a warning.
# Raspberry firmware download address starts with github, but it is released with the style of tar ball, so
# there is a build warning reported when build it. If convert to git protocol, it needs to create a mirror
# of firmware repo that is more than 20GB, it will be a huge resource consumption. Therefore, mask the warning
# directly.
WARN_QA:remove:rpi = "src-uri-bad"
