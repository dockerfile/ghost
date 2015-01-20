#!/bin/bash

GHOST="/ghost"
OVERRIDE="/ghost-override"

CONFIG="config.js"
DATA="content/data"
IMAGES="content/images"
THEMES="content/themes"

NODE_ENV=${NODE_ENV:-production}
WATCH_DIRECTORY=${WATCH_DIRECTORY:-$THEMES}

# Symlink data directory.
mkdir -p "$OVERRIDE/$DATA"
rm -fr "$DATA"
ln -s "$OVERRIDE/$DATA" "content"

# Symlink images directory
mkdir -p "$OVERRIDE/$IMAGES"
rm -fr "$IMAGES"
ln -s "$OVERRIDE/$IMAGES" "$IMAGES"

# Symlink config file.
if [[ -f "$OVERRIDE/$CONFIG" ]]; then
  rm -f "$CONFIG"
  ln -s "$OVERRIDE/$CONFIG" "$CONFIG"
fi

# Symlink themes.
if [[ -d "$OVERRIDE/$THEMES" ]]; then
  for theme in $(find "$OVERRIDE/$THEMES" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)
  do
    rm -fr "$THEMES/$theme"
    ln -s "$OVERRIDE/$THEMES/$theme" "$THEMES/$theme"
  done
fi

# Start Ghost
if [[ "$NODE_ENV" == "development" ]]; then
  COMMAND="NODE_ENV=$NODE_ENV forever --watchDirectory=$WATCH_DIRECTORY -w index.js"
else
  COMMAND="NODE_ENV=$NODE_ENV npm start"
fi

echo "$COMMAND" ; eval $COMMAND
