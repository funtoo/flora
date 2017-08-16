# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="The secure Argon2 password hashing algorithm."
HOMEPAGE="https://argon2-cffi.readthedocs.io/
	https://pypi.python.org/pypi/argon2_cffi/
	https://github.com/hynek/argon2_cffi"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="app-crypt/argon2
	>=dev-python/cffi-1.0.0[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( ${FILESDIR}/donot_compile_bundled_lib.patch )
