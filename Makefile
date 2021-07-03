CC=clang++
PORT=2062

server: server.cpp
	$(CC) -std=c++11 -pthread -o OSSKeepserver server.cpp

run: 
	websocketd --port=$(PORT) ./OSSKeepserver
