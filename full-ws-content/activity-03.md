# Lab 08 · Activity 03 — Add app without breaking the existing outputs

[Review index](README.md) · [Previous activity](activity-02.md) · [Next activity](activity-04.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress. Lab 08 completes offline; optional later release/live work is a separate outcome.

<!-- FULL-WS-LESSON:START -->
# Lab 08 · Step 3 — Add the app caller and a compatible prefix output

**Goal:** Prepare an additive v1.1.0 candidate without breaking v1.0.0 callers.

| Working context | Selection |
| --- | --- |
| Branch | Continue `lab/capstone` in your private Lab 08 clone |
| Edit | [module/outputs.tf](../module/outputs.tf) and [examples/dev.tfvars.example](../examples/dev.tfvars.example) |
| Preserve | `vnet_id`, `subnet_ids`, `nsg_id`, `association_ids`; stable `web`/`data` keys and resource addresses |
| Tools | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; provider-mocked plans |

No earlier lab or Azure access is required. The supplied module already composes security and iterates the subnet map. This candidate is **not** a published release or deployed subnet.

## Do

### 1. Append one output

Confirm the clone/branch in VS Code; open the output file with **Ctrl+P**. Keep all four original blocks, expressions and meanings. Append:

```hcl
output "subnet_address_prefixes" {
  description = "IPv4 prefix lists keyed by stable subnet names; added in v1.1.0."
  value       = tomap({ for name, subnet in azurerm_subnet.this : name => tolist(subnet.address_prefixes) })
}
```

**Why:** The `for` expression derives every prefix from `azurerm_subnet.this`, keyed by stable caller name; `tolist`/`tomap` preserve the output's collection shape. Do not hardcode example values, rename resources, add unnecessary moved blocks or change the security child.

### 2. Add app to the actual caller

Open the example with **Ctrl+P**. Replace only its `subnets` map/comment with this complete map, keeping all other name/RG/location/address-space/tag inputs:

```hcl
subnets = {
  web  = { address_prefixes = ["10.42.1.0/24"] }
  data = { address_prefixes = ["10.42.2.0/24"] }
  app  = { address_prefixes = ["10.42.3.0/24"] }
}
```

**Why:** An active `app` caller entry adds one subnet and association without replacing `web`/`data`. Existing composition passes the expanded IDs to the child; do not hardcode `app` inside the module or duplicate the assignment. CIDRs/RG labels are synthetic fixtures, not approved live inputs. Save both files.

### 3. Run the full offline checker

In **Terminal → New Terminal**, PowerShell at the clone root—not the module folder:

```powershell
node scripts/check-learner.mjs
$LASTEXITCODE
```

**Why:** `node` runs the [complete helper](../scripts/check-learner.mjs); `$LASTEXITCODE` immediately displays its native exit status (`0` means success). The helper stages your actual module in a disposable root, checks formatting, initializes with backend disabled/read-only provider lock, validates, and runs mocks. It then tests the **actual example separately**, preventing test overrides from hiding an unchanged caller. Internet may be needed for provider downloads, never Azure credentials/state.

| Required execution | Expected result |
| --- | --- |
| Full staged suite | **46** passing provider-mocked cases, including baseline/rejection/wiring and two compatibility cases |
| `original_two_subnets` | New prefix map supports old callers; original outputs remain |
| `named_app_subnet_addition` | Three stable keys/associations, original fixture IDs, safe outbound default |
| Separate `actual_app_example` | **1** passing case from the real example, including app prefix/associations |

The **46** summary alone is insufficient: require successful completion after the separate **1** case, no failed/errored/skipped/zero-test success. Direct module testing omits these extra checks. No local apply/destroy or live provider calls.

### 4. Publish only the compatible change

| Where | Action |
| --- | --- |
| VS Code | Inspect both saved diffs; **+** stages only the two files; inspect **Staged Changes** |
| Source Control | Commit `lab: add compatible app prefix output`; **Push**, or first **Publish Branch** to existing `origin` |
| GitHub | Verify newest branch SHA; inspect **Lab checks → Test learner module** at that SHA; refresh your Exercise |

![Microsoft reference showing the current branch indicator](../docs/images/vscode-branch.png)

*REFERENCE — Microsoft, CC BY 3.0 US; your branch is `lab/capstone`, not example main. [Attribution](../docs/images/NOTICE.md).*

**Expected / gate:** All four original outputs plus the real derived `subnet_address_prefixes`; active `web`/`data`/`app` with the shown prefixes; no `TODO`. AgentAlvine checks file contracts; actual current-revision CI, not matching text, verifies execution.

**Recovery:** Missing supplied file: report a package blocker. Fix two-space formatting, resource-derived maps or actual caller entry; preserve locks, tests, IDs and child wiring. Do not stage caches/state/plans or upgrade providers to hide failure. Use [toolchain help](../docs/toolchain.md).

**Next:** [Step 4: offline handover and final gate](activity-04.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified offline.** The additive prefix output and active `app` example checkpoint was accepted while preserving the original outputs and stable `web`/`data` keys.
- **Cycle B: verified offline.** The fresh private copy independently completed the compatible-code activity and full offline validation route.
- This was an additive candidate, not a published reviewed `v1.1.0` release or a deployed subnet. Optional release/live work remained pending and was not required to finish Lab 08.

See [simulation.md](simulation.md) for original full-helper evidence and whole-lab totals. The lesson's expected execution table is not a new or per-activity historical test-count claim.

[Previous activity](activity-02.md) · [Review index](README.md) · [Next activity](activity-04.md)
