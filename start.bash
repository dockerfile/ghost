#!/bin/bash

#
# start.bash
#

GHOST="/ghost"
OVERRIDE="/ghost-override"
DATA="content/data"
THEMES="content/themes"

cd "$GHOST"

# Symlink data directory.
mkdir -p "$OVERRIDE/$DATA"
rm -fr "$DATA"
ln -s "$OVERRIDE/$DATA" content

# Symlink themes if its in override
if [[ -d "$OVERRIDE/$THEMES" ]]; then
  rm -rf "$THEMES"
  ln -s "$OVERRIDE/$THEMES" "$THEMES"
fi

# Symlink config if it's in override
if [[ -f "$OVERRIDE/config.js" ]]; then
  rm "config.js"
  ln -s "$OVERRIDE/config.js" config.js
fi

npm start
