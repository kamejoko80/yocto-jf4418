require recipes-kernel/linux/linux-jf4418.inc
DESCRIPTION = "Linux kernel for JF4418"
KERNEL_IMAGETYPE = "uImage"

COMPATIBLE_MACHINE = "(jf4418)"

PV = "3.4.1"
PR = "r0"
SRCREV_pn-${PN} = "0c63bb5b6c3bac24c37d021c83c013a48dbc6017"

SRC_URI += "https://github.com/pdtechvn/linux-3.4.x.git"

S = "${WORKDIR}/linux-3.4.x"
LDFLAGS = ""
TARGET_LDFLAGS = ""
B = "${S}"

