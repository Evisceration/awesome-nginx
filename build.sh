#!/bin/bash

BASE_DIR="$(pwd)"
CORE_DIR="${BASE_DIR}/nginx-core"
MODULES_DIR="${BASE_DIR}/nginx-modules"

# -Wall already included, -0 optimization needs to be edited at ${CORE_DIR}/auto/cc/gcc
CC_OPT="-Werror=format-security -fPIE -fstack-protector-strong -D_FORTIFY_SOURCE=2 -m64 -march=native"
LD_OPT="-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now"

echo "============================"
echo "MODULES_DIR: ${MODULES_DIR}"
echo "============================"

echo ""
echo "[+] Starting configuration!"
echo ""

cd ${CORE_DIR}

./auto/configure \
    --with-cc-opt="${CC_OPT}" \
    --with-ld-opt="${LD_OPT}" \
    --user=nginx \
    --group=nginx \
    --prefix=/usr/share/nginx \
    --conf-path=/etc/nginx/nginx.conf \
    --http-log-path=/var/log/nginx/access.log \
    --error-log-path=/var/log/nginx/error.log \
    --lock-path=/var/lock/nginx.lock \
    --pid-path=/run/nginx.pid \
    --http-client-body-temp-path=/var/lib/nginx/body \
    --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
    --http-proxy-temp-path=/var/lib/nginx/proxy \
    --http-scgi-temp-path=/var/lib/nginx/scgi \
    --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
    --with-pcre-jit \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_stub_status_module \
    --with-http_realip_module \
    --with-http_auth_request_module \
    --with-http_addition_module \
    --with-http_geoip_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_image_filter_module \
    --with-http_v2_module \
    --with-http_sub_module \
    --with-http_xslt_module \
    --with-stream \
    --with-stream_ssl_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-threads \
    --add-module=${MODULES_DIR}/echo-nginx-module \
    --add-module=${MODULES_DIR}/nginx-upstream-fair \
    --add-module=${MODULES_DIR}/ngx_http_auth_pam_module \
    --add-module=${MODULES_DIR}/ngx_http_substitutions_filter_module \

echo ""
echo "[+] Configuration done!"
echo ""

echo "[!] Building with"
cat ${CORE_DIR}/objs/Makefile | grep "CFLAGS ="
echo "================="
echo ""

make

cd ${BASE_DIR}
