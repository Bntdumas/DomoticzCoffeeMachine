local coffeeMachine = {}

print("coffeeMachine V0.03")

local pinTopLeftButton = 2 --small coffee
local pinMiddleLeftButton = 7 --large coffee
local pinTopRightButton = 6 -- power
local pinMiddleRightButton = 1 --strength

local pinRedLed = 5
local pinGreenLed = 0

-- returns true if the red LED is on
function coffeeMachine.redON() 
    return gpio.read(pinRedLed) == 1
end

-- returns true if the green LED is on
function coffeeMachine.greenON() 
    return gpio.read(pinGreenLed) == 1
end

-- returns a human readable string of the screen color
function coffeeMachine.colorStr()
    if coffeeMachine.greenON() and coffeeMachine.redON() then
        return "yellow"
    elseif coffeeMachine.greenON() then
        return "green"
    elseif coffeeMachine.redON() then
        return "red"
    else
        return "off"
    end
end

-- returns a human readable string of the machine status
function coffeeMachine.statusStr()
    if coffeeMachine.greenON() and coffeeMachine.redON() then
        return "warning"
    elseif coffeeMachine.greenON() then
        return "ready"
    elseif coffeeMachine.redON() then
        return "error"
    else
        return "off"
    end
end

-- returns true if the machine is on
function coffeeMachine.isON()
    return coffeeMachine.colorStr() ~= "off"
end

-- turns the machine on 
-- if the machine is already on, do nothing
function coffeeMachine.turnON()
    print("turning it ON")
    if not coffeeMachine.isON() then
        coffeeMachine.pushButton(pinTopRightButton) --turn machine ON
        coffeeMachine.tryStopRinse()
    end
end

-- turns the machine off 
-- if the machine is already off, do nothing
function coffeeMachine.turnOFF()
    print("turning it OFF")
    if coffeeMachine.isON() then
        coffeeMachine.pushButton(pinTopRightButton) --turn machine OFF
        coffeeMachine.tryStopRinse()
    end
end

-- Try to interrupt the rinsing cycle
function coffeeMachine.tryStopRinse()
    print("tryStopRinse")
    -- after one minute, stop clicking, there's something wrong...
    tmr.alarm(1, 40000, 0, function()
        tmr.stop(2)
    end)
    tmr.alarm(2, 1500, 1, function()
        -- every 0.5s, try pushing the button stop if the screen
        -- color is still yellow
        if coffeeMachine.colorStr() == "yellow" then
            coffeeMachine.pushButton(pinTopLeftButton)
        elseif coffeeMachine.colorStr() == "green" or
                coffeeMachine.colorStr() == "red" then
            tmr.stop(2)
        end
    end)
end

-- make a small coffee
function coffeeMachine.makeASmallCoffee()
    print("makeASmallCoffee")
    coffeeMachine.pushButton(pinTopLeftButton)
end

-- make a large coffee
function coffeeMachine.makeALargeCoffee()
    print("makeALargeCoffee")
    coffeeMachine.pushButton(pinMiddleLeftButton)
end

-- Brief (300ms) push on a button identified by it's pin
function coffeeMachine.pushButton(pin)
    gpio.write(pin, gpio.HIGH)
    tmr.alarm(3, 300, 0, function()
        gpio.write(pin, gpio.LOW)
    end)
end


return coffeeMachine
