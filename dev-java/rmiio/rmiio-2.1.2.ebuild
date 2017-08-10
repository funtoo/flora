# Distributed under the terms of the GNU General Public License v2

EAPI=6
JAVA_PKG_IUSE="source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Utilities for streaming data over RMI"
HOMEPAGE="http://openhms.sourceforge.net/rmiio/"
SRC_URI="https://sourceforge.net/projects/openhms/files/rmiio/rmiio%202.1.2/rmiio-2.1.2-sources.jar/download -> rmiio-2.1.2-sources.jar"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"

CDEPEND=">=dev-java/commons-logging-1.2:0"

DEPEND=">=virtual/jdk-1.7
	${CDEPEND}"

RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"



JAVA_SRC_DIR=""

JAVA_GENTOO_CLASSPATH="commons-logging"

S="${WORKDIR}"
