commandArray = {}

DomDevice = 'SmallCoffee'
IP = '192.168.0.56'
Port = '1717'
print("Small coffee script")
 
function send(msg) 
   runcommand = "echo "..msg .."| nc "..IP.." "..Port.." "
   print (runcommand)
   os.execute(runcommand)
end

if devicechanged[DomDevice] then
    print("Making a small coffee")
    send("small_coffee") 
end
 
return commandArray
