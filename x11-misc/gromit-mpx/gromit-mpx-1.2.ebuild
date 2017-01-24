# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Gromit-MPX is a multi-pointer port of the original Gromit annotation tool by Simon Budig."
HOMEPAGE="https://github.com/bk138/gromit-mpx"
SRC_URI="https://github.com/bk138/gromit-mpx/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="wayland"

RDEPEND="dev-libs/glib
	dev-libs/libappindicator:3
	x11-libs/libXi
	x11-libs/gtk+:3[wayland?]
"
DEPEND="${RDEPEND}"
