# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( pypy{,3} python{2_7,3_3,3_4,3_5} )

inherit distutils-r1

DESCRIPTION="Exif manipulation with pure python script"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.zip"
HOMEPAGE="https://github.com/hMatoba/Piexif
	https://pypi.python.org/pypi/piexif"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~*"

COMMON_DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${COMMON_DEPEND}
	app-arch/unzip"
RDEPEND=${COMMON_DEPEND}

RESTRICT="mirror"

DOCS=( README.rst )