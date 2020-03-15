# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# Based on https://github.com/gentoo-mirror/ixit/tree/master/dev-python/pykeepass and https://youtu.be/xUzjfyAZcq8

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1 eutils toolchain-funcs

DESCRIPTION="Python library to interact with keepass databases (supports KDBX3 and KDBX4) "
HOMEPAGE="https://github.com/libkeepass/pykeepass"
#SRC_URI="https://github.com/libkeepass/pykeepass/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
	>=dev-python/lxml-4.3.3
	>=dev-python/pycryptodome-3.7.3
	>=dev-python/construct-2.9.45
	>=dev-python/argon2_cffi-19.1.0
	>=dev-python/python-dateutil-2.7.5
	>=dev-python/future-0.17.0"
DEPEND="${RDEPEND}"
BDEPEND="
	virtual/pkgconfig
	dev-python/setuptools[${PYTHON_USEDEP}]
	"

GITHUB_REPO="pykeepass"
GITHUB_USER="libkeepass"
GITHUB_TAG="093e38a5bb6494a91172fb1a8eabfc12404b7422"
SRC_URI="https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/${GITHUB_TAG} -> ${PN}-${GITHUB_TAG}.tar.gz"

src_unpack() {
>--- unpack "${A}"
>--- mv "${WORKDIR}/${GITHUB_USER}-${GITHUB_REPO}"-??????? "${S}" || die
}

PATCHES=( "${FILESDIR}/0001-setup.py-exclude-tests-directory.patch" )
