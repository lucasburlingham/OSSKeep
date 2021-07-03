CC=clang++
PORT=2062
SRC_FOLDER=src
BIN_FOLDER=bin
EXEC_NAME=OSSKeepserver
CHROMEIUM_RT=/usr/bin/vivaldi
CRX_NAME=$(EXEC_NAME).zip
EX_SRC_FOLDER=extension
CADDY_RT=structure/caddy_linux_amd64 --file-server

server: $(SRC_FOLDER)/server.cpp
	mkdir $(BIN_FOLDER)/
	$(CC) -std=c++11 -pthread -o $(BIN_FOLDER)/$(EXEC_NAME) $(SRC_FOLDER)/server.cpp

run: 
	websocketd --port=$(PORT) ./$(BIN_FOLDER)/$(EXEC_NAME) & $(CADDY_RT)

extensions: extension/
	zip -r $(CRX_NAME) $(EX_SRC_FOLDER)
	$(CHROMEIUM_RT) --pack-extension=$(CURDIR)/$(EX_SRC_FOLDER) --disable-gpu
	rm $(CRX_NAME)

clean: 
	rm -r $(BIN_FOLDER)
