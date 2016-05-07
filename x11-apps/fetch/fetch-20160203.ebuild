# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit git-2 eutils toolchain-funcs

DESCRIPTION="dylan's fetch script - in other words a pimped up screenfetch"
HOMEPAGE="https://github.com/dylanaraps/fetch.git"
EGIT_REPO_URI="git://github.com/dylanaraps/fetch.git"
EGIT_COMMIT="683043c"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="w3m scrot"

DEPEND="sys-libs/ncurses
		app-shells/bash
		x11-misc/wmctrl
		x11-apps/xdpyinfo
		sys-apps/pciutils
"

RDEPEND="
		${DEPEND}
		w3m? (
			media-gfx/w3mimgfb
			www-client/w3m[imlib,fbcon]
			media-libs/imlib2
			media-gfx/imagemagick
			 )
		scrot? ( media-gfx/scrot )
"

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install
}

