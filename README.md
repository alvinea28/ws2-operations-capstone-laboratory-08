# Laboratory 08 · Operations, recovery and compatible upgrade

**Public source template (not the clone URL after copying):** [alvinea28/ws2-operations-capstone-laboratory-08](https://github.com/alvinea28/ws2-operations-capstone-laboratory-08) · **Recommended order:** 08 of 08 · **Time:** 60–90 minutes

**Goal:** Diagnose the sanitized incident, write safe recovery decisions, add a compatible output/app caller and pass offline checks. Complete module/example supplied; **no earlier lab, Azure account, release, merge or deployment required**.

> [!IMPORTANT]
> All four original checkpoints remain offline. Public templates are inert; this copy never becomes a state writer. Optional later live work uses the **same approved private Lab 07 writer**, with a reviewed release/exact pin, fresh independently approved deployment, followup and mandatory full cleanup—not self-approval.

## Start here — five actions

1. **Install / account:** follow [toolchain](docs/toolchain.md) for Git, desktop VS Code, Node **24.16.0**, Terraform **1.16.1**; AzureRM **5.4.0** is pinned. GitHub newcomer: **Sign up**, verify email, sign in and accept any instructor invitation.
2. **Copy once:** use **COPY EXERCISE** below; keep a unique name ending `-laboratory-08`. Already in your private copy? Do not copy again; keep its Exercise.
3. **Clone:** copy **your copy's Code → HTTPS URL**. In VS Code: **Ctrl+Shift+P → Git: Clone**, paste it, authorize the correct account in the trusted browser and choose a parent folder. macOS uses **Cmd**.
4. **Open / accounts:** **Open** the clone; trust only it. Explorer must show this repository, not its parent/ZIP. Check **Accounts → GitHub Copilot**/seat; configure local Git authorship using [illustrated setup](docs/start-here.md). Authorship, Git credentials, browser login and Copilot entitlement differ.
5. **Check:** open **Terminal → New Terminal** at this clone's root:

```powershell
node scripts/doctor.mjs
```

**Why:** `node` runs the supplied [read-only doctor](scripts/doctor.mjs), checking local tools/context—not sign-in, a seat or Azure authorization. Resolve failures before the first edit.

![Microsoft reference: cloning from GitHub in VS Code](docs/images/vscode-clone-github.png)

*REFERENCE — Microsoft, CC BY 3.0 US; not your account/repository. [Attribution](docs/images/NOTICE.md).*

<!-- AGENTALVINE:START -->
## Copy this exercise once

[![Copy exercise](.github/images/copy-exercise.svg)](https://github.com/new?template_owner=alvinea28&template_name=ws2-operations-capstone-laboratory-08&owner=%40me&name=my-ws2-operations-capstone-laboratory-08&visibility=private)

Select the intended Owner, keep **Private**, leave **Include all branches** off, and create the copy. Its own AgentAlvine issue will appear automatically.
<!-- AGENTALVINE:END -->

## Expected result / next

Refresh **your copy's Exercise link** and follow its current task on `lab/capstone`. AgentAlvine updates the **same issue body** from real work/checks. Final grading retains **46 full-suite + 1 actual-example mock cases**, current learner CI and the handover. No manual evidence commands or checkbox edits.

[All four activities and historical outcomes](full-ws-content/README.md) · [Source Exercise #1: read-only Preview, zero learner progress](https://github.com/alvinea28/ws2-operations-capstone-laboratory-08/issues/1). Neither is a new learner's grade or live proof.

**Optional approved-sandbox extension:** [Monitor → Logic Apps → GitHub hands-on](docs/monitor-feedback-hands-on.md); separate from offline checkpoints, with no live execution claimed.

**Recovery:** [Setup](docs/start-here.md) · [Git actions](docs/git-workflow.md) · [Troubleshooting](docs/troubleshooting.md). [Azure inputs/login](docs/azure-setup.md) are optional account preparation, not an offline prerequisite or provisioning permission. See [handover](.github/steps/04.md) for pending live work and retained resources.

[All eight numbered laboratories](https://github.com/alvinea28/ws2-workshop-catalogue) · [MIT code license](LICENSE) · [Screenshot licenses](docs/images/NOTICE.md)
