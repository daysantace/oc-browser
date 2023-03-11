-- config
port = 25565

-- libs and init - DNT
component = require("component")
event = require("event")
term = require("term")
os = require("os")

modem = component.modem
data = component.data

print("OC-Browser Webserver 1.1-sn1 / Made by daysant")
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

    compednetmsg = data.deflate(netmsg)
    print("Data compressed")
    modem.send(sender,port,compednetmsg)
    print("Message sent")

    -- load foreground colours
    print("Loading foreground colour map")
    cmap = {}
    for line in io.lines("/home/fcmap.txt")
        t = {}
        for i = 1, #line do
            t[i] = line:sub(i, i)
        end
        table.insert(cmap,t)
    end
    fcmapserialised = serialization.serialize(cmap)

    -- load background colours
    print("Loading foreground colour map")
    cmap = {}
    for line in io.lines("/home/bcmap.txt")
        t = {}
        for i = 1, #line do
            t[i] = line:sub(i, i)
        end
        table.insert(cmap,t)
    end
    bcmapserialised = serialization.serialize(cmap)

    -- send serialised and then reset colour maps
    modem.send(sender,port,fcmapserialised)
    modem.send(sender,port,bcmapserialised)

    fcmapserialised = nil
    bcmapserialised = nil
    cmap = nil
end