#!/bin/bash

## Install Terraform

IP=$(hostname -I | awk '{print $2}')

echo "START - copy ssh key on target - "$IP


echo "[1]: copy id_rsa.pub ssh terraform serveur on target serveur"
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRZxDNUwOcAO5D8rGZzdBlYKfdn3utcV39Z9kS8aJJGHZ85Pg+P07NlizjK9eD4NUzjyZ+wUjC6z7K4Dx1YRbsAgqhIjOjIIKoeZ6LUfkYVHufZcSNVJV5Ls9fB4zZL0/lhL29Pe2vWgDESHrWrUZziR/jiwebLD3SRT7ZL9L4VXaiCo8+0yWk8ZA9yhLQk9VJHl72FGHgjeRnxwgcJggueLz9B4i+QSSbNvMQTpdUkEhccy7DbGuS2kgMioG9ap/G+jgV8cm7IYSQotSSRayZZ5iOAO2KwItxm/Ktmiznn83MShid8A7eMeaXk9GinmZ7scDOGr4Crdh/C2yTy8zn vagrant@ubuntu-xenial" >> /home/vagrant/.ssh/authorized_keys
echo " - END -"