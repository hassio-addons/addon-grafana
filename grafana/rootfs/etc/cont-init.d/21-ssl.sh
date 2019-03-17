#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures SSL within Grafana
# ==============================================================================

readonly CONFIG="/etc/grafana/grafana.ini"
declare certfile
declare keyfile

if bashio::config.true 'ssl'; then
    certfile=$(bashio::config 'certfile')
    keyfile=$(bashio::config 'keyfile')

    sed -i "s/protocol = http/protocol = https/g" "${CONFIG}"
    sed -i "s#cert_file = false#cert_file = /ssl/${certfile}#g" "${CONFIG}"
    sed -i "s#cert_key = false#cert_key = /ssl/${keyfile}#g" "${CONFIG}"
fi
