#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
    echo 'you must provide a name for the certificate/user'
    exit 0
else
    docker exec -it -w /usr/share/easy-rsa openvpn ./easyrsa revoke $1
    docker exec -it -w /usr/share/easy-rsa openvpn ./easyrsa gen-crl
    docker exec -it -w /usr/share/easy-rsa openvpn rm pki/private/$1.key
    docker exec -it -w /usr/share/easy-rsa openvpn rm pki/reqs/$1.req
fi

rm $1.ovpn