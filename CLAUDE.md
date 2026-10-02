# ARIS Kit

Toolkit for running several ARIS research projects on one lab machine.
It is cloned to `~/aris-kit`; the projects themselves live in `~/projects/<name>/`
and are not part of this repository.

- `scripts/setup_aris.sh [dir]`: clone ARIS to `~/aris_repo` and link its skills into a project
- `scripts/new_project.sh <name>`: create `~/projects/<name>` from `templates/project/`
- `scripts/start_remote.sh [names...]`: start `claude remote-control` per project in tmux
