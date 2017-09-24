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
LINGUAS="af_ZA da de es fr hu hy it ja jbo nl no pl pt_BR ro ru vi"

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
src_unpack() {
	default
	mv "${WORKDIR}/${PN}-v${PV}"-* "${S}"
}

src_prepare() {
	default
	sed -i 's:^#include "\(.*\)\.h"$:#include "../\1.h":' src/{mapgen,nodemeta}/*.cpp
	for lingua in ${LINGUAS}; do
		if ! has ${lingua//[_@]/-}; then
			rm -rf po/$lingua
		fi
	done
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SERVER="$(usex server)"
		-DBUILD_CLIENT="$(usex client)"
		-DENABLE_AUDIO="$(usex audio)"
	)
	cmake-utils_src_configure
}
