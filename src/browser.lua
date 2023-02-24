-- config
local port = 25565

-- import libs and initialise
local component = require("component")
local event = require("event")

local modem = component.modem
local gpu = component.gpu
local colors = require("colors")

gpu.setResolution(80,25)
gpu.setDepth(2)

-- top bar
function topbar()
gpu.setBackground(colors.blue)
gpu.setForeground(colors.white)
gpu.fill(1,1,80,2," ")

gpu.set(1,1," " .. pagetitle)
gpu.set(1,2," " .. address)

gpu.set(70,2," ")
gpu.set(80,2," ")
gpu.setBackground(colors.gray)
gpu.setForeground(colors.silver)
gpu.fill(71,2,79,2," ")
gpu.set(72,2,"Search")

gpu.setBackground(colors.red)
gpu.setForeground(colors.white)
gpu.set(80,1,"X")
end
-- welcome screen
local pagetitle = "OC-Browser Welcome Screen"
local address = " "
topbar()