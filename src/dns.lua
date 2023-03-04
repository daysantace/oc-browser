-- config
port = 25565

-- libs and init - DNT
component = require("component")
event = require("event")
term = require("term")
os = require("os")

modem = component.modem
print("OC-Browser DNS Server 1.0 / Made by daysant")
print(" ")

-- list of servers
domains = {"domain"}
addresses = {"address"}
--[[
    the ones given here are examples, delete once used
    the two lists correspond, i.e. domain no. 4 will mean the 4th index
    used in both domains and addresses

    remember to put the address of the network card, not the case
--]]

-- network to the browser - DNT
print("DNS list loaded")
while true do
    print("Main loop started")
    ::labelnetstart::
    modem.open(port)
    print("Port opened")
    _,_,sender,_,_,message,_ = event.pull("modem_message")
    print("Message from " .. sender .. " received")
    print("Request for " .. message)
    print("Search database for " .. sender .. " complete")

    -- find what index domain is at
    for i, v in ipairs(domains) do -- courtesy of chatgpt
        if v == message then
            sendaddr = addresses[i]
            goto loopesc
        end
    end

    -- domain not found
    modem.send(sender,port,"error-not-found")

    goto labelnetstart
    ::loopesc::

    -- domain in fact found
    modem.send(sender,port,sendaddr)
    goto labelnetstart

    -- cont. domain not found
    ::labelerrnotfound::
    modem.send(sender,port,"error-not-found")
    print("Error message sent back to " .. sender)

    os.sleep(0.1) -- program crashes when this is removed and idk why
end
