#!/bin/bash

umask 0002
chmod g+w /data

cd /data
export LD_LIBRARY_PATH=.

if [ $(id -u) = 0 ]; then
  if [[ -v USER_UID && "$USER_UID" != "0" ]]; then
    echo "Adjusting steam uid to $USER_UID"
    usermod -u $USER_UID steam
  fi

  if [[ -v USER_GID ]]; then
    echo "Adjusting steam gid to $USER_GID"
    groupmod -o -g $USER_GID steam
  fi

  if [[ -v USER_UID && $(stat -c "%u" /data) != $USER_UID ]]; then
    echo "Adjusting file permissions"
    chown -R steam:steam /data /home/steam
  fi

  echo "Running command as steam user"
  set -- gosu steam:steam "$@"
fi

echo "Running $@"
exec "$@"
