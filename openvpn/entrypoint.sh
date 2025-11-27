#!/bin/sh

# Creating the TUN device
mkdir -p /dev/net
mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# Creating certificates if not existent and run the server.
if [ ! -f /usr/share/easy-rsa/pki/ca.crt ]; then
    echo "Certificates not found. Generating them for you and starting OpenVPN server."
    cd /usr/share/easy-rsa
    ./easyrsa init-pki
    ./easyrsa gen-dh
    ./easyrsa build-ca nopass
    ./easyrsa build-server-full vpnserver nopass

    until [ -f /usr/share/easy-rsa/pki/dh.pem ]
        do
            sleep 5
        done
            openvpn --config /etc/openvpn/openvpn.conf
            #tail -f /dev/null
    exit

# Running the server if certs are already found.
else
    echo "Starting OpenVPN server."
    openvpn --config /etc/openvpn/openvpn.conf
    #tail -f /dev/null
fi