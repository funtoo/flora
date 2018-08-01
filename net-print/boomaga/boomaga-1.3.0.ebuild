# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PLOCALES="cs de el eu fr hu_HU it lt nb_NO nl_NL pl_PL ro ru uk_UA uz@Latn"
inherit cmake-utils l10n xdg-utils gnome2-utils

MY_PN="boomaga"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A virtual printer for viewing a document before printing it out using the physical printer."
HOMEPAGE="http://www.boomaga.org/"
SRC_URI="https://github.com/boomaga/boomaga/archive/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RDEPEND="dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	dev-qt/qtcore:5
	app-text/poppler
	net-print/cups"
DEPEND="${RDEPEND}
	dev-qt/linguist-tools:5"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	cmake-utils_src_prepare

	l10n_find_plocales_changes "${S}/src/${PN}/translations" "${PN}_" '.ts'

        rm_ts() {
                rm "${S}/src/${PN}/translations/${PN}_${1}.ts"
                rm -f "${S}/src/${PN}/translations/${PN}_${1}.desktop"
        }

        l10n_for_each_disabled_locale_do rm_ts
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	gnome2_icon_cache_update
}
