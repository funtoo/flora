# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Voxelands is a sandbox construction game based on Minetest."
HOMEPAGE="http://www.voxelands.com/"
SRC_URI="https://gitlab.com/voxelands/voxelands/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="+server +client +audio"

RDEPEND="
	dev-games/irrlicht
	media-libs/freetype
	media-libs/openal
	media-libs/libvorbis
	media-libs/libogg
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/jpeg
"

S="${WORKDIR}/${PN}-v${PV}-3ac3f431a26858857f6805ad33f5fe8aaa8d0765"

src_configure() {
	local mycmakeargs=(
		-DBUILD_SERVER="$(usex server)"
		-DBUILD_CLIENT="$(usex client)"
		-DENABLE_AUDIO="$(usex audio)"
	)
	cmake-utils_src_configure
}
