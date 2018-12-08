# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Hides mouse pointer while not in use, Airbladers xfixes version"
HOMEPAGE="https://github.com/Airblader/unclutter-xfixes"
SRC_URI="https://github.com/Airblader/unclutter-xfixes/archive/v${PV}.tar.gz"

SLOT="0"
LICENSE="MIT"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}
	!x11-misc/unclutter
	x11-libs/libXfixes
	x11-libs/libXi
	app-text/asciidoc
	dev-libs/libev"

S=${WORKDIR}/${P}

src_compile() {
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" LDOPTIONS="${LDFLAGS}"
}

src_install () {
	dobin unclutter
	doman ${S}/man/unclutter-xfixes.1
}
