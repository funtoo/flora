# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $ID$

EAPI="5"

LANGS=" cs de es fr gl hr_HR id it ja pl pt pt_BR ro ru tr_TR zh_CN"

inherit cmake-utils

MY_PN="Yarock"
MY_PP=""
MY_P="${MY_PN}_${PV}${MY_PP}_source"
DESCRIPTION="Yarock is Qt4/Qt5 modern music player designed to provide an easy and pretty music collection browser based on cover art."
HOMEPAGE="http://qt-apps.org/content/show.php?content=129372"
SRC_URI="http://launchpad.net/yarock/1.x/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="phonon mpv qt4 qt5 vlc"
IUSE+="${LANGS// / linguas_}"

DEPEND="
	qt4? (
		>=dev-qt/qtcore-4.7.0:4
		>=dev-qt/qtgui-4.7.0:4
		>=dev-qt/qtdbus-4.7.0:4
		>=dev-qt/qtsql-4.7.0:4[sqlite]
		dev-libs/qjson
	)
	qt5? (
		>=dev-qt/qtcore-5.3.2:5
		>=dev-qt/qtgui-5.3.2:5
		>=dev-qt/qtwidgets-5.3.2:5
		>=dev-qt/qtnetwork-5.3.2:5
		>=dev-qt/qtxml-5.3.2:5
		>=dev-qt/qtconcurrent-5.3.2:5
		>=dev-qt/qtdbus-5.3.2:5
		dev-qt/linguist-tools:5
		>=dev-qt/qtsql-5.3.2:5[sqlite]
		dev-qt/qtx11extras:5
	)
	media-libs/taglib
	dev-cpp/htmlcxx
	phonon? ( media-libs/phonon[qt4?,qt5?] )
	mpv? ( media-video/mpv[libmpv] )
	vlc? ( media-video/vlc[qt4?,qt5?] )
"

RDEPEND="${DEPEND}"

REQUIRED_USE="|| ( phonon mpv vlc ) ^^ ( qt4 qt5 )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Remove unneeded translations
	rm translation/yarock_en.ts
	for ln in ${LANGS}; do
		! use linguas_${ln} && rm translation/yarock_${ln}.ts
	done
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable phonon)
		$(cmake-utils_use_enable mpv)
		$(cmake-utils_use_enable vlc)
		$(cmake-utils_use_enable qt5)
	)

	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}