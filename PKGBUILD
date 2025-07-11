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
pkgver=1.29.0
pkgrel=1
pcrepkgname=pcre2
pcrepkgver=10.45
pcrepkgrel=1
zlibpkgname=zlib
zlibpkgver=1.3.1
zlibpkgrel=2
pkgdesc='Lightweight HTTP server and IMAP/POP3 proxy server, mainline release'
arch=('x86_64')
url='https://nginx.org'
license=('BSD-2-Clause')
depends=('mailcap' 'libxcrypt' 'hardened-malloc-git')
makedepends=('clang' 'cmake' 'git' 'lld' 'llvm' 'mercurial' 'go' 'polly')
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
options=('strip' 'lto')
source=(${_pkgbase}-${pkgver}::"git+https://github.com/nginx/nginx.git#tag=release-${pkgver}"
    service
    logrotate
    git+https://boringssl.googlesource.com/boringssl.git
    Enable_BoringSSL_OCSP.patch
    ${pcrepkgname}-${pcrepkgver}::"git+https://github.com/PCRE2Project/pcre2.git?signed#tag=${pcrepkgname}-${pcrepkgver}"
    https://github.com/madler/zlib/releases/download/v${zlibpkgver}/${zlibpkgname}-${zlibpkgver}.tar.xz
)

b2sums=('SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    '196dfcbf6f096b91cb2b72cd1eab53e42a72435f27224fb02fb846f52939d2ae44f1d3ef6d59c024919be9dc00774e13e1bf3c82bec2acb1ac1cf64d66a721cc'
    '42d109223801a493de6d52e7343403d7fc3234a6ca816425fe41ac9c18019b01b93841acd28a235e99f2256a6a17f93624e96b2ddb58d588c8190a6bedb82910'
)
sha512sums=('97d07f0e6477bbeb2959e9cdd9136e2ed6e6386902c3579ff82a452df88241b628441e6bfa7c14cc40bd6137fb47eb66b001d156bd801a60f7866f9c3098aa1d'
    '3217aff86052d8ed66884aa0b36ff5b874996d5ef5875e2de8f1a9a1d224ad96cd336582a6b667e124e0fc0fcf3d14c00e40090310d620237c6f2818f9147323'
    '2f4dfcfa711b8bcbc5918ba635f5e430ef7132e66276261ade62bb1cba016967432c8dce7f84352cb8b07dc7c6b18f09177aa3eb92c8e358b2a106c8ca142fe9'
    'SKIP'
    'd512997f63d9a93c5b111c3a5a0dcd5ad57d378336de48667943fb814c1704a0155f220177fb6940d95342b11f017ad45ddfa5c0cde70c10947303d949ee9794'
    '02e1b9972c00e3eae7d07ddf0519f19b5291c979fa316453d24fea41adce3e3213f484049091df448765b799b66556901c24a6238fd48a1eef79614319a1c68e'
    '1e8e70b362d64a233591906a1f50b59001db04ca14aaffad522198b04680be501736e7d536b4191e2f99767e7001ca486cd802362cca2be05d5d409b83ea732d'
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
    export CC=clang
    export CXX=clang++
    export LD=ld.lld
    export AR=llvm-ar
    export NM=llvm-nm
    export RANLIB=llvm-ranlib
    export STRIP=llvm-strip
    export OBJDUMP=llvm-objdump
    export OBJCOPY=llvm-objcopy
    export READELF=llvm-readelf

    export CXXFLAGS="$CXXFLAGS -fno-plt -fuse-ld=lld -fomit-frame-pointer -fPIC -ftrivial-auto-var-init=zero -flto -fcf-protection -D_FORTIFY_SOURCE=3 -fwrapv -fzero-call-used-regs=all -fno-delete-null-pointer-checks -D_GLIBCXX_ASSERTIONS -g0 -fPIE -pie -fPIC -fno-strict-overflow -fno-strict-aliasing -fvisibility=hidden -fsanitize=cfi-cast-strict,cfi-derived-cast,cfi-unrelated-cast -fsanitize-cfi-icall-generalize-pointers -fsanitize-cfi-icall-experimental-normalize-integers -fsanitize-trap=all -fstack-protector-all -fstack-clash-protection"
    export CFLAGS="$CFLAGS -fno-plt -fuse-ld=lld -fPIC -fomit-frame-pointer -g0 -fPIC -fno-strict-overflow -fno-strict-aliasing -fvisibility=hidden -fsanitize=cfi-cast-strict,cfi-derived-cast,cfi-unrelated-cast -fsanitize-cfi-icall-generalize-pointers -fsanitize-cfi-icall-experimental-normalize-integers -fsanitize-trap=all"

    if [[ -n "${USE_NATIVE}" ]]; then
        export CFLAGS="$CFLAGS -march=native -mtune=native"
        export CXXFLAGS="$CXXFLAGS -march=native -mtune=native"
    fi

    if [[ -n "${CROSS_COMPILE_FOR_AAK1}" ]]; then
        export CFLAGS="$CFLAGS -fcf-protection=full -march=alderlake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512vbmi -mno-avx512ifma -mno-avx512vpopcntdq -mno-avx512vbmi2 -mgfni -mvpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mno-pconfig -mno-pku -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mserialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mwaitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex -mno-avxvnniint16 -mno-sm3 -mno-sha512 -mno-sm4 -mno-apxf -mno-usermsr --param l1-cache-size=48 --param l1-cache-line-size=64 --param l2-cache-size=30720 -mtune=alderlake"
        export CXXFLAGS="$CXXFLAGS -fcf-protection=full -march=alderlake -mmmx -mpopcnt -msse -msse2 -msse3 -mssse3 -msse4.1 -msse4.2 -mavx -mavx2 -mno-sse4a -mno-fma4 -mno-xop -mfma -mno-avx512f -mbmi -mbmi2 -maes -mpclmul -mno-avx512vl -mno-avx512bw -mno-avx512dq -mno-avx512cd -mno-avx512vbmi -mno-avx512ifma -mno-avx512vpopcntdq -mno-avx512vbmi2 -mgfni -mvpclmulqdq -mno-avx512vnni -mno-avx512bitalg -mno-avx512bf16 -mno-avx512vp2intersect -mno-3dnow -madx -mabm -mno-cldemote -mclflushopt -mclwb -mno-clzero -mcx16 -mno-enqcmd -mf16c -mfsgsbase -mfxsr -mno-hle -msahf -mno-lwp -mlzcnt -mmovbe -mmovdir64b -mmovdiri -mno-mwaitx -mno-pconfig -mno-pku -mprfchw -mno-ptwrite -mrdpid -mrdrnd -mrdseed -mno-rtm -mserialize -mno-sgx -msha -mshstk -mno-tbm -mno-tsxldtrk -mvaes -mwaitpkg -mno-wbnoinvd -mxsave -mxsavec -mxsaveopt -mxsaves -mno-amx-tile -mno-amx-int8 -mno-amx-bf16 -mno-uintr -mno-hreset -mno-kl -mno-widekl -mavxvnni -mno-avx512fp16 -mno-avxifma -mno-avxvnniint8 -mno-avxneconvert -mno-cmpccxadd -mno-amx-fp16 -mno-prefetchi -mno-raoint -mno-amx-complex -mno-avxvnniint16 -mno-sm3 -mno-sha512 -mno-sm4 -mno-apxf -mno-usermsr --param l1-cache-size=48 --param l1-cache-line-size=64 --param l2-cache-size=30720 -mtune=alderlake"
    fi

    export CFLAGS="$CFLAGS -ftrivial-auto-var-init=zero -fcf-protection=full -fstack-protector-all -fstack-clash-protection -D_FORTIFY_SOURCE=3 -fwrapv -fzero-call-used-regs=all -fno-delete-null-pointer-checks"
    # Disable some warnings that make Boringssl fail to compile due to a forced -Werror in CMakeLists.txt
    # -Wno-array-bounds: 2022-05-21 for compatiblity with GCC 12.1 (https://bugs.chromium.org/p/boringssl/issues/detail?id=492&sort=-modified)
    export CFLAGS="$CFLAGS -Wno-unused-command-line-argument -Wno-error=unused-command-line-argument"
    export CXXFLAGS="$CXXFLAGS -fvisibility-inlines-hidden -Wno-unused-command-line-argument -Wno-error=unused-command-line-argument"
    export CFLAGBACKUP="$CFLAGS"
    export CXXFLAGBACKUP="$CXXFLAGS"
    export LDFLAGS="$LDFLAGS -Wl,-O3 -Wl,-z,noexecstack -Wl,--strip-all -Wl,--sort-common -Wl,--no-undefined -Wl,-z,now -Wl,-z,relro -Wl,-O3,--as-needed,-z,defs,-z,relro,-z,now,-z,nodlopen,-z,text -Wl,-z,pack-relative-relocs -Wl,-z,shstk -Wl,-z,retpolineplt -Wl,--fatal-warnings,--warn-unresolved-symbols,--no-undefined -Wl,-Bsymbolic-functions"
    export CFLAGS="$CFLAGS -fsanitize=undefined,bounds"
    export CXXFLAGS="$CXXFLAGS -fsanitize=undefined,bounds"

    cd ${srcdir}/boringssl
    rm -rf .openssl
    mkdir -p build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=1 ../ && make crypto ssl -j$(nproc --all)
    cd ${srcdir}/boringssl
    mkdir -p .openssl/lib && cd .openssl && ln -s ../include . && cd ../
    cp ${srcdir}/boringssl/build/libcrypto.so ${srcdir}/boringssl/build/libssl.so .openssl/lib
    # --------------------------------------------------------------------
    # create thin wrapper archives so nginx thinks it is linking *.a,
    # but the linker actually pulls in the shared libraries
    echo 'INPUT(-l:libcrypto.so)' > .openssl/lib/libcrypto.a
    echo 'INPUT(-l:libssl.so)'    > .openssl/lib/libssl.a
    # --------------------------------------------------------------------
    cd ..
    export CFLAGS="$CFLAGBACKUP"
    export CXXFLAGS="$CXXFLAGBACKUP"

    # Never LTO BoringSSL. Bad things will happen
    POLLY="-Xclang -load -Xclang LLVMPolly.so -mllvm -polly -mllvm -polly-run-dce -mllvm -polly-run-inliner -mllvm -polly-ast-use-context -mllvm -polly-vectorizer=stripmine -mllvm -polly-invariant-load-hoisting"
    export CFLAGS="$CFLAGS $POLLY -flto -fsanitize=safe-stack,cfi -DTCP_FASTOPEN=23 -O3 -funroll-loops -fdata-sections -ffunction-sections -fstrict-flex-arrays=3 -fPIE -pie"
    export LDFLAGS="$LDFLAGS -flto -Wl,--gc-sections -Wl,-pie"
    export CXXFLAGS="$CXXFLAGS $POLLY -flto -DTCP_FASTOPEN=23 -fsanitize=safe-stack,cfi -O3 -funroll-loops -fdata-sections -ffunction-sections -fstrict-flex-arrays=3 -fPIE -pie"
    export CPPFLAGS="$CPPFLAGS $CXXFLAGS $POLLY"

    cd ${srcdir}/${pcrepkgname}-${pcrepkgver}
    sed -i "1a CFLAGS=\"$CFLAGS -fsanitize=undefined,bounds\"" configure
    sed -i "1a CXXFLAGS=\"$CXXFLAGS -fsanitize=undefined,bounds\"" configure
    sed -i "1a LDFLAGS=\"$LDFLAGS\"" configure

    cd ${srcdir}/${zlibpkgname}-${zlibpkgver}
    sed -i "1a CFLAGS=\"$CFLAGS -fsanitize=undefined,bounds\"" configure
    sed -i "1a CXXFLAGS=\"$CXXFLAGS -fsanitize=undefined,bounds\"" configure
    sed -i "1a LDFLAGS=\"$LDFLAGS\"" configure

    export CC="$CC $CFLAGS $CXXFLAGBACKUP"

    cd ${srcdir}/${_pkgbase}-${pkgver}
    patch -p1 <${srcdir}/Enable_BoringSSL_OCSP.patch
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
        --with-pcre=${srcdir}/${pcrepkgname}-${pcrepkgver} \
        --with-zlib=${srcdir}/${zlibpkgname}-${zlibpkgver} \
        --with-cc-opt="$CFLAGS $CXXFLAGBACKUP -I../boringssl/include -flto -DGL_BORINGSSL_BUILD -Wall -Werror" \
        --with-ld-opt="$LDFLAGS -L../boringssl/build -Wl,-rpath,'/../lib/boringssl' -l:libssl.so -l:libcrypto.so -lcrypt -lhardened_malloc -lstdc++" \
        "${_common_flags[@]}" \
        "${_mainline_flags[@]}"

    touch ${srcdir}/boringssl/.openssl/include/openssl/ssl.h
    make -j$(nproc --all)
}

package() {
    provides=($_pkgbase)
    conflicts=($_pkgbase)

    install -Dm755 "${srcdir}/boringssl/build/libcrypto.so" \
               "$pkgdir/usr/lib/boringssl/libcrypto.so"
    install -Dm755 "${srcdir}/boringssl/build/libssl.so" \
               "$pkgdir/usr/lib/boringssl/libssl.so"

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
