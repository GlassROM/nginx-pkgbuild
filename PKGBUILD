# Contributor: Giancarlo Razzolini <grazzolini@archlinux.org>
# Contributor: T.J. Townsend <blakkheim@archlinux.org>
# Contributor: Massimiliano Torromeo <massimiliano.torromeo@gmail.com>
# Contributor: Bartłomiej Piotrowski <bpiotrowski@archlinux.org>
# Contributor: Sébastien Luttringer
# Contributor: Drew DeVault
# Contributor: David Runge <dvzrv@archlinux.org>
# Contributor: Levente Polyak <anthraxx@archlinux.org>
# Contributor: Pierre Schmitz <pierre@archlinux.de>
# Contributor: Felix Yan <felixonmars@archlinux.org>
# Contributor: Mateusz 'mrlemux' Lemusisk mrlemux at gmail dotcom
# Parts taken from the pcre package by Sébastien "Seblu" Luttringer
# Contributor: Allan McRae <allan@archlinux.org>
# Contributor: Eric Belanger <eric@archlinux.org>
# Contributor: John Proctor <jproctor@prium.net>

_pkgbase=nginx
pkgbase=nginx-mainline
pkgname=nginx-mainline
pkgver=1.25.5
pkgrel=2
pcrepkgname=pcre2
pcrepkgver=10.43
pcrepkgrel=4
zlibpkgname=zlib
zlibpkgver=1.3.1
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
    https://github.com/PCRE2Project/pcre2/releases/download/$pcrepkgname-$pcrepkgver/$pcrepkgname-$pcrepkgver.tar.bz2
    https://github.com/madler/zlib/releases/download/v$zlibpkgver/$zlibpkgname-$zlibpkgver.tar.xz
    boringssl.patch
    https://github.com/zherczeg/sljit/commit/56dbde07b05252f0b304b04040a86cfb9f109ae9.patch
    https://github.com/zherczeg/sljit/commit/ad89dd8ecd25589d236bd20b36f2abf69f938fd1.patch
)

b2sums=('75ff068554d96063d1c7cb18d84df4fe8b820f6065f3464efde055c707e94ff13c45bea261619a453f04abed1fa3f9baccf81c29ca0e956ef0535e9a5c931dc6'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    '42d109223801a493de6d52e7343403d7fc3234a6ca816425fe41ac9c18019b01b93841acd28a235e99f2256a6a17f93624e96b2ddb58d588c8190a6bedb82910'
    'SKIP'
    '736aa7eaa2ed571117f545ae78151fda6a5ef5935bf70f132b1d20d0ff6e46543194f409a02eac727a8209fb0d25e6870705e8a95b3feb07e799d288fd852822'
    '9ad1b0dca06cf3620158458e26c2007fb46990bdf178a75a621be5c665e8726990789510827829e9c480cbebee0b3b5da27f9857e3b19019307e4959671dfbac'
)
sha512sums=('4a069ec08af46e42a72e263291fc84a67605d817ece1ea7092a5da5babced96ef27eb370ad6f7558b2f5973406080240080aaf4b27fc2d8b41f6853601563cb7'
    'ca7d8666177d31b6c4924e9ab44ddf3d5b596b51da04d38da002830b03bd176d49354bbdd2a496617d57f44111ad59833296af87d03ffe3fca6b99327a7b4c3c'
    '2f4dfcfa711b8bcbc5918ba635f5e430ef7132e66276261ade62bb1cba016967432c8dce7f84352cb8b07dc7c6b18f09177aa3eb92c8e358b2a106c8ca142fe9'
    'SKIP'
    'd512997f63d9a93c5b111c3a5a0dcd5ad57d378336de48667943fb814c1704a0155f220177fb6940d95342b11f017ad45ddfa5c0cde70c10947303d949ee9794'
    '8ac1520c32e9e5672404aaf6104e23c9ee5c3c28ad28ff101435599d813cbb20e0491a3fd34e012b4411b3e0366a4c6dfa3f02d093acaa6ff0ab25478bb7ade9'
    '1e8e70b362d64a233591906a1f50b59001db04ca14aaffad522198b04680be501736e7d536b4191e2f99767e7001ca486cd802362cca2be05d5d409b83ea732d'
    '354d9f5e99ad5390effbb6283c282e3c4df68f6e3eb739738ad4700f081cfaf11a664440b1deb80fbf432e77fd9471c06220416f688fbf84deaa8ca4fd7941ad'
    '4379a06a142a9c9dc61298e86c722f1f2b6d83493acda8e472c866093b3e2192d315998c5a87dfd231739394d5c809c05415126084b18f80a002ee8861c0ed4f'
    '9548da45cb030f53b634a9ba340687d04bd6c5b88ffd78932f231a4092e5cc99b0698941fbd4f88d9a905bed0d0a85c5da697da9a531c4c4efc8f7578d0ffefe'
)

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
    cd ${srcdir}/$pcrepkgname-$pcrepkgver
    # Fix AVX detection
    # [PATCH] Add xgetbv feature detection support on x86
    patch -Np2 -i "$srcdir"/56dbde07b05252f0b304b04040a86cfb9f109ae9.patch -d src/sljit

    # Fix thread-safety issue in sljit's allocator
    # [PATCH] Fix locking region in sjlit_malloc_exec
    patch -Np2 -i "$srcdir"/ad89dd8ecd25589d236bd20b36f2abf69f938fd1.patch -d src/sljit
    export CXXFLAGS="$CXXFLAGS -fPIC -ftrivial-auto-var-init=zero -flto -fcf-protection -D_FORTIFY_SOURCE=3"
    export CFLAGS="$CFLAGS -fPIC"

    # Disable some warnings that make Boringssl fail to compile due to a forced -Werror in CMakeLists.txt
    # -Wno-array-bounds: 2022-05-21 for compatiblity with GCC 12.1 (https://bugs.chromium.org/p/boringssl/issues/detail?id=492&sort=-modified)
    export CFLAGS="$CFLAGS -Wno-stringop-overflow -Wno-array-parameter -Wno-dangling-pointer -Wno-array-bounds -ftrivial-auto-var-init=zero -fcf-protection -fstack-protector-strong -D_FORTIFY_SOURCE=3"
    export LDFLAGS="$LDFLAGS -Wl,-O3 -Wl,-z,noexecstack -Wl,-pie -Wl,--strip-all -Wl,--sort-common -Wl,--no-undefined -Wl,-z,now -Wl,-z,relro -Wl,-O3,--as-needed,-z,defs,-z,relro,-z,now,-z,nodlopen,-z,text"

    cd ${srcdir}/boringssl
    rm -rf .openssl
    mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ../ && make crypto ssl
    cd ${srcdir}/boringssl
    mkdir -p .openssl/lib && cd .openssl && ln -s ../include . && cd ../
    cp ${srcdir}/boringssl/build/crypto/libcrypto.a ${srcdir}/boringssl/build/ssl/libssl.a .openssl/lib
    cd ..

    # Never LTO BoringSSL. Bad things will happen
    GRAPHITE="-fgraphite -fgraphite-identity -floop-interchange -ftree-loop-distribution -floop-strip-mine -floop-block -ftree-loop-linear"
    export CFLAGS="$CFLAGS $GRAPHITE -flto -DTCP_FASTOPEN=23 -O3 -funroll-loops -fdata-sections -ffunction-sections"
    export LDFLAGS="$LDFLAGS -flto -Wl,--gc-sections"

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
        --with-cc-opt="$CFLAGS $CPPFLAGS -I../boringssl/include -flto -fvisibility=hidden -fstack-protector-all -DGL_BORINGSSL_BUILD" \
        --with-ld-opt="$LDFLAGS -L../boringssl/build/ssl -L../boringssl/build/crypto -lcrypto -lhardened_malloc -lstdc++" \
        "${_common_flags[@]}" \
        "${_mainline_flags[@]}"

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

    install -Dm0644 objs/nginx.8 "$pkgdir"/usr/share/man/man8/nginx.8

    for i in ftdetect ftplugin indent syntax; do
        install -Dm644 contrib/vim/$i/nginx.vim \
            "$pkgdir/usr/share/vim/vimfiles/$i/nginx.vim"
    done
}
