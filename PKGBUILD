# Maintainer:  Giancarlo Razzolini <grazzolini@archlinux.org>
# Contributor: Bartłomiej Piotrowski <bpiotrowski@archlinux.org>
# Contributor: Sébastien Luttringer
# Contributor: Drew DeVault

_pkgbase=nginx
pkgbase=nginx-mainline
pkgname=(nginx-mainline)
pkgver=1.23.3
pkgrel=1
pkgdesc='Lightweight HTTP server and IMAP/POP3 proxy server, mainline release'
arch=('x86_64')
url='https://nginx.org'
license=('custom')
depends=('pcre2' 'zlib' 'openssl' 'geoip' 'mailcap' 'libxcrypt')
makedepends=('cmake' 'git' 'mercurial' 'go')
backup=('etc/nginx/fastcgi.conf'
        'etc/nginx/fastcgi_params'
        'etc/nginx/koi-win'
        'etc/nginx/koi-utf'
        'etc/nginx/nginx.conf'
        'etc/nginx/scgi_params'
        'etc/nginx/uwsgi_params'
        'etc/nginx/win-utf'
        'etc/logrotate.d/nginx')
install=nginx.install
source=(hg+https://hg.nginx.org/nginx-quic#revision=a954b551dc3f
    service
    logrotate
    git+https://boringssl.googlesource.com/boringssl.git
    Enable_BoringSSL_OCSP.patch)
sha512sums=('SKIP'
    'be2858613d9cca85d80e7b894e9d5fa7892cbddd7a677d2d2f68f419d75fdc1f6802de8014f43ce063b116afd4ff17369873a6adea2dd58ac6f94e617de66fec'
    '9232342c0914575ce438c5a8ee7e1c25b0befb457a2934e9cb77d1fe9a103634ea403b57bc0ef0cd6cf72248aee5e5584282cea611bc79198aeac9a65d8df5d7'
    'SKIP'
    'd512997f63d9a93c5b111c3a5a0dcd5ad57d378336de48667943fb814c1704a0155f220177fb6940d95342b11f017ad45ddfa5c0cde70c10947303d949ee9794')

_common_flags=(
  --with-file-aio
  --with-http_addition_module
  --with-http_auth_request_module
  --with-http_dav_module
  --with-http_degradation_module
  --with-http_flv_module
  --with-http_geoip_module
  --with-http_gunzip_module
  --with-http_gzip_static_module
  --with-http_mp4_module
  --with-http_realip_module
  --with-http_secure_link_module
  --with-http_slice_module
  --with-http_ssl_module
  --with-http_stub_status_module
  --with-http_sub_module
  --with-http_v2_module
  --with-http_v3_module
  --with-mail
  --with-mail_ssl_module
  --with-stream
  --with-stream_geoip_module
  --with-stream_realip_module
  --with-stream_ssl_module
  --with-stream_quic_module
  --with-stream_ssl_preread_module
  --with-threads
)

_mainline_flags=(
)

prepare() {
    ln -sf nginx-quic nginx-mainline
    test -d ${srcdir}/${pkgname}-src && rm -r ${srcdir}/${pkgname}-src
    cp -r ${srcdir}/${pkgname} ${srcdir}/${pkgname}-src
}

build() {
    export CXXFLAGS="$CXXFLAGS -fPIC"
    export CFLAGS="$CFLAGS -fPIC"

    # Disable some warnings that make Boringssl fail to compile due to a forced -Werror in CMakeLists.txt
    # -Wno-array-bounds: 2022-05-21 for compatiblity with GCC 12.1 (https://bugs.chromium.org/p/boringssl/issues/detail?id=492&sort=-modified)
    export CFLAGS="$CFLAGS -Wno-stringop-overflow -Wno-array-parameter -Wno-array-bounds -ftrivial-auto-var-init=zero"

    cd ${srcdir}/boringssl
    rm -rf .openssl
    mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ../ && make crypto ssl
    cd ${srcdir}/boringssl
    mkdir -p .openssl/lib && cd .openssl && ln -s ../include . && cd ../
    cp ${srcdir}/boringssl/build/crypto/libcrypto.a ${srcdir}/boringssl/build/ssl/libssl.a .openssl/lib
    cd ..

    cd ${srcdir}/$pkgname
    patch -p1 < ../Enable_BoringSSL_OCSP.patch
    ./auto/configure \
        --prefix=/etc/nginx \
        --conf-path=/etc/nginx/nginx.conf \
        --sbin-path=/usr/bin/nginx \
        --pid-path=/run/nginx.pid \
        --lock-path=/run/lock/nginx.lock \
        --user=http \
        --group=http \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=stderr \
        --http-client-body-temp-path=/var/lib/nginx/client-body \
        --http-proxy-temp-path=/var/lib/nginx/proxy \
        --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
        --http-scgi-temp-path=/var/lib/nginx/scgi \
        --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
        --with-openssl=${srcdir}/boringssl \
        --with-cc-opt="$CFLAGS $CPPFLAGS -I../boringssl/include -flto -fvisibility=hidden -fcf-protection -O3 -fstack-protector-all" \
        --with-ld-opt="$LDFLAGS -L../boringssl/build/ssl -L../boringssl/build/crypto -flto -Wl,-O3 -Wl,-z,noexecstack -Wl,-z,now -Wl,-z,relro" \
        ${_common_flags[@]} \
        ${_mainline_flags[@]}

    touch ${srcdir}/boringssl/.openssl/include/openssl/ssl.h
    make
}

package_nginx-mainline() {
  provides=($_pkgbase)
  conflicts=($_pkgbase)

  cd ${srcdir}/$pkgname
  make DESTDIR="$pkgdir" install

  sed -e 's|\<user\s\+\w\+;|user http;|g' \
    -e '44s|html|/usr/share/nginx/html|' \
    -e '54s|html|/usr/share/nginx/html|' \
    -i "$pkgdir"/etc/nginx/nginx.conf

  rm "$pkgdir"/etc/nginx/*.default
  rm "$pkgdir"/etc/nginx/mime.types  # in mailcap

  install -d "$pkgdir"/var/lib/nginx
  install -dm700 "$pkgdir"/var/lib/nginx/proxy

  chmod 755 "$pkgdir"/var/log/nginx
  chown root:root "$pkgdir"/var/log/nginx

  install -d "$pkgdir"/usr/share/nginx
  mv "$pkgdir"/etc/nginx/html/ "$pkgdir"/usr/share/nginx

  install -Dm644 ../logrotate "$pkgdir"/etc/logrotate.d/nginx
  install -Dm644 ../service "$pkgdir"/usr/lib/systemd/system/nginx.service
  install -Dm644 docs/text/LICENSE "$pkgdir"/usr/share/licenses/$provides/LICENSE
  install -d "$pkgdir"/usr/share/licenses/$pkgname
  ln -s /usr/share/licenses/$provides/LICENSE "$pkgdir"/usr/share/licenses/$pkgname/LICENSE

  rmdir "$pkgdir"/run

  install -d "$pkgdir"/usr/share/man/man8/

  for i in ftdetect ftplugin indent syntax; do
    install -Dm644 contrib/vim/$i/nginx.vim \
      "$pkgdir/usr/share/vim/vimfiles/$i/nginx.vim"
  done
}
