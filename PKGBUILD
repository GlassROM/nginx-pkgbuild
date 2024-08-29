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
pkgver=1.27.1
pkgrel=1
pcrepkgname=pcre2
pcrepkgver=10.44
pcrepkgrel=1
zlibpkgname=zlib
zlibpkgver=1.3.1
zlibpkgrel=2
pkgdesc='Lightweight HTTP server and IMAP/POP3 proxy server, mainline release'
arch=('x86_64')
url='https://nginx.org'
license=('BSD-2-Clause')
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
)

b2sums=('d31dac0ced22604a3e8d3b054b3fe560aef4e29b56346466e09e39316ce21ff4b107233a50e58d20419551fd8b9cc530f855445efd88b8497b492676e10de3d8'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'fb06228f8bdc5906ef4f19d7d677f1009070855149d9ad3f807cfcd164f5cb6165f96e074fedc3942226d4b29edf4b29fab6cde2f2ba58bf6da282730941412b'
    '42d109223801a493de6d52e7343403d7fc3234a6ca816425fe41ac9c18019b01b93841acd28a235e99f2256a6a17f93624e96b2ddb58d588c8190a6bedb82910'
    'SKIP'
)
sha512sums=('9bbdfcd7b9524f48e96b2ce6cc74bab20242885f208d1ad4117336a24642f3355d1c379e6041a4c341e31fb15faea39fc4410b6523164e3179594bbfb5fc35f5'
    'ca7d8666177d31b6c4924e9ab44ddf3d5b596b51da04d38da002830b03bd176d49354bbdd2a496617d57f44111ad59833296af87d03ffe3fca6b99327a7b4c3c'
    '2f4dfcfa711b8bcbc5918ba635f5e430ef7132e66276261ade62bb1cba016967432c8dce7f84352cb8b07dc7c6b18f09177aa3eb92c8e358b2a106c8ca142fe9'
    'SKIP'
    'd512997f63d9a93c5b111c3a5a0dcd5ad57d378336de48667943fb814c1704a0155f220177fb6940d95342b11f017ad45ddfa5c0cde70c10947303d949ee9794'
    'ee91cc10a2962bc7818b03d368df3dd31f42ea9a7260ae51483ea8cd331b7431e36e63256b0adc213cc6d6741e7c90414fd420622308c0ae3fcb5dd878591be2'
    '1e8e70b362d64a233591906a1f50b59001db04ca14aaffad522198b04680be501736e7d536b4191e2f99767e7001ca486cd802362cca2be05d5d409b83ea732d'
    '354d9f5e99ad5390effbb6283c282e3c4df68f6e3eb739738ad4700f081cfaf11a664440b1deb80fbf432e77fd9471c06220416f688fbf84deaa8ca4fd7941ad'
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
    export CXXFLAGS="$CXXFLAGS -fomit-frame-pointer -fPIC -ftrivial-auto-var-init=zero -flto -fcf-protection -D_FORTIFY_SOURCE=3 -fwrapv -fzero-call-used-regs=all -fno-delete-null-pointer-checks -D_GLIBCXX_ASSERTIONS -g0 -fPIE -pie -fPIC -fno-strict-overflow -fno-strict-aliasing -fhardened -Wno-hardened -Wno-error=hardened -fvisibility=hidden"
    export CFLAGS="$CFLAGS -fPIC -fomit-frame-pointer -g0 -fPIE -pie -fPIC -fno-strict-overflow -fno-strict-aliasing -fhardened -Wno-hardened -Wno-error=hardened -fvisibility=hidden"

    if [[ -n "${USE_NATIVE}" ]]; then
        export CFLAGS="$CFLAGS -march=native -mtune=native"
        export CXXFLAGS="$CXXFLAGS -march=native -mtune=native"
    fi

    if [[ -n "${CROSS_COMPILE_FOR_AAK}" ]]; then
        export CFLAGS="$CFLAGS -fcf-protection=full -march=alderlake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512vbmi -mno-avx512ifma -mno-avx512vpopcntdq -mno-avx512vbmi2 -mgfni -mvpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mno-pconfig -mno-pku -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mserialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mwaitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex -mno-avxvnniint16 -mno-sm3 -mno-sha512 -mno-sm4 -mno-apxf -mno-usermsr --param l1-cache-size=48 --param l1-cache-line-size=64 --param l2-cache-size=30720 -mtune=alderlake"
        export CXXFLAGS="$CXXFLAGS -fcf-protection=full -march=alderlake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512vbmi -mno-avx512ifma -mno-avx512vpopcntdq -mno-avx512vbmi2 -mgfni -mvpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mno-pconfig -mno-pku -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mserialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mwaitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex -mno-avxvnniint16 -mno-sm3 -mno-sha512 -mno-sm4 -mno-apxf -mno-usermsr --param l1-cache-size=48 --param l1-cache-line-size=64 --param l2-cache-size=30720 -mtune=alderlake"
    fi

    export CFLAGS="$CFLAGS -ftrivial-auto-var-init=zero -fcf-protection -fstack-protector-strong -D_FORTIFY_SOURCE=3 -fwrapv -fzero-call-used-regs=all -fno-delete-null-pointer-checks"
    # Disable some warnings that make Boringssl fail to compile due to a forced -Werror in CMakeLists.txt
    # -Wno-array-bounds: 2022-05-21 for compatiblity with GCC 12.1 (https://bugs.chromium.org/p/boringssl/issues/detail?id=492&sort=-modified)
    export CFLAGBACKUP="$CFLAGS"
    export CXXFLAGBACKUP="$CXXFLAGS"
    export CFLAGS="$CFLAGS -Wno-stringop-overflow -Wno-array-parameter -Wno-dangling-pointer -Wno-array-bounds -Wno-error=restrict"
    export CXXFLAGS="$CXXFLAGS -fvisibility-inlines-hidden"
    export LDFLAGS="$LDFLAGS -Wl,-O3 -Wl,-z,noexecstack -Wl,-pie -Wl,--strip-all -Wl,--sort-common -Wl,--no-undefined -Wl,-z,now -Wl,-z,relro -Wl,-O3,--as-needed,-z,defs,-z,relro,-z,now,-z,nodlopen,-z,text"

    cd ${srcdir}/boringssl
    rm -rf .openssl
    mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release ../ && make crypto ssl
    cd ${srcdir}/boringssl
    mkdir -p .openssl/lib && cd .openssl && ln -s ../include . && cd ../
    cp ${srcdir}/boringssl/build/crypto/libcrypto.a ${srcdir}/boringssl/build/ssl/libssl.a .openssl/lib
    cd ..
    export CFLAGS="$CFLAGBACKUP"

    cd ${srcdir}/$pcrepkgname-$pcrepkgver
    sed -i "1a CFLAGS=\"$CFLAGS\"" configure
    sed -i "1a CXXFLAGS=\"$CXXFLAGS\"" configure

    # Never LTO BoringSSL. Bad things will happen
    GRAPHITE="-fgraphite -fgraphite-identity -floop-interchange -ftree-loop-distribution -floop-strip-mine -floop-block -ftree-loop-linear"
    export CFLAGS="$CFLAGS $GRAPHITE -flto -DTCP_FASTOPEN=23 -O3 -funroll-loops -fdata-sections -ffunction-sections -fstrict-flex-arrays=3"
    export LDFLAGS="$LDFLAGS -flto -Wl,--gc-sections"
    export CXXFLAGBACKUP="$CXXFLAGBACKUP $GRAPHITE"

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
        --with-cc-opt="$CFLAGS $CPPFLAGS $CXXFLAGBACKUP -I../boringssl/include -flto -fstack-protector-all -DGL_BORINGSSL_BUILD -Wall -Werror" \
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
    install -Dm644 LICENSE "$pkgdir"/usr/share/licenses/$pkgname/LICENSE

    rmdir "$pkgdir"/run

    install -Dm0644 objs/nginx.8 "$pkgdir"/usr/share/man/man8/nginx.8

    for i in ftdetect ftplugin indent syntax; do
        install -Dm644 contrib/vim/$i/nginx.vim \
            "$pkgdir/usr/share/vim/vimfiles/$i/nginx.vim"
    done
}
