# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils eutils

MY_PN="MediaElch"
DESCRIPTION="Video metadata scraper"
SRC_URI=https://github.com/Komet/${MY_PN}/archive/v${PV}.tar.gz
HOMEPAGE="http://www.mediaelch.de/"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="pulseaudio"

# application uses static built quazip
DEPEND="
	dev-qt/qtsql:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtconcurrent:5
	dev-libs/quazip
	media-libs/libmediainfo
	pulseaudio? ( media-sound/pulseaudio )"

RDEPEND="${DEPEND}
dev-qt/qtquickcontrols:5"

src_unpack() {
	unpack v${PV}.tar.gz
	# rename extracted folder(lower case)
	# not renaming causes errors in src_* functions
	mv "${WORKDIR}/${MY_PN}-${PV}" "${WORKDIR}/${PN}-${PV}"
}

src_prepare()
{
	# modify include paths for select source files
	sed 's|quazip/quazip/|quazip5/|g' \
		-i src/export/ExportTemplateLoader.cpp || die "CPP Sed Failed" 
	sed 's|quazip/quazip/|quazip5/|g' \
		-i src/tvShows/TvShowUpdater.cpp || die "CPP Sed Failed" 
	# patch qmake project file to link to quazip dynamic library
	# and disable building internal static qauzip
	eapply "${FILESDIR}/${PN}_external_quazip_qmake.patch" || die
	default
}

src_configure()
{
	eqmake5 ${MY_PN}.pro CONFIG+=release
}

src_install()
{
	emake INSTALL_ROOT="${D}" install
}
