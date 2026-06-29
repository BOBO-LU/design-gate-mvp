#!/usr/bin/env bash
set -euo pipefail

MARKETPLACE_NAME="${DESIGN_GATE_MARKETPLACE_NAME:-team-engineering-standards}"
PLUGIN_NAME="design-gate"
SOURCE="${1:-}"

if ! command -v claude >/dev/null 2>&1; then
  echo "ERROR: Claude Code CLI not found." >&2
  exit 1
fi

if [[ -z "$SOURCE" ]]; then
  # If the script's own directory is the marketplace, use it directly.
  HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [[ -f "$HERE/.claude-plugin/marketplace.json" ]]; then
    SOURCE="$HERE"
  fi
fi

if [[ -z "$SOURCE" ]]; then
  echo "Usage: ./install.sh <github-owner/repo | git-url | local-path>" >&2
  exit 2
fi

echo "Adding marketplace: $SOURCE"
claude plugin marketplace add "$SOURCE"

echo "Installing plugin: ${PLUGIN_NAME}@${MARKETPLACE_NAME}"
claude plugin install "${PLUGIN_NAME}@${MARKETPLACE_NAME}"

# Dev mode: replace the copy in the cache with a symlink to the repo, so code changes take effect immediately.
# Only applies to local-path installs; github/git-url installs have no local plugin directory and are skipped automatically.
PLUGIN_SRC="$SOURCE/plugins/${PLUGIN_NAME}"
if [[ -d "$PLUGIN_SRC" ]]; then
  INSTALL_PATH="$(python3 - "$PLUGIN_NAME" "$MARKETPLACE_NAME" <<'PY'
import json, os, sys
name, mkt = sys.argv[1], sys.argv[2]
p = os.path.expanduser("~/.claude/plugins/installed_plugins.json")
print(json.load(open(p))["plugins"][f"{name}@{mkt}"][0]["installPath"])
PY
)"
  if [[ -n "$INSTALL_PATH" ]]; then
    rm -rf "$INSTALL_PATH"
    mkdir -p "$(dirname "$INSTALL_PATH")"
    ln -s "$PLUGIN_SRC" "$INSTALL_PATH"
    echo "Dev symlink: $INSTALL_PATH -> $PLUGIN_SRC"
  fi
fi

cat <<'EOF'

Design Gate installation complete.

Reload the plugin:
  /reload-plugins

The first time you use it in each repository:
  python3 "${CLAUDE_PLUGIN_ROOT}/scripts/design_gate.py" init

Start a task:
  /design-gate:design-gate TASK-123 <requirement>
EOF
