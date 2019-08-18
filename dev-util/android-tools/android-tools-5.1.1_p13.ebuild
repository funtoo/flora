# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit bash-completion-r1 eutils toolchain-funcs

MY_PV="${PV/_p/_r}"
MY_P=${PN}-${MY_PV}

DESCRIPTION="Android platform tools (adb, fastboot, and mkbootimg)"
HOMEPAGE="https://android.googlesource.com/platform/system/core.git/"
# For stable digests, git tarballs generated by android.googlesource.com
# are fetched from mirror://gentoo/.
SRC_URI="https://projects.archlinux.org/svntogit/community.git/snapshot/community-caa300cf262afcf5bdb4dcc923dee54e3715fd5c.tar.gz -> ${MY_P}-arch.tar.gz
https://github.com/android/platform_system_core/archive/android-${MY_PV}.tar.gz -> ${MY_P}-core.tar.gz
mirror://gentoo/${MY_P}-extras.tar.gz
mirror://gentoo/${MY_P}-libselinux.tar.gz
mirror://gentoo/${MY_P}-f2fs-tools.tar.gz"

# The entire source code is Apache-2.0, except for fastboot which is BSD-2.
LICENSE="Apache-2.0 BSD-2"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-linux"
IUSE="libressl"

RDEPEND="sys-libs/zlib:=
	!libressl? ( dev-libs/openssl:0= )
	libressl? ( dev-libs/libressl:0= )
	dev-libs/libpcre"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_unpack() {
	local dir filename
	for filename in ${A}; do
		if [[ ${filename} =~ ^${MY_P}-(.*)\.tar\.gz$ ]]; then
			dir=${BASH_REMATCH[1]}
			mkdir -p "${dir}" || die
			pushd "${dir}" >/dev/null
			unpack "${filename}"
			popd > /dev/null
		else
			die "unrecognized file in \${A}: ${filename}"
		fi
	done
}

src_prepare() {
	mv core/*/* core/ || die
	sed -e 's|#include <dlfcn.h>|\0\n#include <stddef.h>\n#include <string.h>\n|' \
		-i extras/f2fs_utils/f2fs_utils.c  || die
	mv arch/*/trunk/Makefile ./ || die
	sed -i '1i#include <sys/sysmacros.h>' core/adb/usb_linux.c || die #580058
	sed -e 's|^#include <sys/cdefs.h>$|/*\0*/|' \
		-e 's|^__BEGIN_DECLS$|#ifdef __cplusplus\nextern "C" {\n#endif|' \
		-e 's|^__END_DECLS$|#ifdef __cplusplus\n}\n#endif|' \
		-i extras/ext4_utils/sha1.{c,h} || die #580686
	tc-export CC
}

src_install() {
	emake DESTDIR="${ED}" install
	newbashcomp arch/*/trunk/bash_completion fastboot
}