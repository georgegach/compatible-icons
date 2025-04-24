#!/usr/bin/env bash
set -euo pipefail

SVG_DIR="./icons"
OUTPUT_DIR="./compat"
mkdir -p "$OUTPUT_DIR"

# Define your target colors (key = subdir name, value = CSS color)
declare -A COLORS=(
  [white]="#ffffff"
  [black]="#000000"
  [slate]="#e2e8f0"
)

# Define your dimensions
DIMENSIONS=(16 64 128 512 1024)

mapfile -t svg_files < <(find "$SVG_DIR" -maxdepth 1 -name '*.svg' | sort)
total=${#svg_files[@]}
count=0

for svg in "${svg_files[@]}"; do
  count=$((count + 1))
  base=$(basename "$svg" .svg)
  icon_dir="$OUTPUT_DIR/$base"

  # Check if *all* outputs already exist
  all_exist=true
  for dim in "${DIMENSIONS[@]}"; do
    for suffix in "${!COLORS[@]}"; do
      if [ ! -f "$icon_dir/$dim/$suffix.png" ]; then
        all_exist=false
        break 2
      fi
    done
  done

  if [ "$all_exist" = true ]; then
    echo "[$count/$total] Skipping $base.svg — all sizes/colors already generated."
  else
    echo "[$count/$total] Processing $base.svg…"
    for dim in "${DIMENSIONS[@]}"; do
      for suffix in "${!COLORS[@]}"; do
        out="$icon_dir/$dim/$suffix.png"
        if [ -f "$out" ]; then
          echo "    → $dim/$suffix.png exists, skipping."
          continue
        fi
        mkdir -p "$(dirname "$out")"
        hex=${COLORS[$suffix]}
        CSS="path,rect,circle,ellipse,polygon,line,polyline { fill: ${hex} !important; stroke: ${hex} !important; }"
        sed "s|<svg\([^>]*\)>|<svg\1><defs><style>${CSS}</style></defs>|i" "$svg" \
          | rsvg-convert \
              --width="$dim" \
              --height="$dim" \
              --background-color=transparent \
              -o "$out"
        echo "    → Generated $dim/$suffix.png"
      done
    done
  fi

  # — now generate (or overwrite) the README.md for this icon —
  readme="$icon_dir/README.md"
  mkdir -p "$icon_dir"
  {
    # Title
    echo "# $base"
    echo

    # Backlink to the master README
    echo "[← Back to main README](../../README.md)"
    echo

    # Row of 128px icons for each color, plain
    echo
    for suffix in "${!COLORS[@]}"; do
      echo "<img src=\"./128/${suffix}.png\" width=\"128\" alt=\"${base} ${suffix} icon\" />"
    done
    echo

    # List all sizes/URLs
    for dim in "${DIMENSIONS[@]}"; do
      echo "## $dim px"
      echo
      for suffix in "${!COLORS[@]}"; do
        echo "### $suffix"
        echo '```'
        echo "https://georgegach.github.io/compatible-icons/simple-icons/$base/$dim/$suffix.png"
        echo '```'
        echo
      done
    done

    # 16px Base64 section
    echo "## 16 px in base64"
    echo
    for suffix in "${!COLORS[@]}"; do
      echo "### $suffix"
      echo '```'
      b64=$(base64 -w0 "$icon_dir/16/$suffix.png")
      echo "data:image/png;base64,$b64"
      echo '```'
      echo
    done
  } > "$readme"
  echo "    → Wrote README.md"
done

echo "🎉 Done! Generated icons and READMEs in $OUTPUT_DIR."
