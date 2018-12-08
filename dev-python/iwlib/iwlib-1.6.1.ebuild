# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6} )

inherit distutils-r1 flag-o-matic

SRC_URI="https://github.com/nathan-hoad/python-iwlib/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="iwlib library for Python, for interacting with wireless devices."
HOMEPAGE="https://github.com/nathan-hoad/python-iwlib/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""
RDEPEND="${DEPEND}"
DEPEND="
	net-wireless/wireless-tools
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/cffi[${PYTHON_USEDEP}]
"

S="${WORKDIR}/python-${P}"

python_compile() {
	local CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}

	! python_is_python3 && append-flags -fno-strict-aliasing

	distutils-r1_python_compile
}
