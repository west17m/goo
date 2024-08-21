# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
ETYPE="sources"

inherit kernel-2 unpacker

DESCRIPTION="Genkernel overlay to build an initrd with ssh, luks, and zfs capability"
HOMEPAGE="https://github.com/west17m/"
# SRC_URI="https://github.com/west17m/${PN}/releases/tag/${PVR}"
SRC_URI="https://github.com/west17m/remote-luks-zfs-initramfs/archive/refs/tags/1.0.1.tar.gz"

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
	dodir /usr/src/${PN}
	insinto /usr/src/${PN}
	# cp -r ${S}/etc ${S}/root ${D}/usr/src/${PN}
	doins -r ${S}/clean.sh clean.sh
	doins -r ${S}/etc etc
	doins -r ${S}/root root
}

pkg_postinst() {
	#@TODO check if loop.crypt has been created
	elog "You need to generate loop.crypt to hold your keyfile."
	elog "Unfortunately, that functionality not-yet provided by"
	elog "this package."
}
