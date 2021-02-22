#!/usr/bin/env bash

# Save rerun2 on your PATH, and invoke it using: `~/.dotfiles/scripts/ractgt.sh .`
while inotifywait --quiet --recursive --event modify --exclude ./.idea "$1"; do
    rm -rf app/cache/* && rm -rf var/cache/*
    echo "Cache cleared!"
done
