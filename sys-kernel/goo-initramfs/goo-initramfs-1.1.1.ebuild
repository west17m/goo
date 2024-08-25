# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ETYPE="sources"

inherit kernel-2 unpacker

DESCRIPTION="Genkernel overlay to build an initrd with ssh, luks, and zfs capability"
HOMEPAGE="https://github.com/west17m/"
SRC_URI="https://github.com/west17m/goo-initramfs/archive/refs/tags/${PV}.tar.gz"

S="${WORKDIR}/${P}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=sys-kernel/genkernel-4.3.10"

# this unpackes as expected
src_unpack() {
	if [[ -n ${A} ]]; then
		unpack "${PVR}.tar.gz"
	fi
}

src_install() {
	insinto /usr/src/${PN}
	doins -r "${S}"/sourceroot
	dobin bin/goo-initrd
}

pkg_postinst() {
	#@TODO check if loop.crypt has been created
	elog "Generate your keyfile with"
	elog "goo-initrd make-keyfile"
	elog "and place it in /usr/src/goo-initramfs"
	elog "Run the following to generate the initrd file"
	elog "goo-initrd make-initrd"
}
