# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7,8} )

inherit cmake-utils gnome2-utils python-single-r1

SRC_URI="https://launchpad.net/${PN}/$(ver_cut 1-3)/${PV}/+download/${P}.tar.xz"
KEYWORDS="*"
DESCRIPTION="OpenGL window and compositing manager"
HOMEPAGE="http://www.compiz.org/"

LICENSE="GPL-2 LGPL-2.1 MIT"
SLOT="0"

IUSE="gnome test"

COMMONDEPEND="
		dev-libs/boost
		dev-libs/glib:2
		dev-cpp/glibmm
		dev-libs/libxml2
		dev-libs/libxslt
		dev-python/cython
		dev-libs/protobuf
		media-libs/libpng
		x11-base/xorg-server
		x11-libs/libX11
		x11-libs/libXcomposite
		x11-libs/libXdamage
		x11-libs/libXext
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXinerama
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/startup-notification
		virtual/opengl
		virtual/glu
		x11-libs/cairo[X]
		x11-libs/gtk+:3
		x11-libs/libwnck:3
		x11-libs/pango
		gnome? (
				gnome-base/gnome-desktop
				gnome-base/gconf
				)
		gnome-base/librsvg:2
		sys-apps/dbus"

DEPEND="${COMMONDEPEND}
		app-admin/chrpath
		dev-util/gcovr
		dev-util/lcov
		virtual/pkgconfig
		x11-proto/damageproto
		x11-proto/xineramaproto
		test? (
				dev-cpp/gtest
				dev-cpp/gmock
		)"

RDEPEND="${COMMONDEPEND}
		dev-python/pygtk
		x11-apps/mesa-progs
		x11-apps/xvinfo
		x11-themes/hicolor-icon-theme
		x11-wm/metacity"

src_prepare() {
	# Funtoo 'cython3' binary is called 'cython' #
	sed -e 's:cython3:cython:g' \
		-i compizconfig/compizconfig-python/CMakeLists.txt || die
	cmake-utils_src_prepare
}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	BUILD_DIR="${WORKDIR}/build"
	mycmakeargs+=(
		-DBUILD_GNOME="$(usex gnome)"
		-DCOMPIZ_BUILD_WITH_RPATH=FALSE
		-DCOMPIZ_BUILD_TESTING="$(usex test)"
		-DCOMPIZ_DISABLE_GS_SCHEMAS_INSTALL=FALSE
#		-DCOMPIZ_WERROR=FALSE \
		-DCOMPIZ_PACKAGING_ENABLED=TRUE \
		-Wno-dev \
)
	cmake-utils_src_configure
}

src_install() {
	pushd "${CMAKE_BUILD_DIR}"
	addpredict /usr/share/glib-2.0/schemas/
#	emake DESTDIR="${ED}" install
#	# Fix paths to avoid sandbox access violation
#	# 'emake DESTDIR=${D} install' does not work with compiz cmake files!
#	emake DESTDIR=${D} install
#	for i in `find . -type f -name "cmake_install.cmake"` ; do
#		sed -e "s|/usr|${D}/usr|g" -i "${i}"  || die "sed failed"
#	done
	cmake-utils_src_install
	popd
}

pkg_preinst() {
	if use gnome; then
		gnome2_gconf_savelist
		gnome2_schemas_savelist
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	if use gnome; then
		gnome2_gconf_install
		gnome2_schemas_update
		gnome2_icon_cache_update
	fi
}

pkg_prerm() {
	use gnome && gnome2_schemas_update
}
