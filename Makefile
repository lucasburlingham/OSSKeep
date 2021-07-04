CC=clang++
PORT=2062
SRC_FOLDER=src
BIN_FOLDER=bin
EXEC_NAME=OSSKeepserver
CHROMEIUM_RT=vivaldi --pack-extension=extension --no-message-box --disable-gpu
CRX_NAME=$(EXEC_NAME).zip
EX_SRC_FOLDER=extension
SUBDIRS:=cache

server: $(SRC_FOLDER)/server.cpp
	$(CC) -std=c++11 -pthread -o $(BIN_FOLDER)/$(EXEC_NAME) $(SRC_FOLDER)/server.cpp

run:
	killall websocketd &
	killall ran_linux_amd64 &
	websocketd --port=$(PORT) ./$(BIN_FOLDER)/$(EXEC_NAME) &
	sudo cache/ran_linux_amd64 -port 80 -root cache/www

stop: 
	sudo killall websocketd &
	sudo killall caddy_linux_amd64

extensions: extension/
	$(CHROMEIUM_RT) --pack-extension=extension --no-message-box

clean: 
	rm bin/OSSKeepserver

clearcache: cache/www/
	rm -r cache/www/*
