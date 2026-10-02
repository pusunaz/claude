# Research Project (ARIS)

This repository is a research project driven by
[ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep).
ARIS skills are symlinked into `.claude/skills/` by `scripts/setup_aris.sh`
(the links are gitignored because they point to a machine-local clone at `~/aris_repo`).

<!-- ARIS:BEGIN -->
## ARIS Skill Scope
Manifest: `.aris/installed-skills.txt` (lists every skill ARIS installed and its upstream target).
For ARIS workflows, prefer the project-local skills under `.claude/skills/` over global skills.
Do not modify or delete files inside any skill that is a symlink (symlinks point into `~/aris_repo`).
Update with: `ARIS_UPDATE=1 bash scripts/setup_aris.sh` (re-runnable; reconciles new/removed skills).
<!-- ARIS:END -->

## Research Direction

<!-- Replace with a specific direction, e.g. "factorized gap in discrete diffusion LMs", not "NLP". -->
- Topic: TODO
- Target venue: TODO

## Remote Server

<!-- Fill in to let ARIS run experiments on your GPU box. Delete this section, or set
     `gpu: modal` / `gpu: vast` / `gpu: local`, if you use another backend (see ARIS docs/GPU_SETUP_CN.md). -->
- gpu: remote
- SSH: `ssh username@your-server-ip` (key-based auth, no password)
- GPU: TODO (e.g. 8x RTX 4090 24GB)
- Conda env: `YOUR_ENV` (Python 3.x + PyTorch x.x.x)
- Activate: `eval "$(/path/to/miniconda3/bin/conda shell.bash hook)" && conda activate YOUR_ENV`
- Code directory: `/home/user/experiments/`
- Use `screen` for background jobs: `screen -dmS exp0 bash -c '...'`
