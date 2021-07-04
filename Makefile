CC=clang++
PORT=2062
SRC_FOLDER=src
BIN_FOLDER=bin
SRV_PATH=bin/OSSKeepserver
RAN_EXEC=bin/ran_linux_amd64
WS_PATH=bin/websocketd
CHROMEIUM_RT=vivaldi 
EX_SRC_FOLDER=extension

server: $(SRC_FOLDER)/server.cpp
	$(CC) -std=c++11 -pthread -o $(SRV_PATH) $(SRC_FOLDER)/server.cpp

run:
	killall websocketd &
	killall ran_linux_amd64 &
	sudo $(RAN_EXEC) -port 80 -root cache/www &
	$(WS_PATH) --port=$(PORT) $(SRV_PATH) --loglevel=error &

stop: 
	sudo killall websocketd &
	sudo killall ran_linux_amd64

extensions: extension/
	$(CHROMEIUM_RT) --pack-extension=extension --no-message-box --disable-gpu

clean: 
	rm bin/OSSKeepserver

clearcache: cache/www/
	rm -r cache/www/*
