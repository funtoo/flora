# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils toolchain-funcs

DESCRIPTION="Actively maintained fork of heirloom-mailx, a CLI email client"
HOMEPAGE="https://www.sdaoden.eu/code.html"
SRC_URI="https://www.sdaoden.eu/downloads/${P}.tar.xz"

LICENSE="MIT BSD BSD-2 BSD-4 RSA"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+net +ssl +idn kerberos test"

DEPEND="idn? ( net-dns/libidn )
        net? ( kerberos? ( virtual/krb5 )
               ssl? ( dev-libs/openssl:0 )
             )
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

    local WANT_SSL=$(use ssl && echo 1 || echo 0)
    local WANT_IDNA=$(use idn && echo 1 || echo 0)

    use net || PKGCONFIG="$PKGCONFIG CONFIG=MEDIUM"
    
    PKGCONFIG="$PKGCONFIG WANT_GSSAPI=$(use kerberos && echo 1 || echo 0) \
                          WANT_SSL=$(use ssl && echo 1 || echo 0) \
                          WANT_IDNA=$(use idn && echo 1 || echo 0)"

    emake \
        PREFIX="${EPREFIX}"/usr \
        SYSCONFDIR="${EPREFIX}"/etc \
        LIBEXECDIR="${EPREFIX}"/usr/lib \
        MAILSPOOL="${EPREFIX}"/var/spool/mail \
        SID= \
        NAIL="s-nail" \
        $PKGCONFIG \
        WANT_AUTOCC=0 \
        config || die "emake failed"
}

src_compile() {
    emake build || die "emake failed"
    if use test; then
        emake test || die "emake failed"
    fi
}

src_install() {
    emake DESTDIR="${D}" \
        PREFIX="${EPREFIX}/usr" \
        SYSCONFDIR="${EPREFIX}"/etc \
        LIBEXECDIR="${EPREFIX}"/usr/lib \
    install
    
    dodoc README
    dodir /bin
    dosym /usr/bin/${PN} /bin/mail
    dosym /usr/bin/${PN} /usr/bin/Mail
    dosym /usr/share/man/man1/${PN}.1.bz2 /usr/share/man/man1/mail.1
}
