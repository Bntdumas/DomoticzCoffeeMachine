commandArray = {}

DomDevice = 'CoffeeMachine'
IP = '192.168.0.56'
Port = '1717'

print("Coffee machine power script")

 
function send(msg) 
   runcommand = "echo "..msg .."| nc "..IP.." "..Port.." "
   print (runcommand)
   os.execute(runcommand)
end

if devicechanged[DomDevice] then
    if(devicechanged[DomDevice]=='Off') then 
        print("Turning the coffee machine OFF")
        send("turn_off") 
    elseif (devicechanged[DomDevice]=='On') then
        print("Turning the coffee machine On")
        send("turn_on") 
    else
        print(devicechanged[DomDevice].." is neither ON or OFF") 
    end
end
 
return commandArray
