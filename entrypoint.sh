#!/bin/sh

if [ -z "$SPLATNET2STATINK_CONFIG" ]; then
  printf "[!] The environment variable SPLATNET2STATINK_CONFIG is missing, so the program will interact you to know the credentials.\n\n"
fi

echo $SPLATNET2STATINK_CONFIG > config.txt

exec "$@"
