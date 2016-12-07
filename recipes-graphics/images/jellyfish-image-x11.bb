DESCRIPTION = "A compact test and discovery image for low resource boards"
LICENSE = "MIT"

IMAGE_FEATURES += "splash package-management x11-base ssh-server-dropbear "

TOUCH = ' ${@base_contains("MACHINE_FEATURES", "touchscreen", "tslib tslib-calibrate tslib-tests", "",d)}'


inherit core-image

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    i2c-tools \
    lrzsz \
    brcm-patchram-plus \
    ap6212-firmware-jellyfish \
    ${CORE_IMAGE_EXTRA_INSTALL} \
    ${TOUCH} \
"
 