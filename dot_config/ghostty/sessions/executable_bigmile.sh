#!/usr/bin/env zsh
# Source login profile immediately so PATH (brew, mise, etc.) is available
# for anything this script does before handing off to the interactive shell.
[[ -f ~/.zprofile ]] && source ~/.zprofile
[[ -f ~/.zshrc ]]   && source ~/.zshrc
# Ghostty session: BigMile
# Recreates the kitty startup_session layout:
#   Tab 1 "App"   — ~/Source/BigMile3/
#   Tab 2 "k9s"   — ~/Source/BigMile3/
#   Tab 3 "infra" — ~/Source/k8s-clusters/
#
# This script runs as initial-command in the first tab.
# It uses osascript to open additional tabs and seed their working directories,
# then settles the focus back on tab 1.
#
# NOTE: Ghostty on macOS does not support CLI-driven tab/window creation
# (ghostty +new-window is unsupported). osascript key events are the only
# way to open tabs from within a running session.

GHOSTTY_APP="Ghostty"

# Helper: open a new tab and run a command in it
_new_tab() {
  local dir="$1"

  # Send Ctrl+Shift+T to open a new tab (matches keybind in config.ghostty)
  osascript -e "
    tell application \"$GHOSTTY_APP\" to activate
    tell application \"System Events\"
      keystroke \"t\" using {control down, shift down}
    end tell
  "
  sleep 0.3

  # cd into directory
  osascript -e "
    tell application \"System Events\"
      keystroke \"cd $dir \" & return
    end tell
  "
  sleep 0.1

  # Clear the new tab (Ctrl+L) so it's clean
  osascript -e "
    tell application \"System Events\"
      keystroke \"l\" using {control down}
    end tell
  "
  sleep 0.05
}

# ── Tab 1: App (current tab, just cd) ─────────────────────────────────────────
cd ~/Source/BigMile3/ || true

# ── Tab 2: k9s ────────────────────────────────────────────────────────────────
_new_tab "~/Source/BigMile3/"

# ── Tab 3: infra ──────────────────────────────────────────────────────────────
_new_tab "~/Source/k8s-clusters/"

# ── Return focus to tab 1 ─────────────────────────────────────────────────────
# Send Ctrl+Shift+Left twice to cycle back to the first tab
osascript -e "
  tell application \"System Events\"
    keystroke \"{\" using {control down, shift down}
    keystroke \"{\" using {control down, shift down}
  end tell
"

# Hand off to an interactive login shell in tab 1.
# The -l flag sources ~/.zprofile (and by extension ~/.zshrc via your profile
# setup), which ensures PATH includes brew, mise, etc.
exec "$SHELL" -l
