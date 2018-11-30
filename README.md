# zobees/steamcmd

A generic docker base container for [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

## Overview

The `steamcmd` binary is installed in `/usr/games`, but is also symlinked to `/usr/bin/steamcmd` and therefore present in the default path.

## Changes

### 0.1.1

 * Switch from Ubuntu 14.04 to 16.04
 * SteamCMD is now installed via apt, which means that the environment variable `STEAMCMD_DIR` is no longer required, and `$STEAMCMD_DIR/steamcmd.sh` command is now just `steamcmd`.
 * The image no longer creates a `steam` user, so you'll need to do this yourself if required.

## Disclaimer

These containers are designed to be used by Zobees to host game servers for friends and family, and therefore may not suit all use cases.  That said, we are all for flexibility and would welcome pull requests and issues.
