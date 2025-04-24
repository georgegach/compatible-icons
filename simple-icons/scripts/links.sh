#!/usr/bin/env bash
set -euo pipefail

master="./README.md"
{
  echo "# Simple Icons"
  echo
  echo "Each icon has varying sizes and colors, which are stored in their respective folders. The following icons are available:"
  echo

  for dir in compat/*/; do
    name=${dir%/}        # strip trailing slash
    name=${name##*/}     # strip leading path
    # only link if a README.md actually exists
    if [[ -f "compat/$name/README.md" ]]; then
      echo "- [$name](compat/$name/README.md)"
    fi
  done
} > "$master"

echo "✅ Wrote master README.md in $(pwd)"
