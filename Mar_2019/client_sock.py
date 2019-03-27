import socket               # Import socket module

s = socket.socket()         # Create a socket object
host = '10.0.1.3' # Get machine name
port = 5000                 # Reserve a port for your service.

s.connect((host, port))
#s.send("Hello server!")
f = open('opaque.txt','rb')
#print('Sending...')
l = f.read(1024)
while (l):
    #print('Sending...')
    s.send(l)
    l = f.read(1024)
f.close()
print("Done Sending")
s.shutdown(socket.SHUT_WR)
print(s.recv(1024))
s.close                     #Close the socket when done
