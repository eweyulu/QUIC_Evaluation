import socket               # Import socket module

s = socket.socket()         # Create a socket object
host = '10.0.1.3' # Get local machine name
port = 5000                 # Reserve a port for your service.
s.bind((host, port))        # Bind to the port
f = open('opaque.txt','wb')
s.listen(5)                 # Now wait for client connection.
while True:
    c, addr = s.accept()     # Establish connection with client.
    print('Connection from', addr)
    #print("Receiving...")
    l = c.recv(1024)
    while (l):
        #print("Receiving...")
        f.write(l)
        l = c.recv(1024)
    f.close()
    print("Done Receiving")
    s.shutdown(socket.SHUT_WR)
#    c.send('Thank you for connecting')
    c.close()                # Close the connection

