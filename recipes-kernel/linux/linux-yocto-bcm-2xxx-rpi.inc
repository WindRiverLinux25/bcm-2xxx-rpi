#
# Copyright (C) 2019 Wind River Systems, Inc.
#

TARGET_SUPPORTED_KTYPES:rpi = "standard preempt-rt"
COMPATIBLE_MACHINE:rpi = "(bcm-2xxx-rpi4|bcm-2xxx-rpi5)"
KMACHINE:rpi = "bcm-2xxx-rpi4"

inherit siteinfo
KERNEL_DTC_FLAGS:append:rpi = " -@ -H epapr"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append:rpi = " \
    file://0001-arm64-dts-enable-cgroup-memory-controller-for-raspbe.patch \
    file://rpi.cfg \
"
