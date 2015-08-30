#
# Arch Linux + Yaourt
#
# https://github.com/joshuacox/docker-archlinux-yaourt
# a from https://github.com/bmcustodio/docker-archlinux-yaourt
#

FROM    nfnty/arch-mini:latest
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV ARCHLINUX_YAOURT_UPDATED 20150830

RUN pacman --noconfirm -Syyu
RUN pacman --noconfirm -S base-devel
RUN pacman --noconfirm -S yajl

RUN groupadd -r yaourt
RUN useradd -r -g yaourt yaourt
RUN mkdir /tmp/yaourt
RUN chown -R yaourt:yaourt /tmp/yaourt

USER yaourt

WORKDIR /tmp/yaourt
RUN curl https://aur.archlinux.org/packages/pa/package-query/package-query.tar.gz | tar zx
WORKDIR /tmp/yaourt/package-query
RUN makepkg --noconfirm

USER root

WORKDIR /tmp/yaourt/package-query
RUN pacman --noconfirm -U *.tar.xz

USER yaourt

WORKDIR /tmp/yaourt
RUN curl https://aur.archlinux.org/packages/ya/yaourt/yaourt.tar.gz | tar zx
WORKDIR /tmp/yaourt/yaourt
RUN makepkg --noconfirm

USER root

WORKDIR /tmp/yaourt/yaourt
RUN pacman --noconfirm -U *.tar.xz
