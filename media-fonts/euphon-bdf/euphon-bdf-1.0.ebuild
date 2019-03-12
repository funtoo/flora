# Distributed under the terms of the BSD License

EAPI=6

inherit font

MY_PN="${PN/d/D}"

# $PV is a build number, use fontforge to find it out. 113 was taken from:
DESCRIPTION="Cool fonts for cool kids"
HOMEPAGE="https://github.com/eti0/fonts"
SRC_URI="https://www.area31.net.br/downloads/ebuilds/releases/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}/${PN}"
FONT_S="${S}"
FONT_SUFFIX="bdf"
