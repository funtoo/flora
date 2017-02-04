# Distributed under the terms of the GNU General Public License v2

EAPI=6


DESCRIPTION="ChakraCore is the core part of the Chakra Javascript engine that powers Microsoft Edge"
HOMEPAGE="https://github.com/Microsoft/ChakraCore/"
SRC_URI="https://github.com/Microsoft/ChakraCore/archive/v${PV}.tar.gz -> ${P}.tar.gz"

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
	./build.sh || die "Build failed"
}

src_install() {
	into /usr
	dobin BuildLinux/Release/ch
	dolib BuildLinux/Release/libChakraCore.so
}
