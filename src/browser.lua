::labelhome::

-- config
port = 25565
dnsserver = "xxxxxxxx-xxxx" -- network card address, NOT case address

--import libs and initialise - DNT
component = require("component")
event = require("event")

modem = component.modem
gpu = component.gpu
data = component.data

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

-- functions - DNT

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
topbar("Home screen","ocbrowser")
print(" ")
print(" Welcome to OC-Browser.")
print(" ")
print(" Ctrl + L - Search")
print(" Ctrl + W - Exit")

gpu.set(2,22,"Using theme " .. themename)
gpu.set(2,24,"OC-Browser 1.1-sn1 / Made by daysant")

::labelinput::

-- get user input
if keyboard.isControlDown() then
    if keyboard.isKeyDown(keyboard.keys.w) then
        term.clear()
        os.exit()
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

-- get server address
modem.open(port)
printlog(" DNS port opened")
modem.send(dnsserver,port,search)
printlog(" Search query sent")
_,_,_,_,_,serveraddress,_ = event.pull("modem_message")
printlog(" DNS message received")
modem.close(port)
printlog(" DNS port closed")

:: labelloadpage ::
printlog(" Address is " .. serveraddress)

-- if server address is not found
if serveraddress == "error-not-found" then
    topbar("Error","ocbrowser")
    print(" ")
    print(" The webserver could not be found.")
    print(" Ensure you typed in the domain correctly.")
    print(" If it does not work, the server may be down or have moved.")
else
    -- request page content
    modem.open(port)
    printlog(" Webserver port opened")
    modem.send(serveraddress,port,"req-content")
    printlog(" Requested page content")
    _,_,_,_,_,compedpagecontent,_ = event.pull("modem_message")
    printlog(" Page content received")
    modem.close(port)
    printlog(" Webserver port closed")
    pagecontent = data.inflate(compedpagecontent)
    printlog(" Decompressed data")

    -- process content
    printlog(" Processing page content")

    --- NONE OF THIS IS MINE ---
    function split_string(input_string, separator)
        local separator_pattern = separator
        local result = {}
        local pattern = "(.-)" .. separator_pattern .. "()"
        local last_position = 1
        for part, position in input_string:gmatch(pattern) do
            if part ~= separator then
                table.insert(result, part)
            end
            last_position = positionx
        end
        local last_part = input_string:sub(last_position)
        if last_part ~= separator then
            table.insert(result, last_part)
        end
        return result
    end
    ---       endquote       ---

    finresult = split_string(pagecontent,"<br>")

    -- display page
    topbar("OC-Browser",search)
    for i, printtext in ipairs(finresult) do
        print(printtext)
    end

    -- get colour

end

goto labelinput