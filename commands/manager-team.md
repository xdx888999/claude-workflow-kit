---
description: Run multi-agent team workflow for parallelizable complex tasks.
argument-hint: [complex task]
---

Task: $ARGUMENTS

If task is not parallelizable, say so and fallback to /manager.

If parallelizable:
1. Create team roles: architect, implementer, reviewer.
2. Split into independent tasks with no same-file conflicts.
3. Require plan approval before any teammate edits code.
4. Keep lead in coordination-only behavior.
5. Synthesize a single merged plan:
   - task ownership
   - dependency order
   - verification gates
   - integration risks
6. Present execution order and wait for approval.
