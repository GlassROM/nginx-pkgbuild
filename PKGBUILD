# Maintainer: Giancarlo Razzolini <grazzolini@archlinux.org>
# Maintainer: T.J. Townsend <blakkheim@archlinux.org>
# Maintainer: Massimiliano Torromeo <massimiliano.torromeo@gmail.com>
# Contributor: Bartłomiej Piotrowski <bpiotrowski@archlinux.org>
# Contributor: Sébastien Luttringer
# Contributor: Drew DeVault

_pkgbase=nginx
pkgbase=nginx-mainline
pkgname=nginx-mainline
pkgver=1.25.2
pkgrel=1
pcrepkgname=pcre2
pcrepkgver=10.42
pcrepkgrel=2
zlibpkgname=zlib
zlibpkgver=1.2.13
zlibpkgrel=2
pkgdesc='Lightweight HTTP server and IMAP/POP3 proxy server, mainline release'
arch=('x86_64')
url='https://nginx.org'
license=('custom')
depends=('mailcap' 'libxcrypt' 'hardened-malloc-git')
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
source=($url/download/nginx-$pkgver.tar.gz
    service
    logrotate
    git+https://boringssl.googlesource.com/boringssl.git
    Enable_BoringSSL_OCSP.patch
    https://github.com/PhilipHazel/pcre2/releases/download/$pcrepkgname-$pcrepkgver/$pcrepkgname-$pcrepkgver.tar.bz2
    https://zlib.net/${zlibpkgname}-${zlibpkgver}.tar.gz
    boringssl.patch
)

b2sums=('546a74c633400e51f6afded396fc36013574dd9ddc6b5f321bd5379c3a27613954de93957268213bc9724943515cab3d23b3965a384c4f71dfb4c759bba49912'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP')
sha512sums=('47da46d823f336432aca6c4cd54c76660af60620518d5c518504033a9fd6b411fd6d41e4aac2c8200311a53f96159aa3da8920145e8ed85596c9c2c14e20cb27'
    'be2858613d9cca85d80e7b894e9d5fa7892cbddd7a677d2d2f68f419d75fdc1f6802de8014f43ce063b116afd4ff17369873a6adea2dd58ac6f94e617de66fec'
    '9232342c0914575ce438c5a8ee7e1c25b0befb457a2934e9cb77d1fe9a103634ea403b57bc0ef0cd6cf72248aee5e5584282cea611bc79198aeac9a65d8df5d7'
    'SKIP'
    'd512997f63d9a93c5b111c3a5a0dcd5ad57d378336de48667943fb814c1704a0155f220177fb6940d95342b11f017ad45ddfa5c0cde70c10947303d949ee9794'
    '72fbde87fecec3aa4b47225dd919ea1d55e97f2cbcf02aba26e5a0d3b1ffb58c25a80a9ef069eb99f9cf4e41ba9604ad06a7ec159870e1e875d86820e12256d3'
    'SKIP'
    '354d9f5e99ad5390effbb6283c282e3c4df68f6e3eb739738ad4700f081cfaf11a664440b1deb80fbf432e77fd9471c06220416f688fbf84deaa8ca4fd7941ad')
sha256sums=('SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'b3a24de97a8fdbc835b9833169501030b8977031bcb54b3b3ac13740f846ab30'
    'SKIP')

_common_flags=(
    --with-file-aio
    --with-http_addition_module
    --with-http_auth_request_module
    --with-http_dav_module
    --with-http_degradation_module
    --with-http_flv_module
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
    --with-stream_realip_module
    --with-stream_ssl_module
    --with-stream_ssl_preread_module
    --with-threads
)

_mainline_flags=(
)

build() {
    export CXXFLAGS="$CXXFLAGS -fPIC -ftrivial-auto-var-init=zero -flto -fcf-protection"
    export CFLAGS="$CFLAGS -fPIC"

    # Disable some warnings that make Boringssl fail to compile due to a forced -Werror in CMakeLists.txt
    # -Wno-array-bounds: 2022-05-21 for compatiblity with GCC 12.1 (https://bugs.chromium.org/p/boringssl/issues/detail?id=492&sort=-modified)
    export CFLAGS="$CFLAGS -Wno-stringop-overflow -Wno-array-parameter -Wno-dangling-pointer -Wno-array-bounds -ftrivial-auto-var-init=zero -fcf-protection"
    export LDFLAGS="$LDFLAGS -Wl,-O3 -Wl,-z,noexecstack -Wl,-z,now -Wl,-z,relro -Wl,-O1,--as-needed,-z,defs,-z,relro,-z,now,-z,nodlopen,-z,text"

    cd ${srcdir}/boringssl
    rm -rf .openssl
    mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ../ && make crypto ssl
    cd ${srcdir}/boringssl
    mkdir -p .openssl/lib && cd .openssl && ln -s ../include . && cd ../
    cp ${srcdir}/boringssl/build/crypto/libcrypto.a ${srcdir}/boringssl/build/ssl/libssl.a .openssl/lib
    cd ..

    # Never LTO BoringSSL. Bad things will happen
    GRAPHITE="-fgraphite -fgraphite-identity -floop-interchange -ftree-loop-distribution -floop-strip-mine -floop-block -ftree-loop-linear"
    export CFLAGS="$CFLAGS $GRAPHITE -flto -DTCP_FASTOPEN=23"
    export LDFLAGS="$LDFLAGS -flto"

    cd ${srcdir}/$_pkgbase-$pkgver
    patch -p1 <../Enable_BoringSSL_OCSP.patch
    patch -p1 <../boringssl.patch
    ./configure \
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
        --with-pcre=${srcdir}/$pcrepkgname-$pcrepkgver \
        --with-zlib=${srcdir}/$zlibpkgname-$zlibpkgver \
        --with-cc-opt="$CFLAGS $CPPFLAGS -I../boringssl/include -flto -fvisibility=hidden -O3 -fstack-protector-all -DGL_BORINGSSL_BUILD" \
        --with-ld-opt="$LDFLAGS -L../boringssl/build/ssl -L../boringssl/build/crypto -lcrypto -lhardened_malloc" \
        ${_common_flags[@]} \
        ${_mainline_flags[@]}

    touch ${srcdir}/boringssl/.openssl/include/openssl/ssl.h
    make
}

package() {
    provides=($_pkgbase)
    conflicts=($_pkgbase)

    cd ${srcdir}/$_pkgbase-$pkgver
    make DESTDIR="$pkgdir" install

    sed -e 's|\<user\s\+\w\+;|user http;|g' \
        -e '44s|html|/usr/share/nginx/html|' \
        -e '54s|html|/usr/share/nginx/html|' \
        -i "$pkgdir"/etc/nginx/nginx.conf

    rm "$pkgdir"/etc/nginx/*.default
    rm "$pkgdir"/etc/nginx/mime.types # in mailcap

    install -d "$pkgdir"/var/lib/nginx
    install -dm700 "$pkgdir"/var/lib/nginx/proxy

    chmod 755 "$pkgdir"/var/log/nginx
    chown root:root "$pkgdir"/var/log/nginx

    install -d "$pkgdir"/usr/share/nginx
    mv "$pkgdir"/etc/nginx/html/ "$pkgdir"/usr/share/nginx

    install -Dm644 ../logrotate "$pkgdir"/etc/logrotate.d/nginx
    install -Dm644 ../service "$pkgdir"/usr/lib/systemd/system/nginx.service
    install -Dm644 LICENSE "$pkgdir"/usr/share/licenses/$_pkgbase/LICENSE

    rmdir "$pkgdir"/run

    install -d "$pkgdir"/usr/share/man/man8/
    gzip -9c man/nginx.8 >"$pkgdir"/usr/share/man/man8/nginx.8.gz

    for i in ftdetect ftplugin indent syntax; do
        install -Dm644 contrib/vim/$i/nginx.vim \
            "$pkgdir/usr/share/vim/vimfiles/$i/nginx.vim"
    done
}
