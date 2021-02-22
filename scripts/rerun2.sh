#!/usr/bin/env bash

# Save rerun2 on your PATH, and invoke it using: `rerun COMMAND`
function execute() {
    clear
    echo "$@"
    eval "$@"
}

execute "$@"

inotifywait --quiet --recursive --monitor --event modify --format "%w%f" . \
| while read change; do
    execute "$@"
done