# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit qmake-utils eutils

MY_PN="MediaElch"
DESCRIPTION="Video metadata scraper"
SRC_URI="https://github.com/Komet/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"
HOMEPAGE="http://www.mediaelch.de/"
S="${WORKDIR}/${MY_PN}-${PV}"

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

PATCHES=(
	"${FILESDIR}/${PN}_external_quazip_qmake.patch"
	"${FILESDIR}/${PN}_external_quazip_TvShowUpdater.patch"
	"${FILESDIR}/${PN}_external_quazip_ExportTemplateLoader.patch"
)

src_prepare()
{
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
