#!/usr/bin/env bash
set -euo pipefail

APP_NAME="calabi-shell"
BEGIN_MARKER="# >>> ${APP_NAME} >>>"
END_MARKER="# <<< ${APP_NAME} <<<"
MODE="user"

usage() {
  cat <<USAGE
Usage: $0 [--system]

Options:
  --system   Remove the system-wide Bash default. Requires root.
  -h, --help Show this help.
USAGE
}

for arg in "$@"; do
  case "$arg" in
    --system)
      MODE="system"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      printf '[%s] ERROR: unknown argument: %s\n' "$APP_NAME" "$arg" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [ "$MODE" = "system" ]; then
  [ "$(id -u)" -eq 0 ] || {
    printf '[%s] ERROR: --system requires root\n' "$APP_NAME" >&2
    exit 1
  }

  CONFIG_ROOT="/etc/xdg"
  APP_CONFIG_DIR="${CONFIG_ROOT}/${APP_NAME}"
  BASHRC_PATH="/etc/bashrc"
  PROFILE_SNIPPET_PATH="/etc/profile.d/${APP_NAME}.sh"
else
  CONFIG_ROOT="${XDG_CONFIG_HOME:-$HOME/.config}"
  APP_CONFIG_DIR="${CONFIG_ROOT}/${APP_NAME}"
  BASHRC_PATH="${HOME}/.bashrc"
  PROFILE_SNIPPET_PATH=""
fi

remove_managed_block() {
  local file="$1"
  [ -f "$file" ] || return 0

  awk -v begin="$BEGIN_MARKER" -v end="$END_MARKER" '
    $0 == begin { skip=1; next }
    $0 == end   { skip=0; next }
    !skip       { print }
  ' "$file" > "${file}.tmp"

  mv "${file}.tmp" "$file"
}

remove_managed_block "$BASHRC_PATH"
rm -rf "$APP_CONFIG_DIR"
[ -n "$PROFILE_SNIPPET_PATH" ] && rm -f "$PROFILE_SNIPPET_PATH"

printf '[%s] removed managed bash init from %s\n' "$APP_NAME" "$BASHRC_PATH"
printf '[%s] removed %s\n' "$APP_NAME" "$APP_CONFIG_DIR"
if [ -n "$PROFILE_SNIPPET_PATH" ]; then
  printf '[%s] removed %s\n' "$APP_NAME" "$PROFILE_SNIPPET_PATH"
fi
printf '[%s] starship itself was left in place intentionally\n' "$APP_NAME"
printf '[%s] restart your shell or run: exec bash -l\n' "$APP_NAME"
