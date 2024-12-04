#!/bin/bash
sed -i 's/#GatewayPorts no/GatewayPorts yes/' /etc/ssh/sshd_config
systemctl restart sshd