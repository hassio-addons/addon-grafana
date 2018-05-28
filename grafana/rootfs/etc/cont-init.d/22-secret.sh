#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Sets unique secret key used for signing cookies.
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG="/etc/grafana/grafana.ini"

sed -i "s/secret_key.*/secret_key = ${HASSIO_TOKEN}/g" "${CONFIG}"
