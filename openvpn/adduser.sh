#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
    echo 'you must provide a name for the certificate/user'
    exit 0
else
    docker exec -it -w /usr/share/easy-rsa openvpn ./easyrsa build-client-full $1 nopass
fi

PUBLIC_IP=$(curl -s ifconfig.me)
CA=$(docker exec -w /usr/share/easy-rsa openvpn cat pki/ca.crt)
CERT=$(docker exec -w /usr/share/easy-rsa openvpn cat pki/issued/$1.crt | sed -n '/-----BEGIN CERTIFICATE-----/,/-----END CERTIFICATE-----/p')
KEY=$(docker exec -w /usr/share/easy-rsa openvpn cat pki/private/$1.key)

cat <<EOF > $1.ovpn
client
dev tun
proto udp
remote $PUBLIC_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
ns-cert-type server
verb 3

<ca>
$CA
</ca>

<cert>
$CERT
</cert>

<key>
$KEY
</key>
EOF
