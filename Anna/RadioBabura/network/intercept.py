import select
import time
import socket
import sys
#from multiprocessing import Process, Lock
from threading import Thread, Lock

#class sockThread(Thread):

sock = socket.socket(socket.AF_INET, # Internet
                     socket.SOCK_DGRAM) # UDP
sock.bind(("192.168.2.10",1667))

slusajFlag = True
sessions = {}
#sessions['192.168.2.101'] = 2
bufer = 1024
lock = Lock()

put = "/home/tsbot/TeamSpeak3-Client-linux_amd64/plugins/lua_plugin/Anna/RadioBabura/network/"

def zapisiFajl(loc,mod,str):
    f = open(loc,mod)
    f.write(str)
    f.close()

def slusaj():
    global sessions
    global sock
    global slusajFlag
    while slusajFlag:
        i, o, e = select.select( [sock], [], [], 1 )
        if (i):
		data, addr = sock.recvfrom(4)
		with lock:
			sessions[addr[0]] = addr[1]
    sock.close()    


slusanje = Thread(target=slusaj)
slusanje.start()


try:
	paket = sys.stdin.read(bufer)
	while paket:
		with lock:
			for i in sessions:
				sock.sendto(paket,(i,sessions[i]))
		sys.stdout.write(paket)

		i, o, e = select.select( [sys.stdin], [], [], 2 )

		if (i):
			paket=sys.stdin.read(bufer)
		else:
			sys.exit()
except:
	sock.close()
#	slusanje.terminate()
#	sock.close()
slusajFlag=False
sys.exit()
