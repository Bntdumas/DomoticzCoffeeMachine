-- Starts the module and connect to server. 
print("Coffee machine Domoticz controller V0.1")

-- wifi connection config
-- 
wifi.setmode(wifi.STATION)
wifi.sta.config("JESUS","iletaitunefois")
local cfg =
{
    ip="192.168.0.56",
    netmask="255.255.255.0",
    gateway="192.168.0.1"
}    

-- connection to Domoticz server
local server_ip = "192.168.0.148"
local server_port = 8080

-- start the TCP client (that will receive commands from Domoticz)
socketTCP = net.createConnection(net.TCP, 0) 

--some global vars
tcpService = require("tcpService")
stringParsing = require("stringParsing")

-- Once we're connected to the Domoticz server, init the TCP server and start sending data
socketTCP:on("connection", function(cu)
    print("Connected.")
    tcpService.initServer()
    tcpService.sendData()
end)

-- check every 0.5seconds if we can get an ip, once we get it start the TCP client
tmr.alarm(0, 500, 1, function()
    gotIP = wifi.sta.setip(cfg)
    if ( wifi.sta.status() == 5 ) then
        socketTCP:connect(server_port, server_ip)
        tmr.stop(0)
    end
end)
