# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="IBM PC emulator"
HOMEPAGE="http://pcem-emulator.co.uk"
SRC_URI="http://pcem-emulator.co.uk/files/PCemV${PV}Linux.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa -debug +networking +release-build"

DEPEND="x11-libs/wxGTK
		virtual/opengl"
RDEPEND="${DEPEND}
		media-libs/libsdl2
		media-libs/openal
		alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack "PCemV${PV}Linux.tar.gz"
	S="${WORKDIR}"
}

src_configure() {
	econf \
		$(use_enable release-build) \
		$(use_enable alsa) \
		$(use_enable debug) \
		$(use_enable networking)
}
src_compile() {
		emake
}

src_install() {
		emake DESTDIR="${D}" install
}
