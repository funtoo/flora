# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

SRC_URI="https://github.com/hgrecco/pint/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Operate and manipulate physical quantities in Python"
HOMEPAGE="http://pint.readthedocs.org/"

LICENSE="BSD"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
