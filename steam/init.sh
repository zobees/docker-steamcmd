#!/usr/bin/env bash

set -e

steamcmd="$STEAMCMD_DIR/steamcmd.sh"

if [ -n "$SKIP_INSTALL" ]; then
  echo "Skipping SteamCMD install as requested by SKIP_INSTALL."
else
  if [ -x "$steamcmd" ] then
    echo "SteamCMD already present in $STEAMCMD_DIR, skipping install."
  else
    echo "Installing SteamCMD in $STEAMCMD_DIR.."
    mkdir -p "$STEAMCMD_DIR" && curl -s "$STEAMCMD_URL" | tar -v -C "$STEAMCMD_DIR" -zx
  fi
fi

if [ -n "$SKIP_SETUP" ]; then
  echo "Skipping SteamCMD setup as requested by SKIP_SETUP."
else
  if [ -z "$STEAM_APP_ID" ]; then
    echo "ERROR: no STEAM_APP_ID specified!"
    exit 1
  fi

  echo "Setting up.."
  $steamcmd +runscript $STEAMCMD_ARGS +quit
fi

if [ -z "$STEAM_CMD" ]; then
  echo "Nothing left to do, no STEAMCMD_CMD specified."
else
  exec $STEAM_CMD
fi
