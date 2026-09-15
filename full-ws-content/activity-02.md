# Lab 08 · Activity 02 — Write a safe recovery decision

[Review index](README.md) · [Previous activity](activity-01.md) · [Next activity](activity-03.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress. Lab 08 completes offline; optional later release/live work is a separate outcome.

<!-- FULL-WS-LESSON:START -->
# Lab 08 · Step 2 — Write a recovery decision, not an unsafe fix

**Goal:** Route five failure categories to their owner and a reviewed correction—not trial-and-error cloud commands.

| Working context | Selection |
| --- | --- |
| Branch | Continue `lab/capstone` in your private Lab 08 clone |
| Edit | [runbook.md](../runbook.md) only |
| Read | [incidents/oidc-subject.md](../incidents/oidc-subject.md) and your [incidents/selected.json](../incidents/selected.json) |
| Tools | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; offline only |

No earlier lab, Azure account, actual incident or deployment is required. This is a decision record; no live retries or repairs happen here.

## Do

### 1. Identify the failure stage

Confirm the clone/branch in VS Code, then **Ctrl+P** to open the runbook and incident. Authentication (OIDC) precedes workload authorization (RBAC). Backend data/lease permissions and private connectivity are separate again. Remove `TODO` text without removing the starter's safety meaning.

### 2. Write a complete decision list

Adapt this Markdown, preserving the two required phrases exactly:

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

**Why:** These categories need different owners: identity, workload, state and runner/network owners. State access requires container-scoped **Storage Blob Data Contributor** even when workload access is Reader. Elapsed time does not prove a stale lease; only the instructor may consider recovery after proving no writer remains. Drift is a difference to review, not permission to unlock or auto-apply.

### 3. Challenge the reasoning without executing it

Optionally attach only the non-sensitive runbook in Copilot **Chat → Ask**, using:

```text
Review this offline recovery decision list without editing or running commands.
Identify missing distinctions among OIDC, workload RBAC, state data/leases,
private DNS, and drift. Flag any active unlock, broader privilege, public backend,
or automatic remediation. Keep every real correction instructor-reviewed.
Do not request credentials, raw tokens, state, or cloud tools.
```

**Why:** This requests a read-only critique, not authorization. Reject suggestions to grant Owner, expose storage, add credentials, disable locks, use PR code on a trusted runner or test the fix in Azure.

### 4. Publish only the runbook

| Where | Action |
| --- | --- |
| VS Code | **Ctrl+S**; inspect full diff; **+** stages only the runbook; inspect **Staged Changes** |
| Source Control | Commit `lab: document safe recovery decisions`; **Push**, or first **Publish Branch** to existing `origin` |
| GitHub | Compare newest branch SHA; inspect **Lab checks → Test learner module**; refresh the existing Exercise body |

![Microsoft reference highlighting the Stage Changes plus button](../docs/images/vscode-stage.png)

*REFERENCE — Microsoft, CC BY 3.0 US; stage only your intended file. [Attribution](../docs/images/NOTICE.md).*

**Expected / gate:** The pushed file contains `Never force-unlock an active run` and `reviewed correction`, with no `TODO`. Preserve capitalization here. The automated two-phrase gate is narrower than the five-category teaching requirement; neither proves real incident repair. Step 3 compatibility CI may remain red until its edits are finished.

**Recovery:** Missing phrase: correct spelling/case and push again, not the checker. Uncertain lease: record **blocked pending writer-owner confirmation**. Compare the [recovery reference](../solutions/capstone/runbook.md) or [troubleshooting](../docs/troubleshooting.md). No manual progress command, run ID or evidence PR.

**Next:** [Step 3: compatible offline fix](activity-03.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified offline.** The recovery decision runbook checkpoint was accepted with the active-writer warning and reviewed-correction boundary.
- **Cycle B: verified offline.** The fresh private copy independently passed the same runbook checkpoint; no live unlock, RBAC change, or repair was claimed.
- The five-symptom lesson is broader than its two-phrase automated gate. A file pass is not proof that five real operational incidents were resolved.

See [simulation.md](simulation.md) for original evidence and whole-lab totals, not individual-activity test counts.

[Previous activity](activity-01.md) · [Review index](README.md) · [Next activity](activity-03.md)
