#!/usr/bin/env sh

makoctl reload

notify-send \
  -a "Mako" \
  -t 5000 \
  -u normal \
  "Mako reloaded." \
  "The configuration has been successfuly reloaded."