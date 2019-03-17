#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures Grafana with the add-on log level
# ==============================================================================
declare log_level

# Find the matching Grafana log level
case "${__BASHIO_LOG_LEVEL}" in
    7|8)
        log_level="Trace"
        ;;
    6)
        log_level="Debug"
        ;;
    4|5)
        log_level="Info"
        ;;
    3)
        log_level="Warn"
        ;;
    2)
        log_level="Error"
        ;;
    1|0)
        log_level="Critical"
        ;;
esac

sed -i "s/level = Info/level = ${log_level}/g" /etc/grafana/grafana.ini
