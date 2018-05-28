ARG BUILD_FROM=hassioaddons/ubuntu-base-amd64:1.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Setup base system
ARG BUILD_ARCH=amd64

RUN \
    GRAFANA="5.1.3" \
    \
    && ARCH="${BUILD_ARCH}" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then ARCH="arm64"; fi \
    \
    && URL="https://github.com/fg2it/grafana-on-raspberry/releases/download/v${GRAFANA}/grafana_${GRAFANA}_${ARCH}.deb" \
    && if [ "${ARCH}" = "amd64" ]; then \
        URL="https://s3-us-west-2.amazonaws.com/grafana-releases/release/grafana_${GRAFANA}_${ARCH}.deb"; \
    fi \
    \
    && curl -J -L -o /tmp/grafana.deb "${URL}" \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        libfontconfig1=2.11.94-0ubuntu1.1 \
        memcached=1.4.25-2ubuntu1 \
    \
    && dpkg --install /tmp/grafana.deb \
    \
    && rm -rf /tmp/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/* \
    && rm -rf /var/{cache,log}/*

# Copy root filesystem
COPY rootfs /

# Build arugments
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="Grafana" \
    io.hass.description="The open platform for beautiful analytics and monitoring." \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="The open platform for beautiful analytics and monitoring." \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="Grafana" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://community.home-assistant.io/?u=frenck" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-grafana/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-grafana" \
    org.label-schema.vendor="Community Hass.io Add-ons"
