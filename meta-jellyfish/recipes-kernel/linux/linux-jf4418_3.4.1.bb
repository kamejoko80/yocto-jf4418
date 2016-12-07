require recipes-kernel/linux/linux-jf4418.inc
DESCRIPTION = "Linux kernel for JF4418"
KERNEL_IMAGETYPE = "uImage"

COMPATIBLE_MACHINE = "(jf4418)"

PV = "3.4.1"
PR = "r0"
SRCREV_pn-${PN} = "c9efdea291a03fb607688459a4d3f4cd2a98fb9d"

SRC_URI += "git://github.com/pdtechvn/linux-3.4.x.git"

S = "${WORKDIR}/linux-3.4.x"
LDFLAGS = ""
TARGET_LDFLAGS = ""
B = "${S}"

