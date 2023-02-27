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
domains = {"domain"}
addresses = {"address"}
--[[
    the ones given here are examples, delete once used
    the two lists correspond, i.e. domain no. 4 will mean the 4th index
    used in both domains and addresses
--]]

domainlistlen = 1 -- make this value the number of registered domains or it won't work
-- network to the browser - DNT
print("DNS list loaded")
while true do
    print("Main loop started")
    ::labelnetstart::
    modem.open(port)
    print("Port opened")
    _,_,sender,_,_,_,message = event.pull("modem_message")
    print("Message from " .. sender .. " received")
    print("Request for " .. message)
    print("Search database for " .. sender .. " complete")

    for i, v in ipairs(domains) do -- courtesy of chatgpt
        if v == message then
            sendaddr = addresses[i]
            goto loopesc
        end
    end
    modem.send(sender,port,"error-not-found")

    goto labelnetstart

    ::loopesc::
    modem.send(sender,port,sendaddr)

    goto labelnetstart

    ::labelerrnotfound::
    modem.send(sender,port,"error-not-found")
    print("Error message sent back to " .. sender)
    os.sleep(0.1)
end