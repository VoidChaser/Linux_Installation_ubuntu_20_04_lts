bash
#!/bin/bash
# Automated Ubuntu 20.04 setup based on this guide

echo "Setting static IP..."
sudo netplan apply

echo "Installing monitoring tools..."
sudo apt install -y htop ncdu net-tools

echo "Configuring SSH..."
sudo sed -i 's/#Port 22/Port 2022/' /etc/ssh/sshd_config
sudo systemctl restart ssh

echo "Setup complete!"