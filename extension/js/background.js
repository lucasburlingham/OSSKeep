var btn = document.createElement("p");
btn.innerHTML = "<button class=\"btn btn-primary\" style=\"width:100%;position:relative;z-index:2;color:#fff;background-color:#0d6efd;border-color:#0d6efd;border-radius:.25rem;padding-top:10px;padding-bottom:10px\" id=\"archive_page_1\">Archive Page</button>";
document.body.appendChild(btn);
document.getElementById("archive_page_1").textContent("Sent!");
document.getElementById("archive_page_1").addEventListener("click", function () {
    console.clear();
    var ws = new WebSocket("ws://localhost:2062/");
    console.log("Opening Heartbeat:");
    stats(ws);

    ws.onopen = function (event) {
        url = location.href;
        stats(ws);
        console.log("Socket Opened.");
        console.log("Archiving Page located at: " + url);
        ws.send(url);
        console.log("Archiving job sent to backend at: " + ws.url);
        console.log("Ending Heartbeat:");
        stats(ws);
        ws.onmessage = function (event) {
            console.log("Archive job done.");
            alert("Archive job done.");
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

});

function stats(ws) {

    console.log("Socket State: " + ws.readyState);

    if (ws.readyState == 1) {
        console.log("Socket State: Ready");
    } else {
        console.log("Socket State: Not Ready");
    }

    console.log("Socket Protocol: " + ws.protocol);
}