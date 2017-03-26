#
# openvpn access server
#

FROM debian:jessie

# the openvpn access server version to be installed
ARG openvpnas_version=2.1.4

# install dependencies
RUN apt-get update \
  && apt-get install -y iptables libnfnetlink0 libxtables10 net-tools curl \
  && rm -rf /var/lib/apt/lists/*

# download and install openvpn as
RUN curl -Lo /tmp/openvpnas.dpkg http://swupdate.openvpn.org/as/openvpn-as-${openvpnas_version}-Debian8.amd_64.deb \
  && dpkg -i /tmp/openvpnas.dpkg \
  && rm -f /tmp/openvpnas.dpkg

# Expose the necessary ports
EXPOSE 443
EXPOSE 943
EXPOSE 1194
EXPOSE 1194/UDP

# move the entrypoint script
COPY build/docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

# set the work dir and the entrypoint
WORKDIR /
ENTRYPOINT ["/docker-entrypoint.sh"]
