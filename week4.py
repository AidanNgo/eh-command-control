import socket
import subprocess
import os

# --- Configuration ---
# Setting HOST to "0.0.0.0" allows it to listen on all available interfaces
HOST = "0.0.0.0" 
PORT = 8000
PASSWORD = "aidannidhi" # Requirement: Authentication

def run_server():
    # Create the socket
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    
    try:
        s.bind((HOST, PORT))
        s.listen(5) # Allow a small queue of connections
        
        while True:
            # The OUTER loop: This keeps the script running after you disconnect
            conn, addr = s.accept()
            
            try:
                # 1. Authentication Handshake
                # We ask the client for the password immediately
                conn.send(b"AUTH_REQUIRED")
                received_pass = conn.recv(1024).decode().strip()
                
                if received_pass != PASSWORD:
                    conn.send(b"Access Denied. Closing connection.")
                    conn.close()
                    continue # Go back to waiting for a new connection
                
                conn.send(b"AUTH_SUCCESS")

                # 2. Command Execution Loop
                # The INNER loop: Handles the actual session
                while True:
                    command = conn.recv(1024).decode()

                    if not command or command.lower() in ["exit", "quit"]:
                        break
                    
                    # Execute command and capture BOTH stdout and stderr
                    # shell=True allows for piping and redirects (e.g., 'ls | grep txt')
                    process = subprocess.Popen(
                        command,
                        shell=True,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.PIPE,
                        stdin=subprocess.PIPE
                    )

                    stdout, stderr = process.communicate()
                    
                    # Combine output and errors to send back
                    response = stdout + stderr
                    
                    if not response:
                        response = b"Command executed (no output)."

                    conn.send(response)

            except Exception as e:
                # Log error internally or just pass to keep the server alive
                pass
            finally:
                conn.close() # Close the individual connection, but keep the server up

    except Exception as e:
        pass
    finally:
        s.close()

if __name__ == "__main__":
    run_server()
