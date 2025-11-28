# Welcome to my docker OpenVPN server!
My goal is simple. Create a simple roadwarrior server with automatic cert creation.

# Usage:
**docker volume** This HAS to be set for preservation of certificates!

In the compose file, i make a static volume mounted at /usr/share/easy-rsa. If you *docker run* the server, be sure to set the volume. 
example:

**docker run -d --cap-add NET_ADMIN --volume certificates:/usr/share/easy-rsa --name openvpn ronaldvk90/openvpn:latest**
Or!
**docker compose up -d**

Be absolutely **SURE** the container name is "openvpn". Or else the *adduser.sh* and *rmuser.sh* scripts won't work.

# Create and delete users.
Just use the supplied adduser.sh and rmuser.sh with a username as paramater.
It will create a .ovpn file corresponding to your input in the openvpn folder.
