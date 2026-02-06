# Install Guide

## Local install
```bash
git clone https://github.com/xdx888999/claude-workflow-kit.git
cd claude-workflow-kit
bash install.sh
```

## One-command install from GitHub
```bash
bash -c 'set -e; TMP=$(mktemp -d); git clone --depth 1 https://github.com/xdx888999/claude-workflow-kit.git "$TMP/repo"; bash "$TMP/repo/install.sh"; rm -rf "$TMP"'
```

## Preview only (no write)
```bash
bash install.sh --dry-run
```

## Force overwrite settings (not recommended)
```bash
bash install.sh --force-settings
```

## Notes
- Installer copies template files to `~/.claude`.
- Existing `~/.claude` is backed up as `~/.claude.backup.YYYYmmdd-HHMMSS`.
- If `jq` is installed, `settings.json` is merged to preserve existing model/provider config.
- If `jq` is missing, installer skips settings merge and prints manual merge keys.

## Uninstall
```bash
bash uninstall.sh
```