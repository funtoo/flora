# Distributed under the terms of the GNU General Public License v2

EAPI=6

SRC_URI="https://github.com/LemonBoy/bar/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="*"

DESCRIPTION="A featherweight, lemon-scented, bar based on xcb"
HOMEPAGE="https://github.com/LemonBoy/bar"

LICENSE="MIT"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/libxcb"
DEPEND="${RDEPEND}"

S="${WORKDIR}/bar-${PV}"
