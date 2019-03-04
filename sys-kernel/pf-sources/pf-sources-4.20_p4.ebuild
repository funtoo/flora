# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"
ETYPE="sources"
KEYWORDS="-* ~amd64 ~x86"

HOMEPAGE="
	https://gitlab.com/post-factum/pf-kernel/wikis/README
	https://dev.gentoo.org/~mpagano/genpatches/
	https://git.archlinux.org/svntogit/packages.git/tree/trunk?h=packages/linux
"

IUSE=""

# No 'experimental' USE flag provided, but we still want to use genpatches
K_EXP_GENPATCHES_NOUSE="1"

# No reason to bump this number unless something new gets included in genpatches, 
# in that case we can manually remove the linux kernel patches from genpatches.
K_GENPATCHES_VER="1"

K_NOSETEXTRAVERSION="don't_set_it"

# Not supported by the Gentoo crew
K_SECURITY_UNSUPPORTED="1"

K_USEPV="yes"

# We want the very basic patches from gentoo-sources, experimental patch
# is already included in pf-sources
K_WANT_GENPATCHES="base extras"

UNIPATCH_STRICTORDER="yes"

inherit kernel-2
detect_version

DESCRIPTION="Linux kernel fork that includes pf-kernel patch and Gentoo's genpatches"

PF_URI="https://github.com/pfactum/pf-kernel/compare/v${PV/_p*/}...v${PV/_p*/}-pf${PV/*_p/}.diff -> ${P}.patch"
SRC_URI="
	${KERNEL_URI}
	${PF_URI}
	https://dev.gentoo.org/~mpagano/genpatches/tarballs/genpatches-${PV/_p*/}-${K_GENPATCHES_VER}.base.tar.xz
	https://dev.gentoo.org/~mpagano/genpatches/tarballs/genpatches-${PV/_p*/}-${K_GENPATCHES_VER}.extras.tar.xz
"

KV_FULL="${PVR}-pf"
S="${WORKDIR}/linux-${KV_FULL}"

pkg_setup(){
	ewarn
	ewarn "${PN} is *not* supported by the Gentoo Kernel Project in any way."
	ewarn "If you need support with the kernel, please contact the pf "
	ewarn "developers directly. If you need support with the ebuild, contact the "
	ewarn "package maintainer. Do *not* open bugs in Gentoo's bugzilla."
	ewarn
	kernel-2_pkg_setup
}

src_prepare(){
	eapply "${DISTDIR}/${P}.patch" || die "Applying ${P}.patch failed."

	# allow user to apply any additional patches without modifying ebuild
	eapply_user

	kernel-2_src_prepare
}

src_install() {
	kernel-2_src_install
}

pkg_postinst() {
	kernel-2_pkg_postinst
}

K_EXTRAEINFO="For more info on pf-sources and details on how to report problems,
see: ${HOMEPAGE}."
