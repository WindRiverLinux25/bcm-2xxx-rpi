#
# Copyright (C) 2019 Wind River Systems, Inc.
#

TARGET_SUPPORTED_KTYPES:rpi = "standard preempt-rt"
COMPATIBLE_MACHINE:rpi = "bcm-2xxx-rpi4"

inherit siteinfo
KERNEL_DTC_FLAGS:append:rpi = " -@ -H epapr"
