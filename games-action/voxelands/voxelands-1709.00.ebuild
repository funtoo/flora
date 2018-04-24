# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Voxelands is a sandbox construction game based on Minetest."
HOMEPAGE="http://www.voxelands.com/"
SRC_URI="https://github.com/voxelands/voxelands/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="+server +client +audio"

RDEPEND="
	dev-games/irrlicht
	media-libs/freetype
	audio? (
		media-libs/openal
		media-libs/libvorbis
		media-libs/libogg
	)
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/jpeg
"

src_prepare() {
	default
	sed -i 's:^#include "\(.*\)\.h"$:#include "../\1.h":' src/{mapgen,nodemeta}/*.cpp
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SERVER="$(usex server)"
		-DBUILD_CLIENT="$(usex client)"
		-DENABLE_AUDIO="$(usex audio)"
	)
	cmake-utils_src_configure
}
