#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: Grafana
# Configures Grafana
# ==============================================================================
readonly CONFIG="/etc/grafana/grafana.ini"
declare ingress_entry
declare log_level

# Configures Grafana with the add-on log level
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
sed -i "s/level = Info/level = ${log_level}/g" "${CONFIG}"

# Sets unique secret key used for signing cookies.
if ! bashio::fs.file_exists "/data/secret"; then
    echo "${HASSIO_TOKEN}" > /data/secret
fi
secret=$(</data/secret)
sed -i "s/secret_key.*/secret_key = ${secret}/g" "${CONFIG}"

ingress_entry=$(bashio::addon.ingress_entry)
sed -i "s#%%ingress_entry%%#${ingress_entry}#g" "${CONFIG}"

# Install user configured/requested Grafana plugins
if bashio::config.has_value 'plugins'; then
    for plugin in $(bashio::config 'plugins'); do
        grafana-cli plugins install "$plugin" \
            || bashio::exit.nok "Failed installing Grafana plugin: ${plugin}"
    done
fi
