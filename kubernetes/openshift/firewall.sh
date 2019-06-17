#!/bin/bash -x
# Firewalld rules
#


firewalld() {
	# Remove old crap
	systemctl stop iptables
	systemctl disable iptables
}

installify() {
	# Add the firewalld package
	sudo dnf install -y firewalld
	# Enable
	systemctl enable firewalld
	# Start
	systemctl start firewalld
}

oc-firewalld() {
	# Add the rules required maybe
	firewall-cmd --permanent --new-zone dockerc
	firewall-cmd --permanent --zone dockerc --add-source 172.17.0.0/16
	firewall-cmd --permanent --zone dockerc --add-port 8443/tcp
	firewall-cmd --permanent --zone dockerc --add-port 53/udp
	firewall-cmd --permanent --zone dockerc --add-port 8053/udp
	firewall-cmd --reload
}
	

firewalld
installify
oc-firewalld
