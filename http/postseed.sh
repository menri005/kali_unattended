#!/bin/bash

### Use this section if you want to use SSH key authentication
# mkdir -p /root/.ssh
### Replace "YOUR SSH KEY" with a your PUBLIC SSH key.
# echo "YOUR SSH KEY" > /root/.ssh/authorized_keys
### Then disable SSH password authentication and allow root login for the key auth
# sed -i 's/#PasswordAuthentication\ yes/PasswordAuthentication\ no/g' /etc/ssh/sshd_config
# sed -i 's/#PermitRootLogin\ prohibit-password/PermitRootLogin\ without-password/g' /etc/ssh/sshd_config

### Otherwise, enable password auth for root (useful for crash and burn, not for permanent stuff)
sed -i 's/#PasswordAuthentication\ yes/PasswordAuthentication\ yes/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin\ prohibit-password/PermitRootLogin\ yes/g' /etc/ssh/sshd_config

### enable SSH service
systemctl enable ssh.service
systemctl start ssh.service