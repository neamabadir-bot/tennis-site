#!/usr/bin/env bash
# Plays a "done" sound when Claude (or a subagent) finishes.
# Uses your own sound file if present, otherwise the OS's built-in sound.
# On Windows, the default is C:\Windows\Media\tada.wav, the classic Windows sound.
CUSTOM="$HOME/.claude/sounds/win95.wav"

case "$(uname -s)" in
  MINGW*|MSYS*|CYGWIN*)
    if [ -f "$CUSTOM" ]; then WAV="$(cygpath -w "$CUSTOM")"; else WAV='C:\Windows\Media\tada.wav'; fi
    powershell.exe -NoProfile -Command "(New-Object Media.SoundPlayer '$WAV').PlaySync()" ;;
  Darwin)
    if [ -f "$CUSTOM" ]; then afplay "$CUSTOM"; else afplay /System/Library/Sounds/Glass.aiff; fi ;;
  Linux)
    if grep -qi microsoft /proc/version 2>/dev/null; then   # WSL: play through Windows
      powershell.exe -NoProfile -Command "(New-Object Media.SoundPlayer 'C:\Windows\Media\tada.wav').PlaySync()"
    elif command -v paplay >/dev/null && [ -f "$CUSTOM" ]; then paplay "$CUSTOM"
    elif command -v aplay  >/dev/null && [ -f "$CUSTOM" ]; then aplay -q "$CUSTOM"
    else printf '\a'
    fi ;;
esac
exit 0
