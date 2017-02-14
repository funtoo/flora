# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib scons-utils toolchain-funcs

DESCRIPTION="Open-Source Simulation & Computer Aided Machining - A 3-axis CNC GCode simulator "
HOMEPAGE="https://github.com/CauldronDevelopmentLLC/CAMotics"
SRC_URI="https://github.com/CauldronDevelopmentLLC/CAMotics/archive/${PV}-release.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT=0
KEYWORDS="~*"

IUSE=""

RDEPEND="
	dev-libs/cbang[ChakraCore]
	net-libs/ChakraCore
	dev-qt/qtcore:4
	dev-qt/qtopengl:4
	dev-qt/qtgui:4
	x11-libs/cairo
"
DEPEND="${RDEPEND}
"

S="${WORKDIR}/${P}-release"

src_configure() {
	export CHAKRA_CORE_HOME="/opt/ChakraCore"
	export CBANG_HOME="/opt/cbang"
	MYSCONS=( -C ${S} )
}

src_compile() {
	escons "${MYSCONS[@]}"
}

src_install() {
	dobin camotics camsim gcodetool tplang
	dolib libCAMotics.a
	dolib libclipper.a
	domenu CAMotics.desktop
}
