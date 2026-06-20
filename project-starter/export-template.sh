#!/usr/bin/env bash
# Export a clean GxP Toolkit copy to a new project folder.
# Usage: ./project-starter/export-template.sh /path/to/my-new-app [--force]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
IGNORE_FILE="$SCRIPT_DIR/.exportignore"
FORCE=false
DEST=""

for arg in "$@"; do
  if [[ "$arg" == "--force" ]]; then
    FORCE=true
  elif [[ -z "$DEST" ]]; then
    DEST="$arg"
  fi
done

if [[ -z "$DEST" ]]; then
  echo "Usage: $0 <destination-path> [--force]" >&2
  exit 1
fi

mkdir -p "$DEST"

if [[ "$FORCE" != true ]] && [[ -n "$(ls -A "$DEST" 2>/dev/null || true)" ]]; then
  echo "Destination is not empty: $DEST. Pass --force to export anyway." >&2
  exit 1
fi

EXCLUDES=()
while IFS= read -r line || [[ -n "$line" ]]; do
  line="${line%%#*}"
  line="$(echo "$line" | xargs)"
  [[ -z "$line" ]] && continue
  if [[ "$line" == */ ]]; then
    name="${line%/}"
    EXCLUDES+=(--exclude "$name")
    EXCLUDES+=(--exclude "*/$name")
    EXCLUDES+=(--exclude "*/$name/*")
  else
    EXCLUDES+=(--exclude "$line")
  fi
done < "$IGNORE_FILE"

if command -v rsync >/dev/null 2>&1; then
  rsync -a "${EXCLUDES[@]}" "$ROOT/" "$DEST/"
else
  echo "rsync is required for export-template.sh. On Windows, use export-template.ps1 instead." >&2
  exit 1
fi

echo ""
echo "Exported GxP Toolkit template to:"
echo "  $DEST"
echo ""
echo "Next steps:"
echo "  cd \"$DEST\""
echo "  npm install"
echo "  cp .env.example .env.local"
echo "  npm run dev"
echo ""
echo "See project-starter/CHECKLIST.md and FIRST_PROMPT.md"
