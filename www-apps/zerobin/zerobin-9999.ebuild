# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_6} )

inherit distutils-r1 git-r3

SRC_URI=""
EGIT_REPO_URI="https://github.com/sametmax/0bin.git"
EGIT_BRANCH="master"
KEYWORDS="~*"

DESCRIPTION="A client side encrypted pastebin"
HOMEPAGE="https://github.com/sametmax/0bin/"

LICENSE="WTFPL-2"
SLOT="0"
IUSE=""

REQUIRED_USE=""

RDEPEND="dev-python/cherrypy[${PYTHON_USEDEP}]
	dev-python/bottle[${PYTHON_USEDEP}]
	dev-python/clize[${PYTHON_USEDEP}]
	dev-python/lockfile[${PYTHON_USEDEP}]
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
