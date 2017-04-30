# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 flag-o-matic

SRC_URI="https://github.com/nathan-hoad/python-iwlib/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="iwlib library for Python, for interacting with wireless devices."
HOMEPAGE="https://github.com/nathan-hoad/python-iwlib/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND="net-wireless/wireless-tools"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

S="${WORKDIR}/python-${P}"

python_compile() {
	local CFLAGS=${CFLAGS} CXXFLAGS=${CXXFLAGS}

	! python_is_python3 && append-flags -fno-strict-aliasing

	distutils-r1_python_compile
}
