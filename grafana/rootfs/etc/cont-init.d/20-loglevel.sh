#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures Grafana with the add-on log level
# ==============================================================================
declare log_level

log_level="Info"
if bashio::config.exists 'log_level'; then
    case "$(bashio::string.lower "$(bashio::config 'log_level')")" in
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
fi

sed -i "s/level = Info/level = ${log_level}/g" /etc/grafana/grafana.ini
