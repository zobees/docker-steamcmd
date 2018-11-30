# zobees/steamcmd

A generic docker container for [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

## Usage

Install the app specified by `STEAMCMD_APP_ID` into the directory specified by `STEAMCMD_APP_DIR` (default: `/data`).

For example you could run a 7 Days to Die dedicated server with the following command:

```
docker run -d -v $PWD/data:/data \
  -p 26900-26902:26900-26902 \
  -p 26900-26902:26900-26902/udp \
  -e STEAMCMD_APP_ID=294420 \
  zobees/steamcmd \
  ./7DaysToDieServer.x86_64 -logfile /dev/stdout -configfile=serverconfig.xml -quit -batchmode -nographics -dedicated
```

In most cases you should be able to use `docker run` with no problems, however I recommended that instead you extend this image and add any app specific startup scripts, health checks and handle graceful shutdowns appropriately.

## Advanced

#### System user

Specify the user and group to run as via the `UID` and `GID` environment variables.

#### Authentication

If authentication is required, specify the username and password separated by a space via `STEAMCMD_LOGIN` (default: `anonymous`).

Note that SteamGuard is not yet supported, but is planned.

#### Beta versions

Use the `STEAMCMD_BETA` environment variable to specify which beta version to install with the password specified by `STEAMCMD_BETA_PASSWORD` if required.

#### Validation

By default steamcmd is instructed to validate on installation, which does incur a delay when starting a container. Set `STEAMCMD_NO_VALIDATE` to disable validation, though it's not generally advisable.

#### Other options

See the source code for this and its base image for more information:

 * [zobees/steamcmd](https://github.com/zobees/docker-steamcmd)
 * [zobees/steamcmd-base](https://github.com/zobees/docker-steamcmd-base)

## Known limitations

 * No support for SteamGuard, yet.
 * No support for `app_set_config`.

## Changes

### 0.2.1

 * Added `steamcmd-run` to automate steamcmd through environment variables.
 * Added ability to specify uid and gid.

### 0.1.1

 * Switch from Ubuntu 14.04 to 16.04
 * SteamCMD is now installed via apt, which means that the environment variable `STEAMCMD_DIR` is no longer required, and `$STEAMCMD_DIR/steamcmd.sh` command is now just `steamcmd`.
 * The image no longer creates a `steam` user, so you'll need to do this yourself if required.

## Disclaimer

These containers are designed to be used by Zobees to host game servers for friends and family, and therefore may not suit all use cases.  That said, we are all for flexibility and would welcome pull requests and issues.
