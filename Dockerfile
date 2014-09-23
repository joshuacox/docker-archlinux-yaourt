#
# Arch Linux + Yaourt
#
# https://github.com/bmcustodio/docker-archlinux-yaourt
#

FROM bmcustodio/archlinux
MAINTAINER Bruno M. Custódio <bruno@brunomcustodio.com>

RUN pacman --noconfirm -Syyu
RUN pacman --noconfirm -S base-devel
RUN pacman --noconfirm -S yajl

WORKDIR /tmp/aur
RUN curl https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz | tar zx
WORKDIR /tmp/aur/package-query
RUN makepkg --asroot --noconfirm -i

WORKDIR /tmp/aur
RUN curl https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz | tar zx
WORKDIR /tmp/aur/yaourt
RUN makepkg --asroot --noconfirm -i
