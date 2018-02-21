# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3

DESCRIPTION="Funtoo bootsplash for fbcondecor in 1366x768 resolution"
HOMEPAGE="https://github.com/jblaiseg/fbcondecor-funtoo-logo"
EGIT_REPO_URI="https://github.com/jblaiseg/fbcondecor-funtoo-logo.git"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="media-gfx/splashutils[fbcondecor]"
RDEPEND="${DEPEND}"

RESTRICT="binchecks strip"

src_install() {
	insinto ${EPREFIX}/etc/splash/${PN}
	doins -r *
}
