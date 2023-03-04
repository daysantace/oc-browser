# oc-browser
Browsing software using in-game webservers.

## Installation
To install, run the following command on your terminal of choice.<br>
```wget https://raw.githubusercontent.com/daysantace/oc-browser/main/src/XXXXX.lua```
Replace `XXXXX` with your preferred module (i.e. if you want to install the browser, type `browser`). <br>
Alternatively, you can use a physical medium (like a floppy disk) with the code written on it, or copy and paste the code manually.

### System requirements
Ensure your system meets the requirements before installation.<br>

| Program | Browser | Webserver | DNS Server |
|---|---|---|---|
| CPU | Tier 2 | Tier 1 | Tier 1 |
| GPU | Tier 2 | Tier 1 | Tier 1 |
| Network | Wired | Wired | Wired |
| Data card | Tier 1 | Tier 1 | Not needed |
| Screen | Tier 2 | Tier 1 | Tier 1 |
### Setup
Software needs a bit of setup before it is usable.

#### Browser
Edit `browser.lua` to reflect the following:<br>
* Port (defaults to `25565`)
* DNS address
* Theme (go to `/themes` for info)
#### DNS Server
Edit `dns.lua` to reflect the following:
* Port (defaults to `25565`)
* List of all addresses to webservers (update regularly)

#### Webserver
Edit `webserver.lua` to reflect the following:
* Port (defaults to `25565`)
* Webpage text (should be in a seperate file named `page.txt`)
* `<br>` is webpage markup for line break


### Customisation
You can easily customise parts of OC-Browser to fit your needs.<br>
To customise OC-Browser and its modules, simply go to the terminal and type `edit XXXXXX.lua`, with `XXXXXX` being the name of your module.<br>
**NOTE** - Some areas of code are marked with `DNT` in their code comment. This stands for Do Not Touch. Try avoiding areas marked with `DNT` whenever possible. Areas marked without `DNT` but are within a larger `DNT` area should not be touched either, unless specified otherwise.

#### Browser
In the browser you can customise your theme colours, home page, and shortcuts.

## To-do
Here is a full list of all planned features to be added in OC-Browser.<br>
This list is not marked by order of priority.

- [x] Basic networking
- [x] Themes
- [ ] Compression
- [ ] Colour support
- [ ] Hyperlink support
- [ ] Multiple pages on one server
- [ ] Cross-platform (MineOS, Plan9k) support
- [ ] Automatic updates
- [ ] Encrypted requests
- [ ] Page titles