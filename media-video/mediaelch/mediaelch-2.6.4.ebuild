# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils xdg-utils gnome2-utils

MY_PN="MediaElch"
DESCRIPTION="Video metadata scraper"
SRC_URI="https://github.com/Komet/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://www.mediaelch.de/"
S="${WORKDIR}/${MY_PN}-${PV}"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

# application uses static built quazip
DEPEND="
	dev-qt/qtsql:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-libs/quazip
	media-libs/libmediainfo"

RDEPEND="${DEPEND}
dev-qt/qtquickcontrols:5"

src_prepare()
{
	cmake-utils_src_prepare
}

src_configure()
{
        local mycmakeargs=(
		-DUSE_EXTERN_QUAZIP="On"
		-DDISABLE_UPDATER="On"
		-DCMAKE_INSTALL_PREFIX="/usr"
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
