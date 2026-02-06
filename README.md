# Claude Workflow Kit

A production-ready Claude Code workflow template for "manager -> single-step execute -> verify" development.

This kit is designed for users who run Claude Code with alternative model backends (for example GLM-compatible endpoints) and want consistent engineering behavior through structured commands, roles, and rules.

## Why This Exists

Most failures in AI coding sessions are workflow failures, not model failures:

- The assistant edits too much at once.
- No clear "plan first, then execute one step" gate.
- Missing verification and progress logging.
- Prompt style changes between sessions.

This template solves that by enforcing a repeatable loop:

1. Plan
2. Execute one step
3. Verify
4. Log
5. Stop

## What Gets Installed

Into `~/.claude`:

- `CLAUDE.md`
- `settings.json` (safe merge, not blind overwrite)
- `rules/flow.md`
- `commands/manager.md`
- `commands/ship-step.md`
- `commands/manager-team.md`
- `agents/architect.md`
- `agents/implementer.md`
- `agents/reviewer.md`
- `agents/qa.md`
- `help-workflow.md`

## Quick Install

### Option A: clone and install
```bash
git clone https://github.com/xdx888999/claude-workflow-kit.git
cd claude-workflow-kit
bash install.sh
```

### Option B: one-command from GitHub
```bash
bash -c 'set -e; TMP=$(mktemp -d); git clone --depth 1 https://github.com/xdx888999/claude-workflow-kit.git "$TMP/repo"; bash "$TMP/repo/install.sh"; rm -rf "$TMP"'
```

## Daily Usage

1. Start Claude Code (default `plan` mode recommended).
2. Run `/manager <goal>`.
3. Switch mode with `Shift+Tab` to editable mode.
4. Run `/ship-step`.
5. Repeat.

For complex parallelizable tasks:

- Run `/manager-team <complex-goal>`.

## Safety Notes

- Installer creates backup: `~/.claude.backup.YYYYmmdd-HHMMSS`.
- Existing model/provider settings are preserved when `jq` is available.
- If `jq` is missing, installer skips risky settings overwrite and prints manual merge instructions.

## Uninstall / Rollback

1. Remove installed files manually from `~/.claude`, or
2. Restore backup folder:
```bash
cp -a ~/.claude.backup.<timestamp> ~/.claude
```

## Security

Please read `SECURITY.md` before sharing examples or logs that may contain credentials.

## Uninstall

```bash
bash uninstall.sh
```

## License

MIT
