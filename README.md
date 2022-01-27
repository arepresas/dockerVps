# dockerVps

## OpenVpn

Initialize the configuration files and certificates

    docker-compose run --rm openvpn ovpn_genconfig -u udp://VPN.SERVERNAME.COM
    docker-compose run --rm openvpn ovpn_initpki

Fix ownership (depending on how to handle your backups, this may not be needed)

    sudo chown -R $(whoami): ./openvpn-data

Start OpenVPN server process

    docker-compose up -d openvpn

You can access the container logs with

    docker-compose logs -f

Generate a client certificate

    export CLIENTNAME="your_client_name"
    # with a passphrase (recommended)
    docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME
    # without a passphrase (not recommended)
    docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass

Retrieve the client configuration with embedded certificates

    docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

Revoke a client certificate

    # Keep the corresponding crt, key and req files.
    docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME
    # Remove the corresponding crt, key and req files.
    docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove

Enable debug output

    docker-compose run -e DEBUG=1 -p 1194:1194/udp openvpn

## HomeAssistant

Config for Reverse Proxy (configuration.yaml)

    http:
      ip_ban_enabled: true
      login_attempts_threshold: 5
      use_x_forwarded_for: true
      trusted_proxies:
        - 172.19.0.0/24

    homeassistant:
      auth_providers:
        - type: homeassistant
      external_url: "https://homeassistant.focalcloud.tk"

In NginxProxyManager activate WebSockets Support
