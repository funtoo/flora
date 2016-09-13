# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit qmake-utils git-r3

EGIT_REPO_URI="https://github.com/Swordfish90/cool-retro-term.git"
#EGIT_COMMIT=""

DESCRIPTION="A Cool Retro Terminal"
HOMEPAGE="https://github.com/Swordfish90/cool-retro-term"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND=">=dev-qt/qtcore-5.2:5
		>=dev-qt/qtdeclarative-5.2:5
		>=dev-qt/qtquickcontrols-5.2:5
		>=dev-qt/qtgraphicaleffects-5.2:5"