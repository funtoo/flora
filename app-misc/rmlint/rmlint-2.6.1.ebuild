# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils scons-utils

DESCRIPTION="rmlint finds space waste and other broken things on your filesystem and offers to remove it"
HOMEPAGE="https://github.com/sahib/rmlint"
SRC_URI="https://github.com/sahib/rmlint/archive/v2.6.1.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE="+gui doc"

RDEPEND="gui? ( dev-libs/json-glib[introspection]
		gnome-base/librsvg[introspection]
		x11-libs/gtksourceview:3.0[introspection]
		x11-libs/gtk+:3[introspection]
		x11-libs/gdk-pixbuf[introspection]
		dev-python/pygobject:3
		dev-python/colorlog )
		
		"
DEPEND="${RDEPEND}
		dev-util/scons
		dev-python/sphinx
		sys-devel/gettext"

src_configure() {
	myesconsargs=(
	--with-gui
	--with-json-glib
	)
}
src_compile(){
	escons CC="$(tc-getCC)"
}

src_install(){
	escons install LIBDIR=/usr/$(get_libdir) --prefix="${ED}"/usr
    rm -f ${ED}/usr/share/glib-2.0/schemas/gschemas.compiled
    if ! use gui; then
    	rm -rf "${D}"/usr/share/{glib-2.0,icons,applications}
    	rm -rf "${D}"/usr/lib
	fi
	if ! use doc; then
		rm -rf "${D}"/usr/share/man
	fi
}

pkg_postinst() {
	use gui && gnome2_schemas_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	use gui && gnome2_schemas_update
	gnome2_icon_cache_update
}

