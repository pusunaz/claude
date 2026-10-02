#!/usr/bin/env bash
# Start `claude remote-control` for each project in its own detached tmux session
# (session name = project folder name). Projects already running are skipped.
# Usage: bash start_remote.sh              start every project in $PROJECTS_DIR
#        bash start_remote.sh esu tableting  start only these
set -euo pipefail

PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"

if [[ $# -gt 0 ]]; then
    names=("$@")
else
    names=()
    for d in "$PROJECTS_DIR"/*/; do
        [[ -f "$d/CLAUDE.md" ]] && names+=("$(basename "$d")")
    done
fi

for name in "${names[@]}"; do
    dir="$PROJECTS_DIR/$name"
    if [[ ! -d "$dir" ]]; then
        echo "skip $name: $dir does not exist" >&2
        continue
    fi
    if tmux has-session -t "=$name" 2>/dev/null; then
        echo "running  $name"
        continue
    fi
    # bash -i loads ~/.bashrc (PATH for claude, conda); the trailing shell keeps the
    # window open if remote-control exits, so the reason stays visible.
    tmux new-session -d -s "$name" -c "$dir" \
        "bash -ic 'claude remote-control --spawn=same-dir; echo; echo \"remote-control exited\"; exec bash'"
    echo "started  $name"
done

echo
echo "First run in a project asks to trust the folder: tmux attach -t <name>, answer, then Ctrl+B D."
echo "List sessions: tmux ls"
