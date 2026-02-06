# Workflow State Machine

## 1) Plan
- Understand goal, constraints, acceptance criteria.
- Read only relevant files.
- Produce 3-7 small steps.
- Define verification command(s) for each step.

## 2) Execute
- Execute only one unchecked step.
- Keep file edits minimal.
- If scope expands, stop and re-plan.

## 3) Verify
- Run targeted tests/lint/build for touched scope.
- If verification fails, fix within same step or revert that step.

## 4) Log
- Append to `.ai/progress.md`:
  - step completed
  - files changed
  - commands run and results
  - next step

## 5) Stop
- Stop after one completed step.
- Wait for next command.
