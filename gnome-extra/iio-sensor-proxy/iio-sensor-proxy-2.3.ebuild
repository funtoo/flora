# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools udev
DESCRIPTION="IIO sensors to D-Bus proxy"
HOMEPAGE="https://github.com/hadess/iio-sensor-proxy"
SRC_URI="https://github.com/hadess/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/glib
	gnome-base/gnome-common
	sys-apps/dbus
	virtual/libgudev
	virtual/udev"

DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	virtual/pkgconfig"

src_prepare() {
	eapply "${FILESDIR}"/${P}-nosystemdcheck.patch
	eautoreconf
	default
}

src_configure() {
	econf \
	--with-udevrulesdir="$(get_udevdir)"/rules.d
}

pkg_postinst() {
	udevadm control --reload-rules
}
 
