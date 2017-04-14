# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1 git-r3

SRC_URI=""
EGIT_REPO_URI="git://github.com/qtile/qtile.git"
EGIT_BRANCH="develop"
KEYWORDS=""

DESCRIPTION="A pure-Python tiling window manager."
HOMEPAGE="http://www.qtile.org/"

LICENSE="MIT"
SLOT="0"
IUSE="dbus widget-khal-calendar widget-imap widget-launchbar widget-mpd widget-mpris widget-wlan widget-keyboardkbdd"

REQUIRED_USE="widget-mpris? ( dbus )
	widget-keyboardkbdd? ( dbus )
"

RDEPEND="x11-libs/cairo[xcb] x11-libs/pango dev-python/setproctitle[${PYTHON_USEDEP}]
	$(python_gen_cond_dep 'dev-python/trollius[${PYTHON_USEDEP}]' 'python2*')
	>=dev-python/six-1.4.1[${PYTHON_USEDEP}]
	>=dev-python/xcffib-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/cairocffi-0.7[${PYTHON_USEDEP}]
	>=dev-python/cffi-1.3[${PYTHON_USEDEP}]
	dbus? (
		dev-python/dbus-python[${PYTHON_USEDEP}]
		>=dev-python/pygobject-3.4.2-r1000[${PYTHON_USEDEP}]
	)
	widget-khal-calendar? (
		dev-python/httplib2[${PYTHON_USEDEP}]
		dev-python/python-dateutil[${PYTHON_USEDEP}]
	)
	widget-imap? ( dev-python/keyring[${PYTHON_USEDEP}] )
	widget-launchbar? ( dev-python/pyxdg[${PYTHON_USEDEP}] )
	widget-mpd? ( dev-python/python-mpd[${PYTHON_USEDEP}] )
	widget-wlan? (
		|| (
			net-wireless/python-wifi[${PYTHON_USEDEP}]
			dev-python/iwlib[${PYTHON_USEDEP}]
		)
	)
"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
"
DOCS=( CHANGELOG README.rst )

src_prepare() {
	if ! use dbus ; then
		(
			sed -i '/self.setup_python_dbus()/d' libqtile/manager.py
		)
	fi
	if ! use widget-khal-calendar ; then
		(
			sed -i '/safe_import(".khal_calendar", "KhalCalendar")/d' libqtile/widget/__init__.py
			rm libqtile/widget/khal_calendar.py
		)
	fi
	if ! use widget-imap ; then
		(
			sed -i '/safe_import(".imapwidget", "ImapWidget")/d' libqtile/widget/__init__.py
			rm libqtile/widget/imapwidget.py
		)
	fi
	if ! use widget-launchbar ; then
		(
			sed -i '/safe_import(".launchbar", "LaunchBar")/d' libqtile/widget/__init__.py
			rm libqtile/widget/launchbar.py
		)
	fi
	if ! use widget-mpd ; then
		(
			sed -i '/safe_import(".mpdwidget", "Mpd")/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpdwidget.py
		)
	fi
	if ! use widget-wlan ; then
		(
			sed -i '/safe_import(".wlan", "Wlan")/d' libqtile/widget/__init__.py
			rm libqtile/widget/wlan.py
		)
	fi
	if ! use widget-mpris ; then
		(
			sed -i '/safe_import(".mpriswidget", "Mpris")/d' libqtile/widget/__init__.py
			sed -i '/safe_import(".mpris2widget", "Mpris2")/d' libqtile/widget/__init__.py
			rm libqtile/widget/mpriswidget.py
			rm libqtile/widget/mpris2widget.py
		)
	fi
	if ! use widget-keyboardkbdd ; then
		(
			sed -i '/safe_import(".keyboardkbdd", "KeyboardKbdd")/d' libqtile/widget/__init__.py
			rm libqtile/widget/keyboardkbdd.py
		)
	fi
	default
}

python_install_all() {
	distutils-r1_python_install_all

	insinto /usr/share/xsessions
	doins resources/qtile.desktop

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}"/${PN}-session ${PN}
}
