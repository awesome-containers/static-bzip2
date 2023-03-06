# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# https://gitlab.com/bzip2/bzip2
ARG BZIP2_VERSION=1.0.8

WORKDIR /src/xz
RUN git clone --branch "bzip2-$BZIP2_VERSION" \
        https://gitlab.com/bzip2/bzip2.git .

# hadolint ignore=DL3059
RUN make -j"$(nproc)" install PREFIX=/src/xz/dist CFLAGS='-w -g -Os -static'

WORKDIR /src/xz/dist/bin
# hadolint ignore=SC2044,DL4006
RUN set -xeu; \
    for bin in $(find . -executable -type f); do \
        file "$bin" -b --mime-type | grep -qw 'application/x-executable' || \
            continue; \
        ! ldd "$bin" && :; \
        strip -s -R .comment --strip-unneeded "$bin"; \
    done; \
    chmod -cR 755 ./*; \
    chown -cR 0:0 ./*; \
    for bin in $(find . -executable -type l); do \
        ln -sf "$(basename "$(readlink -f "$bin")")" "$bin"; \
    done; \
    ./bzip2 --version; \
    ln -sf bash sh

# static bzip2 image
FROM static-bash
COPY --from=build /src/xz/dist/bin/ /bin/
