# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

SRC_URI="https://github.com/epsy/clize/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Command-line argument parsing for Python, without the effort"
HOMEPAGE="https://github.com/epsy/clize/"

LICENSE="MIT"
SLOT="0"
IUSE="datetime"

REQUIRED_USE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-python/attrs[${PYTHON_USEDEP}]
	dev-python/od[${PYTHON_USEDEP}]
	>=dev-python/sigtools-2.0[${PYTHON_USEDEP}]
	dev-python/docutils[${PYTHON_USEDEP}]
	datetime? ( dev-python/python-dateutil[${PYTHON_USEDEP}] )
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_prepare() {
	sed -i "s/packages=('clize', 'clize.tests')/packages=('clize',)/" setup.py
	default
}
