MACHINE_FEATURES:append:rpi = " vc4graphics"

XSERVER = " \
    xserver-xorg \
    ${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "xserver-xorg-extension-glx", "", d)} \
    ${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "xf86-video-modesetting", "xf86-video-fbdev", d)} \
"

WRL_RECIPES:openembedded-layer += 'libmms'

PREFERRED_PROVIDER_virtual/egl = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "mesa", "userland", d)}"
PREFERRED_PROVIDER_virtual/libgles2 = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "mesa", "userland", d)}"
PREFERRED_PROVIDER_virtual/libgl = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "mesa", "mesa-gl", d)}"
PREFERRED_PROVIDER_virtual/mesa = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "mesa", "mesa-gl", d)}"
PREFERRED_PROVIDER_virtual/libgbm = "${@bb.utils.contains("MACHINE_FEATURES", "vc4graphics", "mesa", "mesa-gl", d)}"
