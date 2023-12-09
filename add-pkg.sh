#!/bin/sh

if [ -z $1 ]; then
  ARCH_DIR="x86_64";
else
  ARCH_DIR=$1;
fi;

repo-add --verify --sign "$ARCH_DIR/soypac.db.tar.gz" "$ARCH_DIR"/*.pkg.tar.zst;
