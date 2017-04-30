# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4..5} )

inherit python-single-r1

DESCRIPTION="Manage your package.use, keeping track and comments on changes made."
HOMEPAGE="https://github.com/apinsard/chuse"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
SRC_URI="https://github.com/apinsard/${PN}/archive/${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

IUSE=""

DEPEND="dev-python/appi:0/0.0"
RDEPEND="${DEPEND}"

src_prepare() {
	einfo "Converting shebangs for python3..."
	python_fix_shebang chuse
	eapply_user
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
	elog ""
	ewarn "If you are upgrading from chuse 1.0 and you set the"
	ewarn "PACKAGE_USE_FILE_PATTERN environment variable, you will have to"
	ewarn "replace %(cat)s and %(pkg)s by {cat} and {pkg}. Also, you might"
	ewarn "want to move this configuration into /etc/chuse.conf. See chuse(1)"
	ewarn "manual pages for more information about /etc/chuse.conf."
}
