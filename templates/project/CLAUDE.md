# Research Project: __NAME__ (ARIS)

This project is driven by
[ARIS](https://github.com/wanshuiyin/Auto-claude-code-research-in-sleep).
ARIS skills are symlinked into `.claude/skills/` by `~/aris-kit/scripts/setup_aris.sh`
(the links are gitignored because they point to a machine-local clone at `~/aris_repo`).

<!-- ARIS:BEGIN -->
## ARIS Skill Scope
Manifest: `.aris/installed-skills.txt` (lists every skill ARIS installed and its upstream target).
For ARIS workflows, prefer the project-local skills under `.claude/skills/` over global skills.
Do not modify or delete files inside any skill that is a symlink (symlinks point into `~/aris_repo`).
Update with: `ARIS_UPDATE=1 bash ~/aris-kit/scripts/setup_aris.sh` (run inside this project) (re-runnable; reconciles new/removed skills).
<!-- ARIS:END -->

## Research Direction

<!-- Replace with a specific direction, e.g. "factorized gap in discrete diffusion LMs", not "NLP". -->
- Topic: TODO
- Target venue: TODO

## GPU Environment

<!-- The GPU is shared by every project on this machine: check `nvidia-smi` before
     launching a job and do not start a second large job while one is running. -->
- gpu: local
- This machine has direct GPU access (no SSH needed)
- GPU: NVIDIA GeForce RTX 4080 (16GB)
- Conda env: `research` (activate with `conda activate research`)
- Code directory: `./code/`, experiment outputs in `./experiments/`
- Use `tmux` for background jobs: `tmux new -d -s __NAME__-exp0 'bash -ic "conda activate research && ..."'`
