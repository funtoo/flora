# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit eutils

MY_PV=${PV/_p/-}

DESCRIPTION="mkcue generates cue sheets from a CD's TOC"
HOMEPAGE="https://diplodocus.org/projects/audio/"
SRC_URI="http://http.debian.net/debian/pool/main/m/${PN}/${PN}_1.orig.tar.gz http://http.debian.net/debian/pool/main/m/${PN}/${PN}_${MY_PV}.debian.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

RESTRICT="mirror"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-1.orig

src_prepare() {
	local d=${WORKDIR}/debian/patches
	EPATCH_SOURCE=${d} epatch $(<"${d}"/series)
}

src_install() {
	# make install does not work because target directory does not exist
	dobin mkcue
	dodoc README
}
