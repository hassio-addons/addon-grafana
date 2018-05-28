#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures SSL within Grafana
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG="/etc/grafana/grafana.ini"
declare certfile
declare keyfile

if hass.config.true 'ssl'; then
    certfile=$(hass.config.get 'certfile')
    keyfile=$(hass.config.get 'keyfile')

    sed -i "s/protocol = http/protocol = https/g" "${CONFIG}"
    sed -i "s#cert_file = false#cert_file = /ssl/${certfile}#g" "${CONFIG}"
    sed -i "s#cert_key = false#cert_key = /ssl/${keyfile}#g" "${CONFIG}"
fi
