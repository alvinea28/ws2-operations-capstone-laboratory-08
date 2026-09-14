# Lab 08 · Activity 03 — Add app without breaking the existing outputs

[Review index](README.md) · [Previous activity](activity-02.md) · [Next activity](activity-04.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress. Lab 08 completes offline; optional later release/live work is a separate outcome.

<!-- FULL-WS-LESSON:START -->
# Lab 08 · Step 3 — Add the app caller and a compatible prefix output

| Before you start | This step |
| --- | --- |
| Goal | Prepare an additive v1.1.0 change without breaking the v1.0.0 contract |
| Start / working branch | Continue `lab/capstone` in this independent private copy |
| Edit | [module/outputs.tf](../module/outputs.tf) and [examples/dev.tfvars.example](../examples/dev.tfvars.example) |
| Preserve | `vnet_id`, `subnet_ids`, `nsg_id`, `association_ids`; `web`/`data` instance keys and resource addresses |
| Add | `subnet_address_prefixes` output and caller key `app` with `10.42.3.0/24` |
| Full checker | [scripts/check-learner.mjs](../scripts/check-learner.mjs), not only a direct module test |
| Toolchain | Node **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**, provider-mocked plans only |

The complete module already composes the security child and iterates the caller's subnet map.
Adding an input map entry should add one subnet and association, not rename or replace `web` and `data`.
This is a **release candidate change**, not publication of a real `v1.1.0` tag or an Azure deployment.

## 1. Keep the four original outputs intact

1. Open the private Lab 08 clone in VS Code; verify the status bar says `lab/capstone`.
2. Press **Ctrl+P**, enter `module/outputs.tf`, and open the supplied file.
3. Read all four original output blocks before changing anything. Keep their names, value expressions, and meanings unchanged.
4. If this supplied module file is missing, stop and report an incomplete package; do not create a one-output replacement that silently loses the original contract.
5. After the original blocks, append this complete HCL output, preserving two-space indentation:

```hcl
output "subnet_address_prefixes" {
  description = "IPv4 prefix lists keyed by stable subnet names; added in v1.1.0."
  value       = tomap({ for name, subnet in azurerm_subnet.this : name => tolist(subnet.address_prefixes) })
}
```

6. Check the expression derives values from `azurerm_subnet.this` and `subnet.address_prefixes`, not a hardcoded map of three example subnets.
7. Press **Ctrl+S**. Do not rename resources, alter instance keys, add moved blocks without a real address change, or modify the security child.

| Output | Contract to preserve or add |
| --- | --- |
| `vnet_id` | Original VNet resource ID |
| `subnet_ids` | Original map of subnet resource IDs by stable caller name |
| `nsg_id` | Original composed NSG ID |
| `association_ids` | Original association map, with the same stable keys as the subnet map |
| `subnet_address_prefixes` | New map of prefix lists derived from the actual subnet resources, including unchanged two-subnet callers |

## 2. Add app in the actual caller example

1. Press **Ctrl+P**, enter `examples/dev.tfvars.example`, and open the supplied caller example.
2. If the example is missing, report the incomplete package instead of inventing required inputs; this task must preserve its existing name, RG, location, address space, and tags.
3. Find the existing `subnets` map. Replace its instructional comment with the `app` entry while keeping `web` and `data` exactly as below:

```hcl
subnets = {
  web  = { address_prefixes = ["10.42.1.0/24"] }
  data = { address_prefixes = ["10.42.2.0/24"] }
  app  = { address_prefixes = ["10.42.3.0/24"] }
}
```

4. Preserve every other supplied example input and required tag. Do not paste a second `subnets` assignment or replace the entire file with only this fragment.
5. Press **Ctrl+S**. The `app` entry must be active HCL, not a comment that only mentions the requested address.
6. Do not hardcode `app` inside the module; the existing composition must pass the expanded ID map to the security child automatically.

**These CIDRs and RG labels are synthetic fixtures.** The instructor assigns real sandbox inputs only in the chosen live writer. No actual cloud values are needed here.

## 3. Run the complete offline compatibility checker

1. Select **Terminal** → **New Terminal** and verify the prompt is this clone's root, not its module subfolder or another lab.
2. Run the supplied full helper:

```powershell
node scripts/check-learner.mjs
```

3. Let the command finish and inspect its complete result, not just one success line before a later failure.
4. In Windows PowerShell, inspect the exit code immediately after it returns:

```powershell
$LASTEXITCODE
```

5. Expect `0` only after the entire helper succeeds. On macOS/Linux, the corresponding immediate shell check is `echo $?`.

The helper stages your actual module in a disposable local root, adds the supplied compatibility cases, checks formatting, disables backend initialization, keeps the provider lock read-only, validates, and runs mocks.
It then tests the **actual example file separately**, so test-file variable overrides cannot hide an unchanged caller.
No Azure credentials, remote state, live provider calls, local apply, or local destroy are involved. A first provider download can require internet access.

| Required execution | Expected checks when successful |
| --- | --- |
| Full staged module suite | **46** passing provider-mocked cases: the baseline/rejection/wiring cases plus two compatibility cases |
| `original_two_subnets` | The additive prefix map works for unchanged two-subnet inputs; old maps remain intact |
| `named_app_subnet_addition` | All three keys and associations exist; original fixture IDs stay stable; `app` retains the safe outbound default |
| Separate `actual_app_example` | **1** passing example case using the real example input file, including the `app` prefix and associations |
| Overall process | Successful completion after both suites; no failed, errored, skipped, or zero-test success |

The printed **46**-case summary alone is not proof the later example check succeeded; the helper asserts that separate result and must exit successfully.
Running only a direct test in the module folder omits the helper's extra compatibility and actual-example validation. Do not substitute it for the full check.

## 4. Inspect and publish only the compatible change

1. Open **Source Control**; select the output file under **Changes** and review its entire diff.
2. Verify all four original outputs remain and only the additive fifth output was appended.
3. Select the example's diff and verify only the intended `app` addition replaced the starter comment; `web`, `data`, tags, and other inputs remain.
4. Do not stage provider-lock changes, test removals, local caches, generated disposable roots, state, plans, or unrelated files.
5. Select **+** for the two intended files, inspect **Staged Changes**, enter `lab: add compatible app prefix output`, and select **Commit**.
6. Select **...** → **Push**, or **Publish Branch** to the existing own-copy `origin` if still unpublished.
7. Refresh GitHub **Code**, select `lab/capstone`, and open the latest commit. Compare its SHA and both changes with your local work.
8. Open **Actions** → **Lab checks** → the run at that SHA → **Test learner module**, and inspect the actual full-helper result.
9. Refresh the existing **Exercise** issue body after push/check completion; the next task records the handover, not a fabricated release.

![Microsoft reference showing the current branch indicator](../docs/images/vscode-branch.png)

*REFERENCE — Microsoft publisher example, CC BY 3.0 US. Its `main` label and repository are examples; your task branch is `lab/capstone`. [Sources and attribution](../docs/images/NOTICE.md).*

## Expected result and precise gate

The output file contains all four original output declarations plus the real `subnet_address_prefixes` expression using `azurerm_subnet.this` and `subnet.address_prefixes`, with no `TODO`.
The actual example contains active `web`, `data`, and `app` entries with `10.42.1.0/24`, `10.42.2.0/24`, and `10.42.3.0/24` respectively.
AgentAlvine checks those file contracts; final current-revision **Test learner module** CI proves compatibility and wiring. Matching text alone cannot prove that the tests ran.

## Stuck?

- Formatting error: correct only the named task file's two-space HCL formatting and save; preserve locks and assertions.
- Missing output for the old caller: derive the prefix map from every actual subnet, not only `app`.
- Missing example case: use the full root helper and ensure `app` is active in the actual example, not only a test override.
- Association mismatch: preserve the existing subnet-to-child wiring and investigate the diff; do not replace outputs with fixture IDs.
- Tool or provider mismatch: consult [toolchain.md](../docs/toolchain.md); never upgrade or regenerate the supplied lock to hide it.

**Full beginner help:** [start-here.md](../docs/start-here.md) · [git-workflow.md](../docs/git-workflow.md) · [copilot-guide.md](../docs/copilot-guide.md) · [toolchain.md](../docs/toolchain.md) · [troubleshooting.md](../docs/troubleshooting.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified offline.** The additive prefix output and active `app` example checkpoint was accepted while preserving the original outputs and stable `web`/`data` keys.
- **Cycle B: verified offline.** The fresh private copy independently completed the compatible-code activity and full offline validation route.
- This was an additive candidate, not a published reviewed `v1.1.0` release or a deployed subnet. Optional release/live work remained pending and was not required to finish Lab 08.

See [simulation.md](simulation.md) for original full-helper evidence and whole-lab totals. The lesson's expected execution table is not a new or per-activity historical test-count claim.

[Previous activity](activity-02.md) · [Review index](README.md) · [Next activity](activity-04.md)
