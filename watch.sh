#!/bin/sh
gleam run --target javascript -m build
while inotifywait -r -e modify,create,delete src/ content/ public/; do
  gleam run --target javascript -m build
done
