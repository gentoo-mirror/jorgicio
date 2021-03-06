# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop qmake-utils xdg-utils

DESCRIPTION="Cross-platform open source music player built with Qt5, QTav and Taglib."
HOMEPAGE="https://github.com/MBach/Miam-Player"

MY_PN="Miam-Player"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/MBach/${MY_PN}"
else
	MY_P="${MY_PN}-${PV}"
	SRC_URI="https://github.com/MBach/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
	S="${WORKDIR}/${MY_P}"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="pulseaudio"

DEPEND="
	dev-qt/qtmultimedia:5[alsa,pulseaudio?,gstreamer]
	dev-qt/qtx11extras:5
"
RDEPEND="${DEPEND}
	media-libs/taglib
	media-libs/qtav:0/1[pulseaudio?]
"

src_configure(){
	local lib_suf="$(get_libdir)"
	eqmake5 LIB_SUFFIX="${lib_suf//lib}"
}

src_install(){
	emake INSTALL_ROOT="${D}" install
	newicon -s 64 debian/usr/share/icons/hicolor/64x64/apps/application-x-${PN//-}.png ${PN}.png
}


pkg_postinst(){
	xdg_desktop_database_update
}

pkg_postrm(){
	xdg_desktop_database_update
}
