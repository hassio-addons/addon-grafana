#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Install user configured/requested Grafana plugins
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'plugins'; then
    for plugin in $(hass.config.get 'plugins'); do
        grafana-cli plugins install "$plugin" \
            || hass.die "Failed installing Grafana plugin: ${plugin}"
    done
fi
