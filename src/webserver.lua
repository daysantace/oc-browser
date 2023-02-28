-- config
port = 25565

-- libs and init - DNT
component = require("component")
event = require("event")
term = require("term")
os = require("os")

modem = component.modem

print("Webserver Beta / Made by daysant")
print(" ")
print("Main loop started")
modem.open(port)
print("Port opened")

-- networking - DNT
while true do
    _,_,sender,_,_,_,_ = event.pull("modem_message")
    print("Received request for " .. sender)
    netmsg = ""

    -- compound each line of page file to netmsg
    for line in io.lines("/home/page.txt") do
        netmsg = netmsg .. line
    end
    print("File loaded")

    modem.send(sender,port,netmsg)
end