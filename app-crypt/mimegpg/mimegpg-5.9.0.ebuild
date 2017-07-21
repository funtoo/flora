# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils flag-o-matic multilib

MY_P=sqwebmail-${PV}

DESCRIPTION="Courier's (SqWebMail) tool to sign, encrypt, or decrypt MIME-formatted E-mail using GnuPG"
SRC_URI="mirror://sourceforge/courier/webmail/${MY_P}.tar.bz2"
HOMEPAGE="http://www.courier-mta.org/sqwebmail/
          http://www.courier-mta.org/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="idn"

DEPEND="
    >=net-libs/courier-unicode-2.0
    idn? ( net-dns/libidn )
    !mail-mta/courier
    "

RDEPEND="${DEPEND}
    >=app-crypt/gnupg-1.0.4
    "

S=${WORKDIR}/${MY_P}

MG_LIBS="numlib rfc822 rfc2045 gpglib"

src_configure() {
    for libdir in ${MG_LIBS}; do
        cd ${S}/libs/${libdir}
        econf
    done
}

src_compile() {
    for libdir in ${MG_LIBS}; do
        cd ${S}/libs/${libdir}
        emake
    done
}

src_install() {
    dobin libs/gpglib/mimegpg
    
    doman libs/gpglib/mimegpg.1
    dodoc libs/gpglib/README.html
    
}

