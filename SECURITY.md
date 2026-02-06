# Security Policy

## Supported Versions

This project is a workflow template. Security fixes are applied to the latest `main` branch.

## Reporting a Vulnerability

Please open a private security advisory in GitHub if possible. If private reporting is unavailable, open an issue without sensitive details and mention that maintainers should contact you.

## Secrets and Credentials

Never commit personal credentials from `~/.claude/settings.json`, including but not limited to:

- `ANTHROPIC_AUTH_TOKEN`
- API keys or provider tokens
- Internal endpoint URLs that contain credentials

## If You Accidentally Leaked a Secret

1. Revoke/rotate the leaked credential immediately.
2. Remove it from git history (for example with `git filter-repo` or BFG).
3. Force-push cleaned history.
4. Invalidate any active sessions tied to that credential.
5. Open a follow-up issue documenting the remediation.
