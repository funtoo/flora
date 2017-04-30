# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=( python3_{4..5} )

inherit multilib python-single-r1

DESCRIPTION="Simple tool to manage your package.use keeping track and comments on changes made."
HOMEPAGE="https://github.com/apinsard/chuse"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~*"
GITHUB_REPO="${PN}"
GITHUB_USER="apinsard"
GITHUB_TAG="${PV}"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> chuse-${GITHUB_TAG}.tar.gz"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv "${WORKDIR}/${GITHUB_USER}-${PN}"-??????? "${S}" || die
}

src_prepare() {
	einfo "Converting shebangs for python3..."
	python_fix_shebang chuse
}

src_compile() {
	mkdir -p man
	pod2man chuse.pod > man/chuse.1
}

src_install() {
	into /usr/
	dosbin chuse
	doman man/chuse.1
	dodoc ChangeLog
}

pkg_info() {
	"${ROOT}"/usr/sbin/chuse --version
}

pkg_postinst() {
	elog "If this is the first time you install chuse, you may have to setup"
	elog "your package.use hierarchy pattern. For details, please see the"
	elog "EXAMPLES section of chuse(1) manual page."
}
