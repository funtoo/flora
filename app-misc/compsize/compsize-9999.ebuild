# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGIT_REPO_URI="https://github.com/kilobyte/compsize.git"
inherit git-r3

DESCRIPTION="List compression type and ratio on a file or set of files on a btrfs filesystem"
HOMEPAGE="https://github.com/kilobyte/compsize"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# we need btrfs-progs with includes installed.
DEPEND="sys-fs/btrfs-progs"
RDEPEND="${DEPEND}"

src_install() {
	emake PREFIX="${ED}" install
}
