ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base/amd64:9.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
ARG GRAFANA_VERSION="v12.3.0"
ARG GRAFANA_IMAGE_RENDERER_VERSION="v4.1.5"
RUN \
    ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    \
    && curl -J -L -o /tmp/grafana.deb \
        "https://dl.grafana.com/oss/release/grafana_${GRAFANA_VERSION#v}_${ARCH}.deb" \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        fonts-noto-cjk=1:20240730+repack1-1 \
        libfontconfig1=2.15.0-2.3 \
        memcached=1.6.38-1 \
        musl=1.2.5-3 \
        nginx=1.26.3-3+deb13u1 \
    \
    && dpkg --install /tmp/grafana.deb \
    \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then \
        apt-get install -y --no-install-recommends \
            libasound2t64=1.2.14-1 \
            libcups2t64=2.4.10-3+deb13u1 \
            libdbus-1-3=1.16.2-2 \
            libdrm-amdgpu1=2.4.124-2 \
            libgbm1=25.0.7-2 \
            libglib2.0-0t64=2.84.4-3~deb13u1 \
            libgtk-4-1=4.18.6+ds-2 \
            libnss3=2:3.110-1 \
            libx11-6=2:1.8.12-1 \
            libx11-xcb1=2:1.8.12-1 \
            libxcb-dri3-0=1.17.0-2+b1 \
            libxcomposite1=1:0.4.6-1 \
            libxcursor1=1:1.2.3-1 \
            libxdamage1=1:1.1.6-1+b2 \
            libxext6=2:1.3.4-1+b3 \
            libxfixes3=1:6.0.0-2+b4 \
            libxi6=2:1.8.2-1 \
            libxrandr2=2:1.5.4-1+b3 \
            libxrender1=1:0.9.12-1 \
            libxshmfence1=1.3.3-1 \
            libxss1=1:1.2.3-1+b3 \
            libxtst6=2:1.2.5-1 \
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
