FROM archlinux:latest

LABEL maintainer="Thien Tran contact@tommytran.io"

RUN set -x \
# create nginx user/group first, to be consistent throughout docker variants
    && groupadd --system --gid 101 nginx \
    && useradd --system -g nginx -M --shell /bin/nologin --uid 101 nginx \
    && pacman -Syyuu --noconfirm \
    && pacman -S --noconfirm base-devel git

RUN useradd user \
    && echo 'user ALL=(ALL) NOPASSWD:ALL' | tee -a /etc/sudoers
COPY --chown=user:user . /home/user/nginx

RUN chown -R user:user /home/user

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
    && pacman -Sc --noconfirm \
    && userdel user \
    && rm -rf /home/user \
    && sed -i 's/user ALL=(ALL) NOPASSWD:ALL//' /etc/sudoers

EXPOSE 80/tcp 443/tcp 443/udp

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
