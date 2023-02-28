-- config
port = 25565
dnsserver = "xxxxxxxx-xxxx" -- network card address, NOT case address

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
gpu.setPaletteColor(colors.red,0xcc0000)
gpu.setPaletteColor(colors.green,0x00db00)
gpu.setPaletteColor(colors.yellow,0xffff00)
gpu.setPaletteColor(colors.magenta,0xff24c0)
gpu.setPaletteColor(colors.cyan,0x00b6ff)
gpu.setPaletteColor(colors.black,0x000000)
gpu.setPaletteColor(colors.gray,0x3c3c3c)
gpu.setPaletteColor(colors.silver,0xa5a5a5)
gpu.setPaletteColor(colors.white,0xffffff)

topbarcolor = colors.blue
textcolor = colors.white
logcolor = colors.gray
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

function printlog(str)
    gpu.setForeground(logcolor,true)
    print(str)
    gpu.setForeground(textcolor,true)
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
gpu.set(2,23,"Using theme " .. themename)
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
printlog(" DNS port opened")
modem.send(dnsserver,port,search)
printlog(" Search query sent")
_,_,_,_,_,_,serveraddress = event.pull("modem_message")
printlog(" DNS message received")
modem.close(port)
printlog(" DNS port closed")

:: labelloadpage ::
printlog(" Address is " .. serveraddress)

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
    printlog(" Webserver port opened")
    modem.send(serveraddress,port,"req-content")
    printlog(" Requested page content")
    _,_,_,_,_,_,pagecontent = event.pull("modem_message")
    printlog(" Page content received")
    modem.close(port)
    printlog(" Webserver port closed")
    -- process content - DNT
    printlog(" Processing page content")
end

goto labelinput