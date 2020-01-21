# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils eutils gnome2-utils xdg-utils
MY_PN="FeatherPad"
DESCRIPTION="A lightweight Qt5 plain-text editor for Linux"
HOMEPAGE="https://github.com/tsujan/FeatherPad"
SRC_URI="https://github.com/tsujan/${MY_PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_PN}-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BDEPEND="virtual/pkgconfig"

RDEPEND="x11-libs/libXext
	dev-qt/qtx11extras:5
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/linguist:5"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
        -DCMAKE_BUILD_TYPE="Release" 
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	# remove symbolic link - unnecessary
	rm ${D}/usr/bin/fpad
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

