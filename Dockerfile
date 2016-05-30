#
# openvpn access server
#

FROM fedora:23

# the openvpn access server version to be installed
ENV openvpnas_version 2.0.26

# install the openvpn access server package and
# install additional tools (net-tools is necessary to run the system)
RUN dnf install -y http://swupdate.openvpn.org/as/openvpn-as-${openvpnas_version}-Fedora23.x86_64.rpm && \
    dnf install -y net-tools
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
