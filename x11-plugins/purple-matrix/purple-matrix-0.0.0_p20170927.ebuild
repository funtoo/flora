# Distributed under the terms of the GNU General Public License v2

EAPI=6

GIT_COMMIT="1a53f61998407013719fdabdcff4ead3e9715340"
DESCRIPTION="A libpurple/Pidgin plugin for matrix.org"
HOMEPAGE="https://github.com/matrix-org/purple-matrix"
SRC_URI="https://github.com/matrix-org/purple-matrix/archive/${GIT_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~*"
IUSE=""

S=${WORKDIR}/${PN}-${GIT_COMMIT}

RDEPEND="dev-libs/glib
	dev-libs/json-glib
	net-im/pidgin
	net-libs/http-parser"
DEPEND="${RDEPEND}"

src_prepare() {
	eapply "${FILESDIR}"/${PN}-Werror.patch
	default
}
