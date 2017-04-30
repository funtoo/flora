# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

SRC_URI=""
EGIT_REPO_URI="https://github.com/sametmax/0bin.git"
EGIT_BRANCH="master"
KEYWORDS="~*"

DESCRIPTION="Paste content of files or stdin to a 0bin site."
HOMEPAGE="https://github.com/sametmax/0bin/"

LICENSE="WTFPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND="net-libs/nodejs"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}/tools"

src_install() {
	into /usr
	dobin zerobinpaste
}
