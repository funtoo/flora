# Distributed under the terms of the GNU General Public License v2

EAPI=6

MOZ_LANGS=( ach af an ar as ast az bg bn-BD bn-IN br bs ca cak cs cy da de dsb
	el en en-GB en-US en-ZA eo es-AR es-CL es-ES es-MX et eu fa ff fi fr fy-NL
	ga-IE gd gl gu-IN he hi-IN hr hsb hu hy-AM id is it ja ka kab kk km kn ko
	lt lij lv mai mk ml mr ms nb-NO nl nn-NO or pa-IN pl pt-BR pt-PT rm ro ru
	si sk sl son sq sr sv-SE ta te th tr uk uz vi xh zh-CN zh-TW )

MOZ_PN="${PN/-bin}"
MOZ_P="${MOZ_PN}-${PV}"

MOZ_HTTP_URI="http://ftp.gnu.org/gnu/gnuzilla"
#MOZ_HTTP_URI="mirror://gnu/gnuzilla"
#MOZ_HTTP_URI="http://ftp.jaist.ac.jp/pub/GNU/gnuzilla"
MOZ_LANGPACK_PREFIX="${PV}/langpacks/${MOZ_P}."
MOZ_LANGPACK_SUFFIX=".langpack.xpi"

inherit eutils multilib pax-utils fdo-mime gnome2-utils mozlinguas-v2 nsplugins

DESCRIPTION="GNU IceCat is a entirely free software version of Firefox browser"
SRC_URI="${SRC_URI}
	amd64? ( ${MOZ_HTTP_URI}/${PV}/${MOZ_P}.en-US.linux-x86_64.tar.bz2 -> ${PN}_x86_64-${PV}.tar.bz2 )
	x86? ( ${MOZ_HTTP_URI}/${PV}/${MOZ_P}.en-US.linux-i686.tar.bz2 -> ${PN}_i686-${PV}.tar.bz2 )"
HOMEPAGE="https://www.gnu.org/software/gnuzilla/"
RESTRICT="strip mirror"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MPL-2.0 GPL-3 LGPL-2.1 LGPL-3"
IUSE="selinux startup-notification"

DEPEND="app-arch/unzip"
RDEPEND="dev-libs/atk
	>=sys-apps/dbus-0.60
	>=dev-libs/dbus-glib-0.72
	>=dev-libs/glib-2.26:2
	>=media-libs/alsa-lib-1.0.16
	media-libs/fontconfig
	>=media-libs/freetype-2.4.10
	>=x11-libs/cairo-1.10[X]
	x11-libs/gdk-pixbuf
	>=x11-libs/gtk+-2.18:2
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXt
	>=x11-libs/pango-1.22.0
	virtual/freedesktop-icon-theme
	selinux? ( sec-policy/selinux-mozilla )
"

QA_PREBUILT="
	opt/${MOZ_PN}/*.so
	opt/${MOZ_PN}/${MOZ_PN}
	opt/${MOZ_PN}/${PN}
	opt/${MOZ_PN}/webapprt-stub
	opt/${MOZ_PN}/plugin-container
"

S="${WORKDIR}/${MOZ_PN}"

src_unpack() {
	unpack ${A}
	mozlinguas_src_unpack
}

src_install() {
	declare MOZILLA_FIVE_HOME=/opt/${MOZ_PN}

	local size sizes icon_path icon name
	sizes="16 32 48"
	icon_path="${S}/browser/chrome/icons/default"
	icon="${PN}"
	name="GNU IceCat"

	for size in ${sizes}; do
		insinto "/usr/share/icons/hicolor/${size}x${size}/apps"
		newins "${icon_path}/default${size}.png" "${icon}.png" || die
	done
	# The 128x128 icon has a different name
	insinto /usr/share/icons/hicolor/128x128/apps
	newins "${icon_path}/../../../icons/mozicon128.png" "${icon}.png" || die
	# Install a 48x48 icon into /usr/share/pixmaps for legacy DEs
	newicon "${S}"/browser/chrome/icons/default/default48.png ${PN}.png
	domenu "${FILESDIR}"/${PN}.desktop

	if use startup-notification; then
		echo "StartupNotify=true" >> "${ED}"usr/share/applications/${PN}.desktop
	fi

	dodir ${MOZILLA_FIVE_HOME%/*}
	mv "${S}" "${ED}"${MOZILLA_FIVE_HOME} || die

	# Fix prefs that make no sense for a system-wide install
	insinto ${MOZILLA_FIVE_HOME}/defaults/pref/
	doins "${FILESDIR}"/local-settings.js
	# Copy preferences file so we can do a simple rename.
	cp "${FILESDIR}"/all-gentoo-1.js \
		"${ED}"${MOZILLA_FIVE_HOME}/all-gentoo.js || die

	mozlinguas_src_install

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		elog "Setting default locale to ${LANG}"
		echo "pref(\"general.useragent.locale\", \"${LANG}\");" \
			>> "${ED}${MOZILLA_FIVE_HOME}"/defaults/pref/${PN}-prefs.js || \
			die "sed failed to change locale"
	fi

	dodir /usr/bin/
	cat <<-EOF >"${ED}"usr/bin/${PN}
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="/opt/firefox/"
	GTK_PATH=/usr/lib/gtk-2.0/
	exec /opt/${MOZ_PN}/${MOZ_PN} "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${MOZILLA_FIVE_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die

	share_plugins_dir

	pax-mark mr "${ED}"${MOZILLA_FIVE_HOME}/{icecat,icecat-bin,plugin-container}
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	einfo "For HTML5 video you need media-video/ffmpeg installed.  Please note"
	einfo "that gstreamer:0.10 will also be used, if available."

	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
