DESCRIPTION = "Broadcom AP6212 firmware files"
SECTION = "connectivity"

SRC_URI = "git://github.com/ARMWorks/dibs.git;branch=master;protocol=https;rev=bee5cbc03bb078b664cd08733b46d88142189dff \
           https://android.googlesource.com/platform/hardware/broadcom/wlan/+/gingerbread-mr4-release/bcm4329/firmware/LICENSE.TXT"

LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${WORKDIR}/LICENSE.TXT;md5=8422d7238586f81a3807a937624d4ecb"

S = "${WORKDIR}/git/targets/jellyfish_overlay/lib/firmware/ap6220/"

do_compile() {
}

do_install() {
        install -v -d  ${D}/etc/firmware/
        install -m 0755 bcm20702a.hcd ${D}/etc/firmware/
        install -m 0755 fw_bcm40181a2.bin ${D}/etc/firmware/
        install -m 0755 fw_bcm40181a2_apsta.bin ${D}/etc/firmware/
        install -m 0755 fw_bcm40181a2_p2p.bin ${D}/etc/firmware/
        install -m 0755 nvram.txt ${D}/etc/firmware/
}

SRC_URI[md5sum] = "8422d7238586f81a3807a937624d4ecb"
SRC_URI[sha256sum] = "9db7b938b43d36f0e34c443e78b8f387ade5ed3a6d5cdf3fe23308726e6804e7"
