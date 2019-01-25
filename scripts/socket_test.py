#!/usr/bin/env python3

import socket

HOST = '127.0.0.1'  # Standard loopback interface address (localhost)
PORT = 65400        # Port to listen on (non-privileged ports are > 1023)

    s = (socket.socket(socket.AF_INET, socket.SOCK_DGRAM))
    s.setsockopt(socket.SOL_SOCKET, IN.SO_BINDTODEVICE, "enp132s0f1np1"+'\0')
    s.bind((HOST, PORT))
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(1024)
            if not data:
                break
            conn.sendall(data)
