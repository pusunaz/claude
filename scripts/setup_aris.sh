#!/usr/bin/env bash
# Idempotent ARIS bootstrap for this project.
#   1. Clone (or update with ARIS_UPDATE=1) ARIS to $ARIS_REPO (default ~/aris_repo)
#   2. Symlink ARIS skills into .claude/skills/ via the upstream installer
#   3. Register the `codex` MCP reviewer in Claude Code if codex CLI is present
# Safe to re-run.
set -euo pipefail

ARIS_URL="https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep.git"
ARIS_REPO="${ARIS_REPO:-$HOME/aris_repo}"
PROJECT_DIR="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
export ARIS_REPO

log() { printf '[setup_aris] %s\n' "$*" >&2; }

# 1. Clone or update
if [[ -d "$ARIS_REPO/.git" ]]; then
    if [[ "${ARIS_UPDATE:-0}" == "1" ]]; then
        log "updating $ARIS_REPO"
        git -C "$ARIS_REPO" pull --ff-only --quiet || log "git pull failed, keeping current checkout"
    fi
else
    log "cloning ARIS into $ARIS_REPO"
    git clone --depth 1 --quiet "$ARIS_URL" "$ARIS_REPO"
fi

# 2. Install / reconcile skills (symlinks are machine-specific, so they are gitignored)
cd "$PROJECT_DIR"
if [[ -f .aris/installed-skills.txt ]]; then
    bash "$ARIS_REPO/tools/install_aris.sh" "$PROJECT_DIR" --aris-repo "$ARIS_REPO" \
        --quiet --no-doc --skip-new >/dev/null \
        || log "reconcile reported issues; rerun without --quiet to inspect"
else
    # ARIS_GROUPS=lit-search,ideation limits the install; default is every skill
    if [[ -n "${ARIS_GROUPS:-}" ]]; then select=(--groups "$ARIS_GROUPS"); else select=(--all); fi
    log "installing ARIS skills into .claude/skills/"
    bash "$ARIS_REPO/tools/install_aris.sh" "$PROJECT_DIR" --aris-repo "$ARIS_REPO" \
        --quiet --no-doc "${select[@]}" >/dev/null
fi

# 3. Register the codex reviewer MCP (skills hardcode the name `codex`)
if command -v claude >/dev/null 2>&1 && command -v codex >/dev/null 2>&1; then
    if ! claude mcp list 2>/dev/null | grep -q '^codex:'; then
        log "registering codex MCP server (restart Claude Code afterwards)"
        claude mcp add codex -s user -- python3 "$ARIS_REPO/mcp-servers/codex-exec/server.py" >/dev/null \
            || log "could not register codex MCP; see README"
    fi
else
    log "codex CLI not found: GPT cross-model review is unavailable here (see README)"
fi

log "done: $(ls .claude/skills 2>/dev/null | wc -l | tr -d ' ') skills linked"
