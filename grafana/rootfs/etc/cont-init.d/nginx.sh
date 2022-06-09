#!/command/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: grafana
# Configures NGINX
# ==============================================================================
declare port
declare certfile
declare grafana_user
declare ingress_entry
declare ingress_interface
declare keyfile


port=$(bashio::addon.port 80)
if bashio::var.has_value "${port}"; then
    bashio::config.require.ssl

    if bashio::config.true 'ssl'; then
        certfile=$(bashio::config 'certfile')
        keyfile=$(bashio::config 'keyfile')

        mv /etc/nginx/servers/direct-ssl.disabled /etc/nginx/servers/direct.conf
        sed -i "s#%%certfile%%#${certfile}#g" /etc/nginx/servers/direct.conf
        sed -i "s#%%keyfile%%#${keyfile}#g" /etc/nginx/servers/direct.conf

    else
        mv /etc/nginx/servers/direct.disabled /etc/nginx/servers/direct.conf
    fi
    ingress_entry=$(bashio::addon.ingress_entry)
    sed -i "s#%%ingress_entry%%#${ingress_entry}#g" /etc/nginx/servers/direct.conf
fi

ingress_interface=$(bashio::addon.ip_address)
sed -i "s/%%interface%%/${ingress_interface}/g" /etc/nginx/servers/ingress.conf

grafana_user='admin'
if bashio::config.has_value 'grafana_ingress_user'; then
    grafana_user=$(bashio::config 'grafana_ingress_user')
fi
sed -i "s/%%grafana_user%%/${grafana_user}/g" /etc/nginx/servers/ingress.conf
