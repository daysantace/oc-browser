-- config
port = 25565
dnsserver = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"-- address goes here

-- theme
topbarcolor = colors.blue
textcolor = colors.white
bgcolor = colors.black

gpu.setPalleteColor(colors.blue,0x3324c0)
gpu.setPalleteColor(colors.black,0x000000)
gpu.setPalleteColor(colors.white,0xffffff)

--import libs and initialise
component = require("component")
event = require("event")

modem = component.modem
gpu = component.gpu
colors = require("colors")
keyboard = require("keyboard")
term = require("term")

gpu.setResolution(80,25)
pagetitle = "OC-Browser Home Screen"
pageaddress = "ocbrowser"
term.setCursorBlink(false)

-- welcome screen
::labelhome::

term.clear()
gpu.setBackground(topbarcolor,true)
gpu.setForeground(textcolor,true)
gpu.fill(1,1,80,2," ")
gpu.set(1,1," " .. pagetitle)
gpu.set(1,2," " .. pageaddress)
gpu.setBackground(bgcolor,true)
term.setCursor(1,3)
print(" ")
print(" Welcome to OC-Browser.")
print(" ")
print(" Ctrl + L - Search")
print(" Ctrl + W - Exit")
print(" Ctrl + R - Refresh")
print(" Ctrl + N - Home page")
gpu.set(2,24,"OC-Browser 1.0 / Made by daysant")

::labelinput::

-- get user input
if keyboard.isControlDown() then
    if keyboard.isKeyDown("H") then
        goto labelhome
    end
    if keyboard.isKeyDown("W") then
        gpu.fill(1, 1, 80, 25, " ")
        os.exit()
    end
    if keyboard.isKeyDown("R") then
        goto labelloadpage
    end
    if keyboard.isKeyDown("L") then
        goto labelsearch
    end
end

os.sleep(0.1)

goto labelinput
-- search
:: labelsearch ::

term.clear()
gpu.setBackground(topbarcolor,true)
gpu.setForeground(textcolor,true)
gpu.fill(1,1,80,2," ")
gpu.set(1,1," Search")
gpu.set(1,2," ocbrowser")
gpu.setBackground(bgcolor,true)
term.setCursor(1,3)
print(" ")
print(" Search")
print(" ")
search = io.read()

-- get server address
modem.open(port)
modem.send(dnsserver,port,"search-" .. search)
_,_,_,_,_,serveraddress = event.pull("modem_message")
modem.close(port)

:: labelloadpage ::

-- if server address is not found
if serveraddress == "error-not-found" then
    term.clear()
    gpu.setBackground(topbarcolor,true)
    gpu.setForeground(textcolor,true)
    gpu.fill(1,1,80,2," ")
    gpu.set(1,1," Error - Domain not found")
    gpu.set(1,2," ocbrowser")
    gpu.setBackground(bgcolor,true)
    term.setCursor(1,3)
    print(" ")
    print(" The server address could not be found.")
    print(" Ensure you typed in the address correctly.")
    print(" If it does not work, the server may be down or have moved.")
else
    -- request page content
    modem.open(port)
    modem.send(serveraddress,port,"req-content")
    _,_,_,_,_,pagecontent = event.pull("modem_message")
    modem.close(port)
    -- process content
end

goto labelinput