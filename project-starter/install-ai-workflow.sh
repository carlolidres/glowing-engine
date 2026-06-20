#!/usr/bin/env bash
# Install or refresh GxP AI workflow files into a target project.
# Usage: ./project-starter/install-ai-workflow.sh /path/to/my-app [--source /path/to/glowing-engine] [--force]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="${SOURCE:-$(cd "$SCRIPT_DIR/.." && pwd)}"
DEST=""
FORCE=false
SKIP_OPTIONAL=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --source) SOURCE="$2"; shift 2 ;;
    --force) FORCE=true; shift ;;
    --skip-optional) SKIP_OPTIONAL=true; shift ;;
    *) DEST="$1"; shift ;;
  esac
done

if [[ -z "$DEST" ]]; then
  echo "Usage: $0 <destination-path> [--source repo-root] [--force] [--skip-optional]" >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "jq is required for install-ai-workflow.sh" >&2
  exit 1
fi

if ! command -v rsync >/dev/null 2>&1; then
  echo "rsync is required. On Windows, use install-ai-workflow.ps1" >&2
  exit 1
fi

MANIFEST="$SCRIPT_DIR/workflow-manifest.json"
mkdir -p "$DEST"

echo "Installing GxP AI workflow"
echo "  from: $SOURCE"
echo "  to:   $DEST"
echo ""

copy_path() {
  local rel="$1"
  local src="$SOURCE/$rel"
  local dst="$DEST/$rel"

  if [[ ! -e "$src" ]]; then
    echo "  skip missing: $rel" >&2
    return 0
  fi

  if [[ -e "$dst" && "$FORCE" != true ]]; then
    if [[ -d "$src" ]]; then
      rsync -a "$src/" "$dst/"
    else
      echo "  skip file (exists): $rel"
      return 0
    fi
  else
    mkdir -p "$(dirname "$dst")"
    if [[ -d "$src" ]]; then
      rsync -a "$src/" "$dst/"
    else
      cp -f "$src" "$dst"
    fi
  fi
  echo "  copied: $rel"
}

while IFS= read -r entry; do
  required="$(echo "$entry" | jq -r '.required')"
  path="$(echo "$entry" | jq -r '.path')"
  if [[ "$SKIP_OPTIONAL" == true && "$required" != true ]]; then
    continue
  fi
  copy_path "$path"
done < <(jq -c '.paths[]' "$MANIFEST")

seed_template() {
  local dest_rel="$1"
  local template_file="$2"
  local dst="$DEST/$dest_rel"
  if [[ -e "$dst" && "$FORCE" != true ]]; then
    echo "  keep existing: $dest_rel"
    return 0
  fi
  mkdir -p "$(dirname "$dst")"
  cp -f "$SCRIPT_DIR/templates/$template_file" "$dst"
  echo "  seeded template: $dest_rel"
}

seed_template "baseline-.md" "baseline-.md"
seed_template "agent-workflow/HANDOFF.md" "HANDOFF.md"
seed_template "agent-workflow/PLAN.md" "PLAN.md"

GITIGNORE="$DEST/.gitignore"
APPEND="$SCRIPT_DIR/templates/gitignore-append.txt"
if [[ -f "$APPEND" ]]; then
  while IFS= read -r line || [[ -n "$line" ]]; do
    [[ -z "$line" ]] && continue
    if [[ ! -f "$GITIGNORE" ]] || ! grep -Fxq "$line" "$GITIGNORE" 2>/dev/null; then
      if [[ ! -f "$GITIGNORE" ]]; then
        echo "# --- GxP AI workflow (project-starter) ---" > "$GITIGNORE"
      elif ! grep -q "GxP AI workflow" "$GITIGNORE" 2>/dev/null; then
        echo "" >> "$GITIGNORE"
        echo "# --- GxP AI workflow (project-starter) ---" >> "$GITIGNORE"
      fi
      echo "$line" >> "$GITIGNORE"
    fi
  done < "$APPEND"
  echo "  updated: .gitignore"
fi

echo ""
echo "Done. Merge project-starter/templates/package-scripts.json into package.json"
