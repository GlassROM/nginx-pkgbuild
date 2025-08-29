FROM ghcr.io/glassrom/os-image-updater:master AS builder

RUN pacman-key --init && pacman-key --populate archlinux

RUN set -x \
    && pacman -Syyuu --noconfirm base-devel git clang cmake lld llvm mercurial polly go

#LABEL maintainer=""

RUN useradd -m user \
    && echo 'user ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
COPY --chown=user:user . /home/user/nginx

USER user

WORKDIR /home/user/nginx

RUN sed -i 's/..hardened-malloc-git.//' PKGBUILD
ENV CROSS_COMPILE_FOR_AAK=true
RUN makepkg -sf --noconfirm --skippgpcheck
RUN rm *debug* && mv *.tar.zst nginx.tar.zst

FROM ghcr.io/glassrom/os-image-updater:master

RUN pacman-key --init && pacman-key --populate archlinux

# create nginx user/group first, to be consistent throughout docker variants
RUN set -x \
    && groupadd --system --gid 101 nginx \
    && useradd --system -g nginx -M --shell /bin/nologin --uid 101 nginx

COPY --from=builder /home/user/nginx/nginx.tar.zst /
RUN pacman -U /nginx.tar.zst --noconfirm && rm /nginx.tar.zst

RUN rm -rf /etc/pacman.d/gnupg

RUN yes | pacman -Scc

EXPOSE 80/tcp 443/tcp 443/udp

STOPSIGNAL SIGQUIT

RUN chown -R 101:101 /var/log/nginx
RUN chown -R 101:101 /var/lib/nginx
RUN mkdir -p /var/cache/nginx
RUN chown -R 101:101 /var/cache/nginx
RUN chown -R 101:101 /etc/nginx

USER 101

ENV LD_PRELOAD=/usr/lib/boringssl/libssl.so:/usr/lib/boringssl/libcrypto.so
CMD ["/seccomp-strict", "nginx", "-g", "daemon off;"]
