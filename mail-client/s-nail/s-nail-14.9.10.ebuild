# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Actively maintained fork of heirloom-mailx, a CLI email client"
HOMEPAGE="https://www.sdaoden.eu/code.html"
SRC_URI="https://www.sdaoden.eu/downloads/${P}.tar.xz"

LICENSE="MIT BSD BSD-2 BSD-4 RSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+net +ssl +idn kerberos"

DEPEND="idn? ( net-dns/libidn )
        net? ( kerberos? ( virtual/krb5 )
               ssl? ( || ( dev-libs/openssl:0 dev-libs/libressl ) )
             )
        sys-libs/ncurses
        !mail-client/mailx
        !net-mail/mailutils
        !net-mail/nail"
RDEPEND="${DEPEND}"

PATCHES=""

REQUIRED_USE="!net? ( !kerberos
                      !ssl
                    )"

src_configure() {
    tc-export CC

    use net || PKGCONFIG="$PKGCONFIG CONFIG=MEDIUM"
    
    PKGCONFIG="$PKGCONFIG OPT_GSSAPI=$(use kerberos && echo 1 || echo 0) \
                          OPT_SSL=$(use ssl && echo 1 || echo 0) \
                          OPT_IDNA=$(use idn && echo 1 || echo 0)"

    emake \
        VAL_PREFIX="${EPREFIX}"/usr \
        VAL_SYSCONFDIR="${EPREFIX}"/etc \
        VAL_MAILSPOOL="${EPREFIX}"/var/spool/mail \
        $PKGCONFIG \
        OPT_AUTOCC=0 \
        config || die "emake failed"
}

src_compile() {
    emake build || die "emake failed"
}

src_install() {
    emake DESTDIR="${D}" install || die "emake failed"
    
    dodoc README NEWS
    dodir /bin
    dosym /usr/bin/${PN} /bin/mail
    dosym /usr/bin/${PN} /usr/bin/Mail
    dosym /usr/share/man/man1/${PN}.1.bz2 /usr/share/man/man1/mail.1
}
