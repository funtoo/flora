# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/junegunn/fzf"

EGO_VENDOR=(
	"github.com/gdamore/encoding b23993cbb6353f0e6aa98d0ee318a34728f628b9"
	"github.com/gdamore/tcell 44772c121bb7838819d3ba4a7e84c0c2d617328e"
	"github.com/lucasb-eyer/go-colorful c900de9dbbc73129068f5af6a823068fc5f2308c"
	"github.com/mattn/go-isatty 66b8e73f3f5cda9f96b69efd03dd3d7fc4a5cdb8"
	"github.com/mattn/go-runewidth 14207d285c6c197daabb5c9793d63e7af9ab2d50"
	"github.com/mattn/go-shellwords 02e3cf038dcea8290e44424da473dd12be796a8a"
	"golang.org/x/crypto e1a4589e7d3ea14a3352255d04b6f1a418845e5e github.com/golang/crypto"
	"golang.org/x/sys b90f89a1e7a9c1f6b918820b3daa7f08488c8594 github.com/golang/sys"
	"golang.org/x/text 4ee4af566555f5fbe026368b75596286a312663a github.com/golang/text"
)

inherit golang-build golang-vcs-snapshot bash-completion-r1
ARCHIVE_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
DESCRIPTION="A general-purpose command-line fuzzy finder"
HOMEPAGE="https://github.com/junegunn/fzf"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="tmux vim bash-completion zsh-completion"
RDEPEND="tmux? ( app-misc/tmux )"

src_compile() {
	pushd src/${EGO_PN} || die
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build ${EGO_BUILD_FLAGS} || die
	popd || die
}

src_install() {
	pushd src/${EGO_PN} || die
	dobin ${PN}
	doman man/man1/${PN}.1

	# Install TMUX utils
	if use tmux; then
		dobin bin/${PN}-tmux
		doman man/man1/${PN}-tmux.1
	fi

	# Install bash completion files
	if use bash-completion; then
		newbashcomp shell/completion.bash ${PN}
		insinto /etc/profile.d/
		newins shell/key-bindings.bash ${PN}.sh
	fi

	# Install zsh completion files
	if use zsh-completion; then
		insinto /usr/share/zsh/site-functions
		newins shell/completion.zsh _${PN}
		insinto /usr/share/zsh/site-contrib/
		newins shell/key-bindings.zsh ${PN}.zsh
	fi

	# Install VIM plugin
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins plugin/${PN}.vim
	fi

	popd || die
}
