gpio.mode(1, gpio.OUTPUT) -- middle right
gpio.mode(2, gpio.OUTPUT) -- top left
gpio.mode(6, gpio.OUTPUT) -- top right
gpio.mode(7, gpio.OUTPUT) -- middle left

gpio.write(1, gpio.LOW)
gpio.write(2, gpio.LOW)
gpio.write(6, gpio.LOW)
gpio.write(7, gpio.LOW)

gpio.mode(5, gpio.INPUT) -- LED 
gpio.mode(0, gpio.INPUT) -- LED

require("main")
