ARG BUILD_FROM=hassioaddons/debian-base:3.2.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Setup base system
ARG BUILD_ARCH=amd64
RUN \
    GRAFANA="7.1.1" \
    \
    && ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    && if [ "${BUILD_ARCH}" = "armv7" ]; then ARCH="armhf"; fi \
    \
    && curl -J -L -o /tmp/grafana.deb \
        "https://dl.grafana.com/oss/release/grafana_${GRAFANA}_${ARCH}.deb" \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libfontconfig1=2.13.1-2 \
        memcached=1.5.6-1.1 \
        nginx=1.14.2-2+deb10u2 \
    \
    && dpkg --install /tmp/grafana.deb \
    \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then \
        apt-get install -y --no-install-recommends \
            libasound2=1.1.8-1 \
            libcups2=2.2.10-6+deb10u3  \
            libdbus-1-3=1.12.20-0+deb10u1 \
            libglib2.0-0=2.58.3-2+deb10u2 \
            libgtk-3-0=3.24.5-1 \
            libnss3=2:3.42.1-1+deb10u3 \
            libx11-6=2:1.6.7-1 \
            libx11-xcb1=2:1.6.7-1 \
            libxcomposite1=1:0.4.4-2 \
            libxcursor1=1:1.1.15-2 \
            libxdamage1=1:1.1.4-3+b3 \
            libxext6=2:1.3.3-1+b2 \
            libxfixes3=1:5.0.3-1 \
            libxi6=2:1.7.9-1 \
            libxrandr2=2:1.5.1-1 \
            libxrender1=1:0.9.10-1 \
            libxss1=1:1.2.3-1 \
            libxtst6=2:1.2.3-1 \
        && grafana-cli plugins install "grafana-image-renderer" "2.0.0"; \
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

# Build arguments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Grafana" \
    io.hass.description="The open platform for beautiful analytics and monitoring" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="Grafana" \
    org.opencontainers.image.description="The open platform for beautiful analytics and monitoring" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/hassio-addons/addon-grafana" \
    org.opencontainers.image.documentation="https://github.com/hassio-addons/addon-grafana/blob/master/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
