# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python3_{5,6} )

inherit gnome2-utils xdg-utils python-single-r1

DESCRIPTION="A modern, hackable, featureful, OpenGL based terminal emulator"
HOMEPAGE="https://github.com/kovidgoyal/kitty"
SRC_URI="https://github.com/kovidgoyal/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

IUSE="X imagemagick pillow wayland"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"

DEPEND="${PYTHON_DEPS}
	dev-libs/libunistring
	media-libs/fontconfig
	media-libs/freetype
	>=media-libs/harfbuzz-1.5.0
	media-libs/libpng
	sys-libs/zlib
	virtual/pkgconfig
	wayland? ( dev-libs/wayland-protocols )"

RDEPEND="X? ( x11-apps/xrdb x11-misc/xsel )
	imagemagick? ( media-gfx/imagemagick )
	pillow? ( dev-python/pillow )
	${DEPEND}"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"


src_compile() {
	python_setup
	python setup.py linux-package
}

src_install() {
	dobin linux-package/bin/kitty
	insinto /usr/lib
	doins -r linux-package/lib/kitty
	insinto /usr/share
	doins -r linux-package/share/{applications,icons,terminfo,}
	dodoc *.asciidoc
}

pkg_postinst() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	xdg_desktop_database_update
}
