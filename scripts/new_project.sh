#!/usr/bin/env bash
# Create a new ARIS research project under $PROJECTS_DIR (default ~/projects).
# Usage: bash new_project.sh <name>        e.g. bash new_project.sh fault-diagnosis
# Safe to re-run on an existing project: it only fills in what is missing.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"
name="${1:-}"

if [[ ! "$name" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "usage: bash $0 <name>   (lowercase letters, digits and '-', e.g. fault-diagnosis)" >&2
    exit 1
fi

dir="$PROJECTS_DIR/$name"
mkdir -p "$dir"/{code,data,records,literature,paper,experiments}
cd "$dir"

[[ -d .git ]] || git init -q
[[ -f CLAUDE.md ]] || sed "s/__NAME__/$name/g" "$KIT_DIR/templates/project/CLAUDE.md" > CLAUDE.md
[[ -f .gitignore ]] || cp "$KIT_DIR/templates/project/gitignore" .gitignore

bash "$KIT_DIR/scripts/setup_aris.sh" "$dir"

echo
echo "Project ready: $dir"
echo "Next: edit the Research Direction in CLAUDE.md, then run"
echo "  bash $KIT_DIR/scripts/start_remote.sh $name"
