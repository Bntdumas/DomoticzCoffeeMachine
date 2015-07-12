local tcpService = {}

coffeeMachine = require("coffeeMachine")
print("tcpService V0.1")

-- The virtual sensor device that will contain the machine status
local domoticzDeviceID = 8

-- send the machine status
function tcpService.sendData()
    tmr.alarm(4, 2000, 1, function()
    socketTCP:send("GET /json.htm?type=command&param=udevice&idx="..domoticzDeviceID
               .."&nvalue=0&svalue="..coffeeMachine.statusStr().." HTTP/1.1\r\nHost: www.local.lan\r\n"
               .."Connection: keep-alive\r\nAccept: */*\r\n\r\n")
    end)
end

-- create a server to receive data (so we can use nc on linux from domoticz)
function tcpService.initServer()
    server = net.createServer(net.TCP, 30)
    server:listen(1717, function(socket) 
        socket:on("receive",function(socket, msg) 
            tcpService.parseMessage(msg)
        end)
    end)
end

-- parse the commands coming from Domoticz and execute them
function tcpService.parseMessage(msg)
    print(msg)
    if(msg == "turn_on\n") then
        print("detected turn on")
        coffeeMachine.turnON()
    elseif(msg == "turn_off\n") then
        coffeeMachine.turnOFF()
    elseif(msg == "small_coffee\n") then
        coffeeMachine.makeASmallCoffee()
    elseif(msg == "large_coffee\n") then
        coffeeMachine.makeALargeCoffee()
    end
end


return tcpService
