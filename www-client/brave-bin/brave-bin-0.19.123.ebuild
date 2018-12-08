# Distributed under the terms of the GNU General Public License v2

EAPI=6

BRAVE_PN="${PN/-bin}"

inherit desktop linux-info

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
LICENSE="MPL-2.0"
SLOT=0
KEYWORDS="~*"
SRC_URI="https://github.com/brave/browser-laptop/releases/download/v${PV}dev/Brave.tar.bz2 -> ${P}.tar.bz2"
RESTRICT="strip mirror"

IUSE=""

RDEPEND="
	gnome-base/libgnome-keyring
	x11-libs/libXScrnSaver
"
DEPEND="${RDEPEND}
	gnome-base/gconf
"

S="${WORKDIR}/Brave-linux-x64"

pkg_setup() {
	ERROR_PID_NS="PID_NS is required for sandbox to work"
	ERROR_NET_NS="NET_NS is required for sandbox to work"
	ERROR_USER_NS="USER_NS is required for sandbox to work"
	ERROR_SECCOMP_FILTER="SECCOMP_FILTER is required for sandbox to work"
	CONFIG_CHECK="~PID_NS ~NET_NS ~SECCOMP_FILTER ~USER_NS"
	check_extra_config
}

src_install() {
	declare BRAVE_HOME=/opt/${BRAVE_PN}

	newicon "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png"
	newicon -s 128 "${S}/resources/extensions/brave/img/braveAbout.png" "${PN}.png" || die
	domenu "${FILESDIR}"/${PN}.desktop

	dodir ${BRAVE_HOME%/*}
	mv "${S}" "${ED}"${BRAVE_HOME} || die

	# Create /usr/bin/brave-bin
	dodir /usr/bin/
	cat <<-EOF >"${ED}usr/bin/${PN}"
	#!/bin/sh
	unset LD_PRELOAD
	LD_LIBRARY_PATH="${BRAVE_HOME}/"
	exec ${BRAVE_HOME}/${BRAVE_PN} "\$@"
	EOF
	chmod 0755 "${ED}usr/bin/${PN}"

	# revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo "SEARCH_DIRS_MASK=${BRAVE_HOME}" >> ${T}/10${PN}
	doins "${T}"/10${PN} || die
}

pkg_postinst() {
	elog "NOTE: If Brave does not start and shows an error about sandboxing,"
	elog "you may need to enable userns in your kernel."
	elog "To do so, you can append the following line into /etc/sysctl.conf:"
	elog " kernel.unprivileged_userns_clone = 1"
	elog "and run sysctl -p"
	elog "Running brave with the --no-sandbox flag is NOT recommended!"
}
