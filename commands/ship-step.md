---
description: Execute exactly one planned step, verify, and log progress.
argument-hint: [optional override step id]
---

Execute exactly one step from `.ai/plan.md` (or override with $ARGUMENTS).

Process:
1. Confirm selected step and acceptance criteria.
2. Delegate implementation mindset to implementer.
3. Make minimal edits for that single step only.
4. Delegate review mindset to reviewer.
5. Delegate test mindset to qa.
6. Run verification commands.
7. Update `.ai/progress.md` with:
   - step done
   - files touched
   - commands + results
   - next step
8. Stop immediately after this one step.
