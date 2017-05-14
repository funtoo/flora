# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit flag-o-matic cmake-utils

DESCRIPTION="PosteRazor cuts raster images into multipage PDF documents."
HOMEPAGE="http://posterazor.sourceforge.net/"
SRC_URI="mirror://funtoo/PosteRazor-1.5.1-Source.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""
S=${WORKDIR}/src

DEPEND="dev-util/cmake"
RDEPEND="${DEPEND}
		media-libs/freeimage
		x11-libs/fltk
		x11-libs/libXpm
		"

src_prepare() {
	sed -i -e '/PosteRazorWizardDialogController.h/a#include <unistd.h>' FlPosteRazorDialog.h || die "sed failed"
	eapply "${FILESDIR}"/${PN}-gcc.patch
	#eapply "${FILESDIR}"/${PN}-1.5-format-security.patch
	cmake-utils_src_prepare
}

src_configure() {
	append-ldflags "-L$(dirname $(fltk-config --libs))"
	append-flags "-I/usr/include/fltk"
	cmake-utils_src_configure
}

src_install() {
	exeinto /usr/bin
	doexe ${WORKDIR}/${P}_build/PosteRazor
	newicon ${S}/PosteRazor.xpm ${PN}.xpm
	make_desktop_entry PosteRazor "PosteRazor" /usr/share/pixmaps/${PN}.xpm
}

