#!/bin/bash

BASE_DIR="$(pwd)"
CORE_DIR="${BASE_DIR}/nginx-core"
MODULES_DIR="${BASE_DIR}/nginx-modules"

# -Wall already included, -0 optimization needs to be edited at ${CORE_DIR}/auto/cc/gcc
CC_OPT="-O2 -Wall -Werror=format-security -fPIE -fstack-protector-strong -D_FORTIFY_SOURCE=2 -m64 -march=native"
LD_OPT="-Wl,-Bsymbolic-functions -fPIE -pie -Wl,-z,relro -Wl,-z,now"
