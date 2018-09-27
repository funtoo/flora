# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 linux-info xdg-utils udev

DESCRIPTION="User-mode driver and GTK3 based GUI for Steam Controller"
HOMEPAGE="https://github.com/kozec/sc-controller/"
SRC_URI="https://github.com/kozec/sc-controller/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
	dev-python/pygobject:3[cairo,${PYTHON_USEDEP}]
	dev-python/pylibacl[${PYTHON_USEDEP}]
	dev-python/python-evdev[${PYTHON_USEDEP}]
	gnome-base/librsvg:2[introspection]
	>=x11-libs/gtk+-3.10:3[introspection]"
DEPEND="${RDEPEND} test? ( dev-python/pytest[${PYTHON_USEDEP}] )"

python_test() {
	py.test || die
}
pkg_setup() {
	linux-info_pkg_setup
	CONFIG_CHECK="~INPUT_UINPUT"
	check_extra_config
}

src_install() {
	# install udev rules with corrected permissions.
	udev_dorules "${FILESDIR}"/99-steam-controller-perms.rules
	distutils-r1_src_install

	# remove upstream udev rule with incorrect permissions
	rm -r "${ED}"usr/lib/udev/rules.d || die
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update

	# reload udev rules
	udevadm control --reload-rules
	udevadm trigger

	# Information messages
	elog "Your user must be in input group for runtime sc-controller functionality"
	elog "Run as root:"
	elog "gpasswd -a username input"
	elog "You will need to load 'uinput' module for sc-controller to work properly"
	elog "To load module run as root: modprobe uinput"
	elog "To load module at boot time automatically, please, edit your /etc/conf.d/modules"
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
