#!/bin/bash

umask 0002
chmod g+w /data

cd /data
export LD_LIBRARY_PATH=.

if [ $(id -u) = 0 ]; then
  if [[ -v SET_UID && "$SET_UID" != "0" ]]; then
    echo "Adjusting steam uid to $SET_UID"
    usermod -u $SET_UID steam
  fi

  if [[ -v SET_GID ]]; then
    echo "Adjusting steam gid to $SET_GID"
    groupmod -o -g $SET_GID steam
  fi

  if [[ -v SET_UID && $(stat -c "%u" /data) != $SET_UID ]]; then
    echo "Adjusting file permissions"
    chown -R steam:steam /data /home/steam
  fi

  echo "Running command as steam user"
  exec gosu steam:steam $@
fi

echo "Running command"
exec $@
