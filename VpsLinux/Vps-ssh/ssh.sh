# Install ssh server
apt-get install openssh-server

# Config
/etc/ssh/sshd_config

# Restart
/etc/init.d/ssh restart

# Copy ssh bublic keys to
~/.ssh/authorized_keys
# To logged user home to .ssh folder
cd
.ssh/authorized_keys

# Create ssh keys
ssh-keygen -t rsa

# Copy to remote host
ssh-copy-id -i ~/.ssh/id_rsa.pub $remote_user@$remote_host

# Login to remote host
ssh $remote_user@$remote_host


# Refrest ssh keys
# rm /etc/ssh/ssh_host_*
# dpkg-reconfigure openssh-server
