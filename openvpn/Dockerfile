FROM alpine:3.22
ENV EASYRSA_BATCH=1
RUN apk update && apk upgrade
RUN apk add --no-cache openvpn git easy-rsa
COPY openvpn.conf /etc/openvpn/openvpn.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
RUN echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.d/ipv4.conf
# RUN sysctl -p /etc/sysctl.d/ipv4.conf
ENTRYPOINT ["/entrypoint.sh"]