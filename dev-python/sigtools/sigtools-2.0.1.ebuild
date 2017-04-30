# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

SRC_URI="https://github.com/epsy/sigtools/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Utilities for working with inspect.Signature objects"
HOMEPAGE="https://github.com/epsy/sigtools/"

LICENSE="MIT"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '>=dev-python/funcsigs-0.4[${PYTHON_USEDEP}]' 'python2*')
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i "s/packages=\['sigtools', 'sigtools.tests'\]/packages=\['sigtools'\]/" setup.py
	default
}
