# zobees/steamcmd

A generic docker container for [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD).

## Usage

Extends the [zobees/steamcmd-base](https://github.com/zobees/docker-steamcmd-base) image, providing a `steamcmd-run` wrapper command that:

 1. Installs or updates the app specified by `STEAMCMD_APP_ID` into the directory specified by `STEAMCMD_APP_DIR` (defaults to `/data`).
 2. Drops privileges to the specified `UID` and `GID` (both default to 0).
 3. Executes the rest of the command line verbatim.

In most cases you should be able to use the image as-is, however I highly recommended that instead you extend it and add any app specific startup scripts, health checks and handle graceful shutdowns appropriately.

## Example

Running a default 7 Days to Die dedicated server:

```
docker run -d -v $PWD/data:/data \
  -p 26900-26902:26900-26902 \
  -p 26900-26902:26900-26902/udp \
  -e STEAMCMD_APP_ID=294420 \
  zobees/steamcmd \
  steamcmd-run ./7DaysToDieServer.x86_64 -logfile /dev/stdout -configfile=serverconfig.xml -quit -batchmode -nographics -dedicated
```

## Advanced

#### Volumes

The image defines no specific volumes, however you probably want to at least mount `STEAMCMD_APP_DIR` (defaults to `/data`).

#### System user

Specify the user and group to run as via the `UID` and `GID` environment variables.

#### Authentication

If authentication is required, specify the username and password separated by a space via `STEAMCMD_LOGIN` (defaults to `anonymous`).

Note that SteamGuard is not yet supported, but is planned.

#### Beta versions

Use the `STEAMCMD_BETA` environment variable to specify which beta version to install with the password specified by `STEAMCMD_BETA_PASSWORD` if required.

#### Validation

By default steamcmd is instructed to validate on installation, which does incur a delay when starting a container. Set `STEAMCMD_NO_VALIDATE` to disable validation, though it's not generally advisable.

#### Skipping update

If you're absolutely sure you want to skip running steamcmd after initial installation, you can set `STEAMCMD_SKIP_UPDATE` to do so. Note that you will need to run without this flag at least once in order to download the app in the first place.

#### Other options

See the source code for this and its base image for more information:

 * [zobees/steamcmd](https://github.com/zobees/docker-steamcmd)
 * [zobees/steamcmd-base](https://github.com/zobees/docker-steamcmd-base)

## Known limitations

 * No support for SteamGuard, yet.
 * No support for `app_set_config`.

## Changes

### 0.3.5

 * Fix permissions on data volume.

### 0.3.4

 * Fixed issue preventing signals being trapped.

### 0.3.3

 * Fixed typo in entrypoint.

### 0.3.2

 * Updated entrypoint to allow one-off commands to bypass steamcmd and removed `STEAMCMD_APP_UPDATE` again.
 * Added `STEAMCMD_SKIP_UPDATE`.
 * Moved scripts to `/usr/local/bin/`.

### 0.3.1

 * Added `STEAMCMD_APP_UPDATE` to simplify one off commands on running containers.

### 0.2.1

 * Added `steamcmd-run` to automate steamcmd through environment variables.
 * Added ability to specify uid and gid.

### 0.1.1

 * Switch from Ubuntu 14.04 to 16.04
 * SteamCMD is now installed via apt, which means that the environment variable `STEAMCMD_DIR` is no longer required, and `$STEAMCMD_DIR/steamcmd.sh` command is now just `steamcmd`.
 * The image no longer creates a `steam` user, so you'll need to do this yourself if required.

## Disclaimer

These containers are designed to be used by Zobees to host game servers for friends and family, and therefore may not suit all use cases.  That said, we are all for flexibility and would welcome pull requests and issues.
