#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# This files check if all user configuration requirements are met
# ==============================================================================

# Check SSL requirements, if enabled
bashio::config.require.ssl
