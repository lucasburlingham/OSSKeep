function sendLocation() {
    chrome.tabs.query({
        currentWindow: true,
        active: true
    }, function (tabs) {
        console.log(tabs[0].url);
        alert(tabs[0].url)
    });
    console.clear();
    var ws = new WebSocket('ws://localhost:2062/');
    console.log('Opening Heartbeat:');
    stats(ws);

    ws.onopen = function (event) {
        stats(ws);
        console.log("Socket Opened.");
        console.log('Archiving Page located at: ' + tabs[0].url);
        console.log('Ending Heartbeat:');
        stats(ws);
        ws.send(tabs[0].url);
        console.log('Archiving job sent to node at: ' + ws.url);
        ws.onmessage = function (event) {
            console.log("Archive job done.");
            ws.onmessage = function (event) {
                console.log("Done.");
            }
        }
    }

    ws.onerror = function (event) {
        console.log("Socket error.");
        stats(ws);
    }

    ws.onclose = function (event) {
        console.log("Socket Closed.");
        stats(ws);
    }

}

function stats(ws) {

    console.log("Socket State: " + ws.readyState);

    if (ws.readyState == 1) {
        console.log("Socket State: Ready");
    } else {
        console.log("Socket State: Not Ready");
    }

    console.log("Socket Protocol: " + ws.protocol);
}