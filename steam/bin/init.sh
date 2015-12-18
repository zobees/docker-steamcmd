#!/usr/bin/env bash

set -e

steamcmd="$STEAMCMD_DIR/steamcmd.sh"

if [ -n "$SKIP_INSTALL" ]; then
  echo "Not installing SteamCMD as requested by SKIP_INSTALL."
else
  if [ -x "$steamcmd" ]; then
    echo "SteamCMD already present in $STEAMCMD_DIR, skipping install."
  else
    echo "Installing SteamCMD in $STEAMCMD_DIR.."
    mkdir -p "$STEAMCMD_DIR" && curl -s "$STEAMCMD_URL" | tar -v -C "$STEAMCMD_DIR" -zx
  fi
fi

if [ -n "$SKIP_SETUP" ]; then
  echo "Not running SteamCMD as requested by SKIP_SETUP."
else
  if [ -n "$STEAM_APP_ID" ]; then
    if [ -n "$STEAM_USERNAME" ]; then
      STEAMCMD_ARGS="+login $STEAM_USERNAME $STEAM_PASSWORD "
    fi

    STEAMCMD_ARGS+="+force_install_dir $STEAM_APP_DIR +app_update $STEAM_APP_ID "
  fi

  if [ -z "$STEAMCMD_ARGS" ]; then
    echo "ERROR: no STEAM_APP_ID or STEAMCMD_ARGS specified!"
    exit 1
  fi

  echo "Running SteamCMD.."
  $steamcmd $STEAMCMD_ARGS +quit
fi

if [ -z "$STEAM_APP_CMD" ]; then
  echo "Nothing left to do, no STEAM_APP_CMD specified."
else
  exec $STEAM_APP_CMD
fi
