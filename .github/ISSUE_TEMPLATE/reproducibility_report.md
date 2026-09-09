---
name: Reproducibility report
about: Report reviewer, benchmark, or example reproduction results
title: "[Reproducibility]: "
labels: reproducibility
assignees: ""
---

## Run Summary

Which command or example did you run?

```matlab
csoma_setup
log_file = verify_round2()
```

## Environment

- MATLAB release:
- Operating system:
- CPU:
- Toolboxes available:
- CSOMA version, release, or commit:

## Seeds And Settings

- Data seed:
- Optimizer seed:
- Swarm size:
- Phi:
- Max iterations:

## Result

Paste the relevant output, objective value, timing, and any differences from the
documented result.

## Acceptance Check

- Did `tests/run_tests.m` print `CSOMA smoke tests passed.`?
- Did `replication/run_all.m` print
  `All fast replication acceptance checks passed.`?
- Did `verify_round2` print `ROUND2_RELEASE_VERIFICATION=PASS`?
- If reporting a release verification, was `GIT_WORKTREE_CLEAN=YES`?
- If not, paste the named assertion identifier and complete error message.
