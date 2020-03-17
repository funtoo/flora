# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson ninja-utils
DESCRIPTION="Solus Project's Brisk Menu MATE Panel Applet"
HOMEPAGE="https://github.com/getsolus/brisk-menu"

KEYWORDS="*"
LICENSE="GPL-2 CC-BY-SA-4.0"

SLOT="0"
IUSE=""

GITHUB_REPO="brisk-menu"
GITHUB_USER="getsolus"
GITHUB_TAG="v0.6.1"

SRC_URI="https://www.github.com/${GITHUB_USER}/${GITHUB_REPO}/releases/download/${GITHUB_TAG}/brisk-menu-${GITHUB_TAG}.tar.xz -> ${PN}-${GITHUB_TAG}.tar"

DEPEND="
	>=x11-libs/gtk+-3.18:3
	>=x11-libs/libnotify-0.7.0
	>=x11-libs/gtk+-3.22
	>=mate-base/mate-panel-1.16.0
	>=dev-libs/glib-2.44:2
	dev-perl/XML-Parser
	dev-util/intltool
	dev-util/ninja
	gnome-base/dconf
	sys-devel/gettext
	app-arch/xz-utils
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${PN}-${GITHUB_TAG}" "${S}" || die
}

src_configure() {
	# Build Arguments
	local mesonargs=(
		--buildtype plain build
		--prefix "/usr"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}
