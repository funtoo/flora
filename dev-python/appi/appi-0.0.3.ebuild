# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{4..5} )

inherit distutils-r1

APPI_VERSION=${PV%.*}
APPI_RELEASE=${PV##*.}

if [ "$APPI_RELEASE" = 9999 ]; then
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://gitlab.com/apinsard/appi.git"
	EGIT_BRANCH="${APPI_VERSION}"
	KEYWORDS=""
else
	SRC_URI="https://gitlab.com/apinsard/appi/repository/archive.tar.gz?ref=v${PV} -> ${P}.tar.gz"
	KEYWORDS="~*"
fi


DESCRIPTION="Another Portage Python Interface"
HOMEPAGE="https://gitlab.com/apinsard/appi/"

LICENSE="GPL-2"
SLOT="0/${APPI_VERSION}"
IUSE=""

REQUIRED_USE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"

src_unpack() {
	if [ "$APPI_RELEASE" = 9999 ]; then
		git-r3_src_unpack
	else
		default
		mv "${WORKDIR}/${PN}-v${PV}"-* "${S}"
	fi
}
