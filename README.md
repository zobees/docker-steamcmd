# zobees/steamcmd

A generic docker image for [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

## Features

 * Installs and updates Steam apps on container startup.
 * Drops privileges to a configurable UID and GID.

## Usage

 1. Set `STEAMCMD_APP_ID` to the Steam ID of the app you want to install.
 2. Set `USER_UID` and `USER_GID` to match the user on your host.
 2. Map `/data` to a volume.
 3. Map your ports as appropriate.
 4. Prefix the container command with `steamcmd-run`.

For example, to install and run a 7 Days to Die dedicated server:

``` sh
docker run -d -v $PWD/data:/data \
  -p 26900-26902:26900-26902 \
  -p 26900-26902:26900-26902/udp \
  -e STEAMCMD_APP_ID=294420 \
  -e USER_UID=1001 \
  -e USER_GID=1001 \
  zobees/steamcmd \
  steamcmd-run ./7DaysToDieServer.x86_64 \
    -logfile /dev/stdout \
    -configfile=serverconfig.xml \
    -quit \
    -batchmode \
    -nographics \
    -dedicated
```

## Authentication

If authentication is required, specify the username and password separated by a space via `STEAMCMD_LOGIN` (defaults to `anonymous`).

Note that SteamGuard is not yet supported, but is planned.

## Beta versions

Use the `STEAMCMD_BETA` environment variable to specify which beta version to install with the password specified by `STEAMCMD_BETA_PASSWORD` if required.

## Validation

By default steamcmd is instructed to validate installed files, which does incur a delay when starting a container. Set `STEAMCMD_NO_VALIDATE` to disable validation, though it's not generally advisable.

## Skipping update

If you're absolutely sure you want to skip running steamcmd after initial installation, you can set `STEAMCMD_SKIP` to do so. Note that you will need to run without this flag at least once in order to download the app in the first place.

## Known limitations

 * No support for SteamGuard, yet.
 * No support for `app_set_config`.
 * On Docker for Mac, the normal user does not have permission to use `/dev/stdout`. Seems to be a known Docker issue.

## Disclaimer

These containers are designed to be used by Zobees to host game servers for friends and family, and therefore may not suit all use cases.  That said, we are all for flexibility and would welcome pull requests and issues.
