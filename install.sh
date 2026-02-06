#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${HOME}/.claude"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
BACKUP_DIR="${TARGET_DIR}.backup.${TIMESTAMP}"

FORCE_SETTINGS=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage:
  bash install.sh [--dry-run] [--force-settings]

Options:
  --dry-run         Print actions without writing files.
  --force-settings  Overwrite ~/.claude/settings.json with template settings.
EOF
}

for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --force-settings) FORCE_SETTINGS=1 ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $arg" >&2; usage; exit 1 ;;
  esac
done

run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

is_valid_json() {
  local file="$1"
  if command -v jq >/dev/null 2>&1; then
    jq empty "$file" >/dev/null 2>&1
  else
    python3 -m json.tool "$file" >/dev/null 2>&1
  fi
}

copy_file() {
  local src="$1"
  local dst="$2"
  run "mkdir -p \"$(dirname "$dst")\""
  run "cp \"$src\" \"$dst\""
}

echo "Installing Claude template to: ${TARGET_DIR}"

if [[ -d "${TARGET_DIR}" ]]; then
  echo "Backing up existing ~/.claude to: ${BACKUP_DIR}"
  run "cp -a \"${TARGET_DIR}\" \"${BACKUP_DIR}\""
fi

run "mkdir -p \"${TARGET_DIR}/agents\" \"${TARGET_DIR}/commands\" \"${TARGET_DIR}/rules\""

copy_file "${SCRIPT_DIR}/CLAUDE.md" "${TARGET_DIR}/CLAUDE.md"
copy_file "${SCRIPT_DIR}/rules/flow.md" "${TARGET_DIR}/rules/flow.md"
copy_file "${SCRIPT_DIR}/commands/manager.md" "${TARGET_DIR}/commands/manager.md"
copy_file "${SCRIPT_DIR}/commands/ship-step.md" "${TARGET_DIR}/commands/ship-step.md"
copy_file "${SCRIPT_DIR}/commands/manager-team.md" "${TARGET_DIR}/commands/manager-team.md"
copy_file "${SCRIPT_DIR}/commands/help-workflow.md" "${TARGET_DIR}/commands/help-workflow.md"
copy_file "${SCRIPT_DIR}/agents/architect.md" "${TARGET_DIR}/agents/architect.md"
copy_file "${SCRIPT_DIR}/agents/implementer.md" "${TARGET_DIR}/agents/implementer.md"
copy_file "${SCRIPT_DIR}/agents/reviewer.md" "${TARGET_DIR}/agents/reviewer.md"
copy_file "${SCRIPT_DIR}/agents/qa.md" "${TARGET_DIR}/agents/qa.md"
copy_file "${SCRIPT_DIR}/help-workflow.md" "${TARGET_DIR}/help-workflow.md"

SETTINGS_SRC="${SCRIPT_DIR}/settings.json"
SETTINGS_DST="${TARGET_DIR}/settings.json"

if ! is_valid_json "${SETTINGS_SRC}"; then
  echo "Template settings.json is invalid. Abort."
  exit 1
fi

if [[ ! -f "${SETTINGS_DST}" ]]; then
  echo "No existing settings.json found; copying template settings."
  copy_file "${SETTINGS_SRC}" "${SETTINGS_DST}"
else
  if ! is_valid_json "${SETTINGS_DST}"; then
    echo "Existing ~/.claude/settings.json is invalid JSON."
    echo "Abort to avoid breaking your model/provider config."
    echo "Fix JSON first, then rerun installer."
    exit 1
  fi

  if [[ "$FORCE_SETTINGS" -eq 1 ]]; then
    echo "Overwriting existing settings.json (--force-settings)."
    copy_file "${SETTINGS_SRC}" "${SETTINGS_DST}"
  else
    if command -v jq >/dev/null 2>&1; then
      echo "Merging settings.json with jq (preserves existing model/provider config)."
      if [[ "$DRY_RUN" -eq 1 ]]; then
        echo "[dry-run] jq merge ${SETTINGS_DST} + ${SETTINGS_SRC}"
      else
        tmp_file="$(mktemp)"
        jq -s '
          .[0] as $base | .[1] as $patch |
          ($base * $patch)
          | .permissions.deny = ((($base.permissions.deny // []) + ($patch.permissions.deny // [])) | unique)
          | .permissions.defaultMode = ($patch.permissions.defaultMode // $base.permissions.defaultMode)
          | .env = (($base.env // {}) + ($patch.env // {}))
          | .teammateMode = ($patch.teammateMode // $base.teammateMode)
        ' "${SETTINGS_DST}" "${SETTINGS_SRC}" > "${tmp_file}"
        cp "${tmp_file}" "${SETTINGS_DST}"
        rm -f "${tmp_file}"
      fi
    else
      echo "jq not found; skipping settings merge to avoid overwriting your GLM config."
      echo "Manual step: merge these keys from ${SETTINGS_SRC} into ${SETTINGS_DST}:"
      echo "  - permissions.defaultMode"
      echo "  - permissions.deny"
      echo "  - env.CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS"
      echo "  - teammateMode"
    fi
  fi
fi

echo "Done."
echo "Next:"
echo "  1) Restart Claude Code session"
echo "  2) Run /manager <goal>"
echo "  3) Switch mode with Shift+Tab, then run /ship-step"
