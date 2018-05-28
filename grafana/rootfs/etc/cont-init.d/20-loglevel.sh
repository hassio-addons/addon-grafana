#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures Grafana with the add-on log level
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

declare log_level

# Find the matching Grafana log level
case "$(hass.string.lower "$(hass.config.get 'log_level')")" in
    all|trace)
        log_level="Trace"
        ;;
    debug)
        log_level="Debug"
        ;;
    info|notice)
        log_level="Info"
        ;;
    warning)
        log_level="Warn"
        ;;
    error)
        log_level="Error"
        ;;
    fatal|off)
        log_level="Critical"
        ;;
esac

sed -i "s/level = Info/level = ${log_level}/g" /etc/grafana/grafana.ini
