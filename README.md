# docker-openvpnas

Run the openvpn access server in a docker container.

## Published ports
The openvpn access server is using the following TCP and UDP ports
- tcp 443: User webinterface and TCP based openvpn tunnel
- tcp 943: Admin webinterface
- tcp 1194: TCP based openvpn tunnel (optional)
- udp 1194: UDP based openvpn tunnel

## Devices
The container needs to be able to create and access the tun interfaces on the host system.
You can allow access to the necessary tun interface with the command line
```
--device=/dev/net/tun
```
## Additional privileges
In addition to the device access the container needs to be able to access network devices and perform network related actions
You can add the necessary capabilities with the command line
```
--cap-add="NET_ADMIN"
--cap-add="NET_RAW"
```

## default admin account password
The admin account 'openvpn' has set the password "openvpn" as default.
You can change this by setting the environment variable "OPENVPN_PASSWORD"
```
-e OPENVPN_PASSWORD="mynewsecurepassword"
```

## Persistence 
By default the container has no persistent volumes.
It is recommended to make the configuration directory of the openvpn access server persistent or mount it to a host directory.
```
-v /srv/docker/openvpnas:/usr/local/openvpn_as/etc"
```

## Example command
```
docker run -e OPENVPN_PASSWORD="mynewsecurepassword" --publish=443:443 --publish=943:943 --publish=1194:1194 --publish=1194:1194/udp -v /srv/docker/openvpnas:/usr/local/openvpn_as/etc --device=/dev/net/tun --cap-add=NET_ADMIN --cap-add=NET_RAW -t --name openvpnas sebastianhutter/openvpnas:latest
```