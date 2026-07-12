#!/usr/bin/env bash
# Toggle a fullscreen, looping hypno gif/photo with mpv.
# Bound to Mod+Shift+H in niri. Press the bind again (or q/Esc) to close.

GIF="${HYPNO_GIF:-$HOME/Pictures/hypno.gif}"
PIDFILE="${XDG_RUNTIME_DIR:-/tmp}/hypno-mpv.pid"

# Already open -> close it.
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE")" 2>/dev/null; then
    kill "$(cat "$PIDFILE")"
    rm -f "$PIDFILE"
    exit 0
fi

if [ ! -f "$GIF" ]; then
    notify-send "Hypno gif" "No file at $GIF — drop your gif there." 2>/dev/null
    exit 1
fi

# q and Esc quit (mpv defaults); no audio, loops forever, no on-screen controls.
mpv \
    --loop-file=inf \
    --fullscreen \
    --no-audio \
    --no-osc \
    --really-quiet \
    "$GIF" &

echo $! > "$PIDFILE"
