#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Install user configured/requested Grafana plugins
# ==============================================================================
if bashio::config.has_value 'plugins'; then
    for plugin in $(bashio::config 'plugins'); do
        grafana-cli plugins install "$plugin" \
            || bashio::exit.nok "Failed installing Grafana plugin: ${plugin}"
    done
fi
