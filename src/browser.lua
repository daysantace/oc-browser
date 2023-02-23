-- config
port = 25565

-- import libs and initialise
local component = require("component")
local event = require("event")

local modem = component.modem
local gpu = component.gpu
local colors = require("colors")

gpu.setResolution(80,25)
gpu.setDepth(2)

-- welcome screen
gpu.setBackground(colors.blue)
gpu.setForeground(colors.white)

gpu.fill(1,1,80,2," ")
gpu.set(1,1," OC-Browser welcome screen")