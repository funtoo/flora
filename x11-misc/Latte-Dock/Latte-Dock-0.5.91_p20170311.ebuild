# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils
DESCRIPTION="Latte is a dock based on plasma frameworks that provides an elegant and intuitive experience for your tasks and plasmoids"
COMMIT_ID="3d95225349d8150d60e316e9407bd2a06b8bee30"
HOMEPAGE="https://github.com/psifidotos/Latte-Dock"
SRC_URI="https://github.com/psifidotos/Latte-Dock/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT_ID}/"
BUILD_DIR="${S}build"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
PATCHES=( "${FILESDIR}"/${PN}-release-mkdir.patch )
DEPEND="kde-frameworks/extra-cmake-modules
	dev-qt/qtcore:5
	dev-qt/qtx11extras
	sys-devel/gettext"
RDEPEND="${DEPEND}
	kde-frameworks/plasma
	kde-frameworks/kwindowsystem
	kde-frameworks/kdeclarative
	kde-frameworks/kactivities
	kde-frameworks/ki18n
	kde-frameworks/kcoreaddons
	kde-frameworks/kxmlgui
	kde-frameworks/kdbusaddons
	kde-frameworks/kiconthemes
	kde-frameworks/kwayland
	x11-libs/libxcb
	x11-libs/libXrandr"

src_prepare() {
	default
}

src_configure() {
	mycmakeargs=(
	-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
}

