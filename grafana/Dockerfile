ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:7.5.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
ARG GRAFANA_VERSION="v11.2.1"
ARG GRAFANA_IMAGE_RENDERER_VERSION="v3.11.5"
RUN \
    ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then ARCH="armhf"; fi \
    \
    && curl -J -L -o /tmp/grafana.deb \
        "https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION#v}_${ARCH}.deb" \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        fonts-noto-cjk=1:20220127+repack1-1 \
        libfontconfig1=2.14.1-4 \
        memcached=1.6.18-1 \
        musl=1.2.3-1 \
        nginx=1.22.1-9 \
    \
    && dpkg --install /tmp/grafana.deb \
    \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then \
        apt-get install -y --no-install-recommends \
            libasound2=1.2.8-1+b1 \
            libcups2=2.4.2-3+deb12u7 \
            libdbus-1-3=1.14.10-1~deb12u1 \
            libdrm-amdgpu1=2.4.114-1+b1 \
            libgbm1=22.3.6-1+deb12u1 \
            libglib2.0-0=2.74.6-2+deb12u3 \
            libgtk-3-0=3.24.38-2~deb12u2 \
            libnss3=2:3.87.1-1 \
            libx11-6=2:1.8.4-2+deb12u2 \
            libx11-xcb1=2:1.8.4-2+deb12u2 \
            libxcb-dri3-0=1.15-1 \
            libxcomposite1=1:0.4.5-1 \
            libxcursor1=1:1.2.1-1 \
            libxdamage1=1:1.1.6-1 \
            libxext6=2:1.3.4-1+b1 \
            libxfixes3=1:6.0.0-2 \
            libxi6=2:1.8-1+b1 \
            libxrandr2=2:1.5.2-2+b1 \
            libxrender1=1:0.9.10-1.1 \
            libxshmfence1=1.3-1 \
            libxss1=1:1.2.3-1 \
            libxtst6=2:1.2.3-1.1 \
        && grafana-cli plugins install "grafana-image-renderer" "${GRAFANA_IMAGE_RENDERER_VERSION#v}"; \
    fi \
    \
    && rm -fr \
        /tmp/* \
        /var/{cache,log}/* \
        /var/lib/apt/lists/* \
        /etc/nginx \
    \
    && mkdir -p /var/log/nginx \
    && touch /var/log/nginx/error.log

# Copy root filesystem
COPY rootfs /

# Health check
HEALTHCHECK \
    CMD curl --fail http://127.0.0.1:1337/api/health || exit 1

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
