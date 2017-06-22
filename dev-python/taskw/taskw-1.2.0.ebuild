# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_{4..6}} )

inherit distutils-r1

HOMEPAGE="https://github.com/ralphbean/taskw/"
SRC_URI="${HOMEPAGE}archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~*"

DESCRIPTION="Python bindings for your taskwarrior database"

LICENSE="GPL"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND="dev-python/six[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	dev-python/kitchen[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	python_targets_python2_7? ( dev-python/ordereddict[python_targets_python2_7] )
	app-misc/task
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
