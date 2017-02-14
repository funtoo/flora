# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib scons-utils toolchain-funcs

DESCRIPTION="C! (cbang) is a library of cross-platform C++ utilities"
HOMEPAGE="https://github.com/CauldronDevelopmentLLC/cbang"
SRC_URI="https://github.com/CauldronDevelopmentLLC/cbang/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT=0
KEYWORDS="~*"

IUSE="ChakraCore"

RDEPEND="
	dev-libs/boost
	ChakraCore? ( net-libs/ChakraCore )
"
DEPEND="${RDEPEND}
"

src_configure() {
	MYSCONS=(
		TARGET_ARCH="$(tc-arch)"
		PTHREAD_LIBPATH="$(get_libdir)"
		PTHREAD_LIBNAME="libpthread.so.1"
	)
}

src_compile() {
	escons "${MYSCONS[@]}"
}
