# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=7

inherit desktop eutils pax-utils xdg

DESCRIPTION="Free/Libre Open Source Software Binaries of VSCode (binary version)"
HOMEPAGE="https://vscodium.com/"
SRC_URI="
	amd64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-x64-${PV}.tar.gz -> ${P}-x64.tar.gz )
        arm64? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-arm64-${PV}.tar.gz -> ${P}-arm64.tar.gz )
        arm? ( https://github.com/VSCodium/vscodium/releases/download/${PV}/VSCodium-linux-arm-${PV}.tar.gz -> ${P}-arm.tar.gz )
	"
RESTRICT="mirror strip bindist"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64"
IUSE=""
DEPEND="
	sys-libs/glibc
	sys-devel/gcc
	>=x11-libs/gtk+-2.24.8-r1:2
	x11-libs/cairo
	x11-libs/pango
	dev-libs/atk
	x11-libs/gdk-pixbuf
	dev-libs/glib
	media-libs/freetype
	media-libs/fontconfig
	sys-apps/dbus
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXi
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libXScrnSaver
	gnome-base/gconf
	dev-libs/nss
	dev-libs/nspr
	media-libs/alsa-lib
	net-print/cups
	dev-libs/expat
	x11-libs/libXinerama
	x11-libs/pixman
	media-libs/mesa
	media-libs/libpng
	sys-libs/zlib
	dev-libs/libffi
	app-arch/bzip2
	x11-libs/libXau
	x11-libs/libXdmcp
	dev-libs/dbus-glib
	dev-libs/libpcre
	net-libs/gnutls
	media-libs/harfbuzz
	x11-libs/libxshmfence
	x11-libs/libdrm
	x11-libs/libXxf86vm
	dev-libs/libbsd
	dev-libs/libunistring
	dev-libs/libtasn1
	dev-libs/nettle
	dev-libs/gmp
	net-dns/libidn2
	media-gfx/graphite2
"

RDEPEND="
        ${DEPEND}
        app-accessibility/at-spi2-atk
	>=net-print/cups-2.0.0
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	dev-libs/nss
	app-crypt/libsecret[crypt]"

QA_PRESTRIPPED="opt/${PN}/code"

S="${WORKDIR}"

src_install(){
	pax-mark m code
	insinto "/opt/${PN}"
	doins -r *
	dosym "../../opt/${PN}/bin/codium" "/usr/bin/${PN}"
	dosym "../../opt/${PN}/bin/codium" "/usr/bin/codium"
	make_desktop_entry "${PN}" "Visual Studio Code" "${PN}" "Development;IDE"
	doicon "${FILESDIR}/${PN}.png"
	fperms +x "/opt/${PN}/codium"
	fperms +x "/opt/${PN}/bin/codium"
	fperms +x "/opt/${PN}/resources/app/node_modules.asar.unpacked/vscode-ripgrep/bin/rg"
	fperms +x "/opt/${PN}/resources/app/extensions/git/dist/askpass.sh"
	insinto "/usr/share/licenses/${PN}"
	for i in resources/app/LICEN*; do
		newins "${i}" "$(basename ${i})"
	done
}

pkg_postinst(){
	elog "You may install some additional utils, so check them in:"
	elog "https://code.visualstudio.com/Docs/setup#_additional-tools"
	elog ""
	elog "Upstream renamed the binary from vscodium to codium."
	elog "remember to update your aliases and shortcuts"
}
