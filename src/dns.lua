-- config
port = 25565

-- libs and init - DNT
component = require("component")
event = require("event")
term = require("term")
os = require("os")

modem = component.modem
print("DNS Server Beta / Made by daysant")
print(" ")

-- list of servers
d1 = {"domain","webserver-address"} -- example, delete once webservers are up

-- network to the browser - DNT
print("DNS list loaded")
while true do
    ::labelnetstart::
    print("Main loop started")
    modem.open(port)
    print("Port opened")
    _,_,sender,_,_,message = event.pull("modem_message")
    print("Message from " .. sender " received")
    if string.sub(message,1,7) == "search-" then
        req_address = string.sub(message,7,string.len(message))
    end
    print("Request from " .. sender .. " complete")

    i = 1
    while _G[v][1] ~= req_address do -- credit to allister on stackoverflow
        local v = "d" .. tostring(i)
        checkaddr = (_G[v][1])
        i=i+1
        if v == nil then
            goto labelerrnotfound
        end
    end
    print("Search database for " .. sender .. " complete")

    sendaddr = _G[v][2]
    modem.send(sender,port,sendaddr)

    goto labelnetstart

    ::labelerrnotfound::
    modem.send(sender,port,"error-not-found")
    print("Error message sent back to " .. sender)
    os.sleep(0.1)
end