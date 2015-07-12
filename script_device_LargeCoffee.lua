commandArray = {}

DomDevice = 'LargeCoffee'
IP = '192.168.0.56'
Port = '1717'
print("Large coffee script")
 
function send(msg) 
   runcommand = "echo "..msg .."| nc "..IP.." "..Port.." "
   print (runcommand)
   os.execute(runcommand)
end

if devicechanged[DomDevice] then
    print("Making a large coffee")
    send("large_coffee") 
end
 
return commandArray
