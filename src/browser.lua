-- config
port = 25565
dnsserver = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"-- address goes here

--import libs and initialise - DNT
component = require("component")
event = require("event")

modem = component.modem
gpu = component.gpu
colors = require("colors")
keyboard = require("keyboard")
term = require("term")

gpu.setResolution(80,25)
term.setCursorBlink(false)

-- theme
themename = "Default Dark"
gpu.setPaletteColor(colors.blue,0x3349c0)
gpu.setPaletteColor(colors.black,0x000000)
gpu.setPaletteColor(colors.white,0xffffff)

topbarcolor = colors.blue
textcolor = colors.white
bgcolor = colors.black

-- define top bar - DNT

function topbar(pagetitle,pageaddress)
    term.clear()
    gpu.setBackground(topbarcolor,true)
    gpu.setForeground(textcolor,true)
    gpu.fill(1,1,80,2," ")
    gpu.set(1,1," " .. pagetitle)
    gpu.set(1,2," " .. pageaddress)
    gpu.setBackground(bgcolor,true)
    term.setCursor(1,3)
    return
end

-- welcome screen
::labelhome::
topbar("Home screen","ocbrowser")
print(" ")
print(" Welcome to OC-Browser.")
print(" ")
print(" Ctrl + L - Search")
print(" Ctrl + W - Exit")
print(" Ctrl + R - Refresh")
print(" Ctrl + N - Home page")
print(" ")
gpu.set(2,24,"OC-Browser Beta / Made by daysant")

::labelinput::

-- get user input
if keyboard.isControlDown() then
    if keyboard.isKeyDown(keyboard.keys.n) then
        goto labelhome
    end
    if keyboard.isKeyDown(keyboard.keys.w) then
        term.clear()
        os.exit()
    end
    if keyboard.isKeyDown(keyboard.keys.r) then
        goto labelloadpage
    end
    if keyboard.isKeyDown(keyboard.keys.l) then
        goto labelsearch
    end
end

os.sleep(0.1)

goto labelinput
-- search - DNT
:: labelsearch ::

topbar("Search","ocbrowser")
print(" ")
print(" Search")
print(" ")
search = io.read()
print(" ")

-- get server address - DNT
modem.open(port)
print(" Port opened")
modem.send(dnsserver,port,"search-" .. search)
print(" Search query sent")
_,_,_,_,_,serveraddress = event.pull("modem_message")
print(" DNS message received")
modem.close(port)
print(" Port closed")

:: labelloadpage ::

-- if server address is not found - DNT
if serveraddress == "error-not-found" then
    topbar("Error","ocbrowser")
    print(" ")
    print(" The server address could not be found.")
    print(" Ensure you typed in the address correctly.")
    print(" If it does not work, the server may be down or have moved.")
else
    -- request page content - DNT
    modem.open(port)
    print(" Webserver port opened")
    modem.send(serveraddress,port,"req-content")
    print(" Requested page content")
    _,_,_,_,_,pagecontent = event.pull("modem_message")
    print(" Page content received")
    modem.close(port)
    print(" Webserver port closed")
    -- process content - DNT
    print(" Processing page content")
end

goto labelinput