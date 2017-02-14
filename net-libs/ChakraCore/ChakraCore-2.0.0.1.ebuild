# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="ChakraCore is the core part of the Chakra Javascript engine that powers Microsoft Edge"
HOMEPAGE="https://github.com/CauldronDevelopmentLLC/ChakraCore/"
SRC_URI="https://github.com/CauldronDevelopmentLLC/ChakraCore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT=0
KEYWORDS="~*"

RDEPEND="
	sys-libs/libunwind
	dev-libs/icu
"
DEPEND="${RDEPEND}
	>=sys-devel/clang-3.7
	=dev-lang/python-2*
	dev-util/cmake
"

src_compile() {
	./build.sh --static -j 8 || die "Build failed"
}

src_install() {
	cd $T
	for i in $(find ${S}/Build* -name \*.a); do
		ar x $i
	done
	ar rcs ${S}/libChakraCore.a *.o
	dodir /opt/${PN}
	insinto /opt/${PN}
	doins -r ${S}/*
}
