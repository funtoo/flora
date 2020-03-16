# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8} )
DISTUTILS_OPTIONAL=1

inherit cmake-utils desktop xdg distutils-r1 java-pkg-opt-2

DESCRIPTION="Library for real time MIDI input and output"
HOMEPAGE="http://portmedia.sourceforge.net/"
SRC_URI="https://sourceforge.net/code-snapshots/svn/p/po/portmedia/code/portmedia-code-r${PV}-${PN}-trunk.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="*"
IUSE="debug doc java python static-libs test-programs"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

BDEPEND="
	app-arch/unzip
	doc? (
		app-doc/doxygen
		dev-texlive/texlive-fontsrecommended
		dev-texlive/texlive-latexextra
		virtual/latex-base
	)
	python? ( >=dev-python/cython-0.12.1[${PYTHON_USEDEP}] )
"
CDEPEND="
	media-libs/alsa-lib
	python? ( ${PYTHON_DEPS} )
"
RDEPEND="${CDEPEND}
	java? ( >=virtual/jre-1.8 )
"
DEPEND="
	${CDEPEND}
	java? ( >=virtual/jdk-1.8 )
"

S="${WORKDIR}/portmedia-code-r${PV}-${PN}-trunk"

PATCHES=(
	# fix parallel make failures, fix java support, and allow optional
	# components like test programs and static libs to be skipped
	"${FILESDIR}"/${P}-cmake.patch
	# fix implicit function declarations
	"${FILESDIR}"/${P}-headers.patch
#	# add include directories and remove references to missing files
	"${FILESDIR}"/${P}-python.patch
)

pkg_setup() {
	use java && java-pkg-opt-2_pkg_setup
}

src_prepare() {
cmake-utils_src_prepare

	# install wrapper for pmdefaults
	if use java ; then
		cat > pm_java/pmdefaults/pmdefaults <<-EOF
			#!/bin/sh
			java -Djava.library.path="${EPREFIX}/usr/$(get_libdir)/" \\
				-jar "${EPREFIX}/usr/share/${PN}/lib/pmdefaults.jar"
		EOF
		[[ $? -ne 0 ]] && die "cat pmdefaults failed"
	fi
}

src_configure() {
	if use debug ; then
		CMAKE_BUILD_TYPE=Debug
	else
		CMAKE_BUILD_TYPE=Release
	fi
	local mycmakeargs=(
		-DPORTMIDI_ENABLE_JAVA=$(usex java)
		-DPORTMIDI_ENABLE_STATIC=$(usex static-libs)
		-DPORTMIDI_ENABLE_TEST=$(usex test-programs)
	)

	if use java ; then
		mycmakeargs+=(-DJAR_INSTALL_DIR="${EPREFIX}/usr/share/${PN}/lib")
	fi

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile

	if use python ; then
		pushd pm_python > /dev/null
		distutils-r1_src_compile
		popd > /dev/null
	fi

	if use doc ; then
		doxygen || die "doxygen failed"
		pushd latex > /dev/null
		VARTEXFONTS="${T}"/fonts emake
		popd > /dev/null
	fi
}

src_install() {
	cmake-utils_src_install

	dodoc CHANGELOG.txt README.txt pm_linux/README_LINUX.txt

	use doc && dodoc latex/refman.pdf

	if use python ; then
		pushd pm_python > /dev/null
		distutils-r1_src_install
		popd > /dev/null
	fi

	if use java ; then
		newdoc pm_java/README.txt README_JAVA.txt
		newicon pm_java/pmdefaults/pmdefaults-icon.png pmdefaults.png
		make_desktop_entry pmdefaults Pmdefaults pmdefaults "AudioVideo;Audio;Midi;"
	fi
}
