#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${HOME}/.claude"
BACKUP_INPUT="${1:-}"

usage() {
  cat <<'USAGE'
Usage:
  bash uninstall.sh [backup_path]

Examples:
  bash uninstall.sh
  bash uninstall.sh ~/.claude.backup.20260206-231821
USAGE
}

if [[ "${BACKUP_INPUT}" == "-h" || "${BACKUP_INPUT}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ ! -d "${TARGET_DIR}" ]]; then
  echo "No ~/.claude directory found. Nothing to uninstall."
  exit 0
fi

echo "Removing workflow kit files from: ${TARGET_DIR}"
rm -f "${TARGET_DIR}/CLAUDE.md"
rm -f "${TARGET_DIR}/help-workflow.md"
rm -rf "${TARGET_DIR}/agents" "${TARGET_DIR}/commands" "${TARGET_DIR}/rules"

if [[ -n "${BACKUP_INPUT}" ]]; then
  BACKUP_DIR="${BACKUP_INPUT/#\~/$HOME}"
  if [[ -d "${BACKUP_DIR}" ]]; then
    echo "Restoring backup from: ${BACKUP_DIR}"
    cp -a "${BACKUP_DIR}/." "${TARGET_DIR}/"
  else
    echo "Backup not found: ${BACKUP_DIR}"
    exit 1
  fi
else
  echo "No backup path provided. ~/.claude/settings.json was not modified by uninstall."
  echo "If needed, restore manually from ~/.claude.backup.<timestamp>."
fi

echo "Done."
