# oc-browser
Browsing software using in-game webservers.

## Installation
To install, run the following command on your terminal of choice.<br>
```wget https://raw.githubusercontent.com/daysantace/oc-browser/main/src/XXXXX.lua```
Replace `XXXXX` with your preferred module (i.e. if you want to install the browser, type `browser`). <br>

### System requirements
Ensure your system meets the requirements before installation.<br>

#### Browser and Webserver
* GPU - Tier 2
* Screen - Tier 2
* Network card - Wired or wireless
* Case - Tier 2
* OS - OpenOS

#### DNS Server
* GPU - Tier 1
* Screen - Tier 1
* Network card - Wired or wireless
* Case - Tier 1
* OS - OpenOS

### Setup
Software needs a bit of setup before it is usable.

#### Browser
Edit `browser.lua` to reflect the following:<br>
* Port (defaults to `25565`)
* DNS address
##### Themes
Additionally, you can have custom themes for your browser.<br>
See `/themes` for more info.

#### DNS Server
Edit `dns.lua` to reflect the following:
* Port (defaults to `25565`)
* List of all addresses to webservers (update regularly)

#### Webserver
Edit `webserver.lua` to reflect the following:
* Port (defaults to `25565`)
* Webpage text (should be in a seperate file)
