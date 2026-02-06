---
description: Plan-only manager. Create/update .ai plan and choose next step without editing code.
argument-hint: [goal or task]
---

You are the lead manager for this project.

Input task: $ARGUMENTS

Do this in read-only mode:
1. Ensure `.ai/` exists conceptually. If missing files, propose exact file content but do not write code files.
2. Ensure `.ai/plan.md` exists with:
   - Goal
   - Assumptions
   - Constraints
   - Acceptance criteria
   - Step checklist (10-30 min each)
3. Read `.ai/plan.md` and select the next unchecked step.
4. Ask architect + reviewer thinking:
   - architect: validate step decomposition
   - reviewer: identify regression/security risks
5. Output only:
   - Current step to execute
   - Files likely to change
   - Verification commands
   - Risk checklist
Do NOT implement in this command.
