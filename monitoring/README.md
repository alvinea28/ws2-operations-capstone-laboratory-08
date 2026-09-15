# Monitoring companion: VNet event to SAMPLE issue

**Goal:** route Monitor notifications through Logic Apps to your private GitHub
repository; follow the [hands-on guide](../docs/monitor-feedback-hands-on.md).
Published Terraform AVMs provide connection/workflow; Monitor uses **native
AzureRM**, not an invented AVM. No Bicep/Sentinel.

## Files and ownership

- [main.tf](main.tf): connection AVM **0.1.0**, workflow AVM **0.1.2**, read AzAPI
  callback action, action group and exact-VNet Activity Log alert.
- [terraform.tf](terraform.tf): Terraform **1.16.1**, AzureRM **4.81.0**, AzAPI
  **2.12.0**, ModTM **0.3.5**, Random **3.9.1**; isolated from baseline **5.4.0**.
- [variables.tf](variables.tf): scope/destination inputs.
- [workflow.json](workflow.json): HTTPS POST/Common Alert `schemaId`/`data` shape;
  static SAMPLE `Create_issue` title/body, no raw payload, secure inputs/outputs.
- [tests/contract.tftest.hcl](tests/contract.tftest.hcl): two mock contracts,
  including wrong-RG VNet rejection.

This root owns the connection, workflow, action group and alert, **not RG/VNet**.
No live backend or baseline Lab 07 workflow connection is configured. Never reuse
workload state or install a second workload writer.

## Entry and your inputs

Complete [setup](../docs/start-here.md); before live work, [Azure setup](../docs/azure-setup.md)
and instructor confirmation of actual permissions, consent policy, region, costs
and cleanup ownership. Supply inputs privately; Azure guide variables do not
populate Terraform automatically.

| Input | Your value |
| --- | --- |
| `tenant_id`, `subscription_id`, `resource_group_name` | Your `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `WORKLOAD_RG` |
| `location` | Approved connector-supported region |
| `name` | Unique `ws2-monitor-` plus 2–26 lowercase alphanumeric/hyphen characters, first alphanumeric |
| `github_owner`, `github_repository` | Authorized private owner/repository names, no URL/token |
| `workload_resource_id` | Exact existing VNet ID in that subscription/RG, separately owned |

**Before testing**, the participant must open **Portal → existing Terraform-created
API connection → Edit API connection → Authorize**, consent with their own GitHub
account and save. Terraform creates it **without a token**, not already authorized.
Designer inspection is read-only; edit workflow JSON in Git/Terraform.

**State contains a sensitive URL:** read action `listCallbackUrl` obtains the
callback, with **no root output**. State/plans can retain it; `sensitive()` is not
encryption. Require approved encrypted/locked restricted state and encrypted plans.
Never commit/export state, plans, callbacks or credentials.

## Non-Azure validation

```powershell
# From the repository root: credential-free fmt -check, backend-disabled read-only init, schema validate and exactly 2 mocked contract cases (zero failures/errors/skips); not live delivery, original Exercise completion proof or AgentAlvine progress.
node scripts/check-companion.mjs
```

Use a clean credential-free authoring checkout with a reviewed profile lockfile,
no CLI login/cache, Azure/OIDC credentials or live backend initialization. From the
**Lab 08 clone root**, run separately and stop on errors:

```powershell
terraform -chdir=monitoring init -backend=false -lockfile=readonly -input=false
terraform -chdir=monitoring validate
terraform -chdir=monitoring test
```

**Why:** `-chdir=monitoring` selects this root; `init` downloads providers/modules.
`-backend=false` skips backend initialization, `-lockfile=readonly` prevents lock
changes, `-input=false` prevents prompts. Downloads need registries, not Azure.
`validate` checks schemas/configuration; `test` uses mocked plans/synthetic inputs.
Missing/incompatible locks mean stop, not upgrade or bypass readonly.

**Prior authoring result:** initialization/validation and **2 mock cases passed**;
not rerun for this docs edit. These are not OAuth/routing/live proof or workshop
completion. Require executed cases, not skips/zero-test success.

## Separately approved LIVE lifecycle

The instructor designates the **approved Terraform root/state** and protected
writer/backend procedure. `plan` with `-out` saves a proposal for independent human
review; protected `apply` consumes that exact reviewed plan. Offline initialization
does not configure live state or authorize apply.

After owner authorization/test approval, test the **saved action group** in Portal.
A SAMPLE routing issue is not detection; an approved benign VNet write through
its separate writer needs matching event/alert evidence. Use the same SAMPLE triage.

Cleanup: fresh full `plan -destroy` proposes all owned resources; `-out` saves it.
Independent review precedes protected apply in the same state. Remove only the four
owned Azure resources; destroy the VNet through its **separate original root/writer**.
No Portal deletion, targets, RG/backend/shared deletion or state removal. Verify
absence privately; uncertain cleanup stays open.

### Full cleanup commands — approved writer only

**Future live use, not authoring/PR CI:** run from the clone root only inside the
approved monitoring writer with its original initialized backend/workspace and
private inputs. Retain its plan/apply identities, concurrency, independent approval
and encrypted saved-plan handling. These commands do not create that protected route.

1. Protected **plan stage**:

  ```powershell
  terraform -chdir=monitoring plan -destroy -input=false '-out=cleanup.tfplan'
  if ($LASTEXITCODE -ne 0) { throw 'Destroy plan failed; stop.' }
  ```

  **Meaning:** `-chdir` selects this root, `-destroy` proposes all owned resource
  removals, `-input=false` rejects missing-input prompts and `-out` saves the exact
  plan here. It must remove the alert, action group, workflow and API connection,
  **not the separately owned VNet or RG**. Plan/state can contain the callback URL.
2. **Stop for independent review** of the encrypted, bound plan. Never expose the
  plan/callback or replan after approval. Only the protected apply stage may
  decrypt and consume those exact reviewed bytes:

  ```powershell
  terraform -chdir=monitoring apply -input=false cleanup.tfplan
  if ($LASTEXITCODE -ne 0) { throw 'Cleanup incomplete; keep the exercise open.' }
  ```

  **Meaning:** consumes the saved plan **without a second approval prompt**, so
  the external protected approval is mandatory.
3. Authorized state verification:

  ```powershell
  terraform -chdir=monitoring state list
  if ($LASTEXITCODE -ne 0) { throw 'State verification failed; stop.' }
  ```

  **Expected:** no managed monitoring entries and separately verified absence of
  all four owned resources in Azure. Empty state alone is insufficient. Clean the
  VNet through its original separate writer; retain RG/backend/shared resources.
