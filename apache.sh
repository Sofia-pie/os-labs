#!/bin/bash
sudo apt-get update && sudo apt -y install apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo '<p>appache is running</p>' | sudo tee /var/www/html/index.html