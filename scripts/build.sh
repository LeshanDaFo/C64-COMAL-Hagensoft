#!/bin/sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

. "$SCRIPT_DIR/config.sh"

mkdir -p "$ROOT/build"

case "$HSOFT" in
    105)
        BIN="hagensoft_105.bin"
        CHIP="hagensoft_105.chip"
        ;;
    121)
        BIN="hagensoft_121.bin"
        CHIP="hagensoft_121.chip"
        ;;
    *)
        echo "Unknown Hagensoft version: $HSOFT"
        exit 1
        ;;
esac

echo "Building Hagensoft $HSOFT..."

"$ACME" -D HSOFT="$HSOFT" \
        -f plain \
        -o "$ROOT/build/$BIN" \
        "$ROOT/code/hs_main.asm"

echo "Creating CHIP file..."

printf '\x43\x48\x49\x50\x00\x00\x40\x10\x00\x00\x00\x04\x80\x00\x40\x00' > "$ROOT/build/$CHIP"
cat "$ROOT/build/$BIN" >> "$ROOT/build/$CHIP"

echo "Created:"
echo "  build/$BIN"
echo "  build/$CHIP"