# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils cmake-utils git-r3

DESCRIPTION="Linux SDL/ImGui edition software for viewing .brd files, intended as a drop-in replacement for the \"Test_Link\" software and \"Landrex\""
HOMEPAGE="http://openboardview.org/"
EGIT_REPO_URI="https://github.com/OpenBoardView/OpenBoardView"
EGIT_COMMIT="R${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/gtk+:3
	media-libs/libsdl2
	sys-libs/zlib
	dev-db/sqlite
	media-libs/fontconfig
"
RDEPEND="${DEPEND}"

