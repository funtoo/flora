# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

SRC_URI="https://github.com/epsy/od/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Shorthand syntax for building OrderedDicts"
HOMEPAGE="https://github.com/epsy/od/"

LICENSE="MIT"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i "s/py_modules=('od', 'test_od')/py_modules=('od',)/" setup.py
	default
}
