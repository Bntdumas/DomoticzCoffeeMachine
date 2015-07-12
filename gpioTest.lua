function redON() 
    return gpio.read(5) == 1
end

function greenON() 
    return gpio.read(0) == 1
end

-- return screen's backlight based on the LEDs status.
function color()
    if greenON() and redON() then
        return "yellow"
    elseif greenON() then
        return "green"
    elseif redON()  then
        return "red"
    else 
        return "off"
    end
end

print("color: "..color())
