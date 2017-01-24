# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="GRaphics Over MIscellaneous Things, a presentation helper"
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
