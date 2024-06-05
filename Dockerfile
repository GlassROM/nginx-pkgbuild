FROM archlinux:latest

LABEL maintainer="Thien Tran contact@tommytran.io"

COPY pacman.conf /etc/pacman.conf

RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && groupadd --system --gid 101 nginx \
    && useradd --system -g nginx -M --shell /bin/nologin --uid 101 nginx \
    && pacman -Syyuu --noconfirm \
    && pacman -S --noconfirm base-devel git

RUN useradd -m user \
    && echo 'user ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
COPY --chown=user:user . /home/user/nginx

USER user

WORKDIR /home/user

RUN git clone https://aur.archlinux.org/hardened-malloc-git.git

WORKDIR /home/user/hardened-malloc-git

RUN makepkg -si --noconfirm

WORKDIR /home/user/nginx

RUN makepkg -si --noconfirm

USER root
WORKDIR /
RUN pacman -Rcns base-devel git --noconfirm \
    && pacman -Qdtq | pacman -Rs - --noconfirm \
    && userdel user \
    && rm -rf /home/user \
    && pacman -Rscndd sudo \
    && rm -rf /etc/sudoers.pacsave

RUN yes | pacman -Scc

EXPOSE 80/tcp 443/tcp 443/udp

STOPSIGNAL SIGQUIT

RUN chown -R 101:101 /var/log/nginx
RUN chown -R 101:101 /var/lib/nginx
RUN mkdir -p /var/cache/nginx
RUN chown -R 101:101 /var/cache/nginx
RUN chown -R 101:101 /etc/nginx

USER 101

CMD ["nginx", "-g", "daemon off;"]
