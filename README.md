# steamcmd

A docker container for Steam based game servers via [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

**Currently in development and not suitable for general use.  Feel free to play with it, but do so entirely at your own risk.**

## Environment variables

### Steam

**STEAM_APP_ID** (required unless `STEAMCMD_ARGS` is specified)
The ID of the Steam app you wish to install, which you can search for [here](http://steamdb.info).  Has no effect if `STEAMCMD_ARGS` is specified.

**STEAM_APP_CMD** (required)
The command to run the Steam app.  E.g. `/steam/app/some-ded-server --some-option`.  This must be `exec`-able in order to ensure signals propagate (and therefore the container can shut down gracefully).

**STEAM_USERNAME** (optional)
The Steam username to authenticate with in order to install Steam apps that require it.

**STEAM_PASSWORD** (optional)
The Steam password to authenticate with in order to install Steam apps that require it.

**STEAM_APP_DIR** (optional)
The path at which to install the Steam app.  Has no effect if `STEAMCMD_ARGS` is specified.

### SteamCMD

**STEAMCMD_URL** (optional)
The URL from which to fetch SteamCMD.  The default, as documented [here](https://developer.valvesoftware.com/wiki/SteamCMD#Linux) is `https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz`.

**STEAMCMD_DIR** (optional)
The path at which to install SteamCMD.  The default is `/steam/steamcmd`.

**STEAMCMD_ARGS** (optional)
The arguments to pass to `steamcmd`.  This will completely override `STEAM_APP_ID` and `STEAM_APP_DIR` and you will need to tell SteamCMD which app you wish to install and where you wish it to be installed, as documented [here](https://developer.valvesoftware.com/wiki/SteamCMD#Downloading_an_app).

## Disclaimer

These containers are designed to be used by Zobees to host game servers for friends and family, and therefore may not suit all use cases.  That said, we are all for flexibility and would welcome pull requests and issues.
