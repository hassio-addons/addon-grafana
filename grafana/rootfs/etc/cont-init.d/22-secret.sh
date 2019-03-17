#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Sets unique secret key used for signing cookies.
# ==============================================================================
readonly CONFIG="/etc/grafana/grafana.ini"

sed -i "s/secret_key.*/secret_key = ${HASSIO_TOKEN}/g" "${CONFIG}"
