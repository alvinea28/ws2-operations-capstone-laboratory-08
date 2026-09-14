# Lab 08 · Activity 02 — Write a safe recovery decision

[Review index](README.md) · [Previous activity](activity-01.md) · [Next activity](activity-03.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress. Lab 08 completes offline; optional later release/live work is a separate outcome.

<!-- FULL-WS-LESSON:START -->
# Lab 08 · Step 2 — Write a recovery decision, not an unsafe fix

| Before you start | This step |
| --- | --- |
| Goal | Distinguish five failure categories and route each to a reviewed correction |
| Start / working branch | Continue `lab/capstone` in your own independent private copy |
| Edit | [runbook.md](../runbook.md) only |
| Read | [incidents/oidc-subject.md](../incidents/oidc-subject.md) and your [incidents/selected.json](../incidents/selected.json) |
| Exact phrases | `Never force-unlock an active run` and `reviewed correction` |
| Toolchain | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; offline study and mocks only |
| Not required | Azure access, another lab repository, a live incident, or a deployment |

A runbook records **how to decide safely** from evidence. It is not a list of powerful commands to try until an error disappears.
Use only the sanitized teaching incident and non-sensitive categories. No live retries or repairs happen in Lab 08.

## 1. Open the existing runbook

1. In desktop VS Code, confirm this private Lab 08 clone is the **Explorer** root and the status bar says `lab/capstone`.
2. Press **Ctrl+P**, enter `runbook.md`, and open the file from this clone.
3. If the requested runbook is missing, use **Explorer** → **New File** at the clone's root and enter that exact filename.
4. Read the starter's warnings before changing it. Keep their meaning, remove every `TODO`, and expand the note into a useful decision list.
5. Use **Ctrl+P** to reread `incidents/oidc-subject.md` if you need the difference between the sanitized configured and presented subjects.

## 2. Cover all five symptoms

| Symptom | Evidence to compare safely | Decision and owner |
| --- | --- | --- |
| OIDC subject mismatch | Exact authorized subject shape and failure stage; never a logged JWT | Identity owner reviews the exact trust correction; extra Contributor is not the fix |
| Workload RBAC failure | The denied workload operation and existing resource-group scope | Instructor reviews the smallest justified permission/configuration correction, never blanket Owner |
| Backend authorization | State-container data access and lease requirements, separately from workload access | State owner checks scoped Storage Blob Data Contributor and the intended backend boundary |
| Private DNS/network failure | Authorized trusted-runner route and private-name resolution category | Runner/network owner repairs the approved path; do not expose storage publicly |
| State lease or drift | Actual writer status for a lease; sanitized changed-resource summary for drift | Wait for the active owner, or make a reviewed drift decision before any mutation |

For the fifth row, distinguish **a lock that protects an active writer** from **a plan that reports differences**.
Only the instructor may consider stale-lock recovery after proving no writer remains. Elapsed time alone is not proof of a stale lock.
For drift, the correction needs a fresh plan and new independent approval in the designated live writer, not an automatic fix from this copy.

## 3. Write concrete recovery boundaries

Adapt this Markdown, preserving the two exact phrases and explaining their meaning:

```markdown
# Recovery decision runbook

Never force-unlock an active run. Identify the writer and ask its owner before
considering recovery; only the instructor can establish that no writer remains.
Use a reviewed correction for the smallest justified code or configuration change.

1. OIDC subject mismatch: the identity owner compares exact authorized claims
   and reviews the trust correction. Do not guess a name-only subject or log a JWT.
2. Workload RBAC: identify the denied operation and existing scope. Do not grant Owner.
3. Backend authorization: distinguish workload Reader from container data/lease writes.
   Check the intended state boundary; do not use storage keys or bypass locking.
4. Private DNS/network: check the approved runner path with its owner.
   Do not expose the backend publicly or move PR code onto the trusted runner.
5. Lease or drift: establish the lease holder, or inspect a sanitized drift summary.
   Make a reviewed code/configuration decision and require a fresh plan and new
   independent approval in the designated Lab 7 writer before remediation.

This is offline preparation, not proof that an Azure incident was repaired.
No credentials, raw state, live tokens, unlock commands, or widened permissions
belong in this runbook. Missing prerequisites remain blocked with the instructor.
```

1. Include all five categories, rather than one generic “retry” instruction.
2. Make clear who owns the next decision and which sensitive evidence must not be copied into an issue or Chat.
3. Keep the exact text `Never force-unlock an active run` with that capitalization and the lowercase phrase `reviewed correction`.
4. Press **Ctrl+S** and confirm the unsaved dot disappears.

## 4. Challenge the runbook without executing it

1. Open Copilot **Chat** → **Ask** and attach only the non-sensitive runbook if you want a second explanation.
2. Use this read-only prompt; do not authorize an implementation handoff:

```text
Review this offline recovery decision list without editing or running commands.
Identify missing distinctions among OIDC, workload RBAC, state data/leases,
private DNS, and drift. Flag any active unlock, broader privilege, public backend,
or automatic remediation. Keep every real correction instructor-reviewed.
Do not request credentials, raw tokens, state, or cloud tools.
```

3. Compare the response with the five-row table. Reject suggestions to disable locks, grant Owner, add secrets, or “test” a correction in Azure.
4. If you improve the wording, make the narrow edit and press **Ctrl+S** again before staging.

## 5. Review, commit, push, and read current feedback

1. Open **Source Control** and select the runbook under **Changes** to inspect the full diff.
2. Confirm only intended prose changed; no actual credentials, state content, permission changes, or unlock command was added.
3. Select the runbook's **+**, inspect it under **Staged Changes**, enter `lab: document safe recovery decisions`, and select **Commit**.
4. Select **...** → **Push**, or **Publish Branch** to the copy's existing `origin` if the branch has not been published.
5. Refresh your private copy's **Code** page, select `lab/capstone`, and open the newest commit to check the runbook and SHA.
6. Open **Actions** → **Lab checks** for this branch/SHA and inspect the actual **Test learner module** result. Unfinished step 3 compatibility tests may still be red; do not disable them.
7. Refresh the existing **Exercise** issue body for AgentAlvine's current feedback.

![Microsoft reference highlighting the Stage Changes plus button](../docs/images/vscode-stage.png)

*REFERENCE — Microsoft publisher example, CC BY 3.0 US. Its repository, branch, and files are examples; stage only your intended runbook. [Sources and attribution](../docs/images/NOTICE.md).*

## Expected result and precise gate

The pushed runbook contains both required safety statements and no `TODO`.
AgentAlvine's file gate checks those statements; it does not certify that all five categories were actually repaired or that a live system is safe.
The full five-symptom decision list is the teaching requirement, even though matching two strings is a narrower automated check.
No live retry, new identity, state access, manual progress command, run-ID submission, or evidence PR belongs in this step.

## Stuck?

- Required phrase missing: compare the exact spelling and case, then edit → save → stage → commit → push; do not modify the checker.
- Unable to tell RBAC from OIDC: locate the failure stage in the sanitized incident before proposing a fix.
- Lease uncertainty: record **blocked pending writer-owner confirmation**, not “safe to unlock.”
- Live access unavailable: that is not a blocker to this offline runbook; do not create or revisit another repository to finish it.

For a comparison after your own attempt, read [the recovery reference](../solutions/capstone/runbook.md) without importing live data or copying away your reasoning.

**Full beginner help:** [start-here.md](../docs/start-here.md) · [git-workflow.md](../docs/git-workflow.md) · [copilot-guide.md](../docs/copilot-guide.md) · [toolchain.md](../docs/toolchain.md) · [troubleshooting.md](../docs/troubleshooting.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified offline.** The recovery decision runbook checkpoint was accepted with the active-writer warning and reviewed-correction boundary.
- **Cycle B: verified offline.** The fresh private copy independently passed the same runbook checkpoint; no live unlock, RBAC change, or repair was claimed.
- The five-symptom lesson is broader than its two-phrase automated gate. A file pass is not proof that five real operational incidents were resolved.

See [simulation.md](simulation.md) for original evidence and whole-lab totals, not individual-activity test counts.

[Previous activity](activity-01.md) · [Review index](README.md) · [Next activity](activity-03.md)
