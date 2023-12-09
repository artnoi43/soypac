#!/bin/sh

# sign.sh - signs pacman packages (.pkg.tar.zst files) in ARCH_DIR (defaults to x86_64)
# TODO: Use passphrase-fd flag

[ -z $1 ]\
  && printf "sign.sh: passphrase required\nUsage: sign.sh [ARCH_DIR] <PASSPHRASE>"\
  && exit 1;

if [ -z $2 ]; then
  ARCH_DIR="x86_64";
  PASSPHRASE=$1;
else
  ARCH_DIR=$1;
  PASSPHRASE=$2;
fi;

for f in "$ARCH_DIR"/*.pkg.tar.zst; do
  gpg --detach-sign --pinentry-mode loopback --passphrase "$PASSPHRASE" --output "$f.sig" --sign "$f";
  #gpg --detach-sign --pinentry-mode loopback --passphrase --passphrase-fd 0 --output $f.sig --sign $f 
done;
