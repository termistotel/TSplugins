
import socket
import time

put = "/home/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura/network/"
MY_IP = "192.168.2.10"
UDP_PORT = 1667

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP

sock.bind((MY_IP, UDP_PORT))

while True:
    time.sleep(682.66666666/44100.0)
    data, addr = sock.recvfrom(4) # buffer size is 1024 bytes
    if data=="gief":	
    	f = open(put+"tmpZvuk", "r")
    	tmp = f.read()
    	f.close()
	sock.sendto(tmp,addr)
