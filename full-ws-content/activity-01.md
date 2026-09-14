# Lab 08 · Activity 01 — Diagnose the sanitized OIDC incident

[Review index](README.md) · [Setup](00-start-here.md) · [Next activity](activity-02.md) · [Simulation evidence](simulation.md)

> [!NOTE]
> **Review copy, not a second progress tracker.** The complete canonical lesson follows. Learners follow the live **Exercise issue in their own private copy**, opened from that copy's README; AgentAlvine updates the same issue body. The public source preview awards no learner progress. Lab 08 completes offline; optional later release/live work is a separate outcome.

<!-- FULL-WS-LESSON:START -->
> [!IMPORTANT]
> **Already reading this in an Exercise issue or your own private copy? The copy is already created.** Do not create another repository. Skip only the copy-creation substeps below; continue with cloning/opening **this existing copy**, account checks and the first edit. If Git or desktop VS Code is not installed, use [the installation guide](../docs/toolchain.md) before cloning.

# Lab 08 · Step 1 — Diagnose the sanitized OIDC incident

> [!IMPORTANT]
> Lab 08 is independently usable: this copy includes a complete v1.0.0 module, a sanitized incident, and offline compatibility checks. No earlier repository, Azure account, or completed Lab 07 is required. Numbers recommend a learning order, not a dependency chain.

| Before you start | This step |
| --- | --- |
| Goal | Distinguish an exact-subject authentication mismatch from an RBAC problem |
| Start / working branch | Your actual default branch, normally `dev` → `lab/capstone` |
| Read | [incidents/oidc-subject.md](../incidents/oidc-subject.md) |
| Edit | [incidents/selected.json](../incidents/selected.json) only |
| Supplied baseline | [module/main.tf](../module/main.tf), [module/outputs.tf](../module/outputs.tf), [examples/dev.tfvars.example](../examples/dev.tfvars.example) |
| Tools | Node.js **24.16.0**, Terraform **1.16.1**, AzureRM **5.4.0**; provider-mocked checks only |

## 1. Create your own private copy in the browser

1. Open GitHub and select your profile-picture menu to confirm the personal account assigned for the workshop. Accept any instructor invitation using that account.
2. Open [the public Lab 08 template](https://github.com/alvinea28/ws2-operations-capstone-laboratory-08).
3. Select **COPY EXERCISE**, or **Use this template** → **Create a new repository**.
4. In **Owner**, select your account or the instructor-assigned organization; enter a unique name ending in `laboratory-08`.
5. Select **Private**, leave **Include all branches** unchecked unless instructed otherwise, then select **Create repository**.
6. Confirm the resulting owner/name and **Private** badge. This is your working copy; do not edit or clone the public template for participant work, fork it, or use a ZIP.
7. Refresh after the copy finishes appearing; open its **Exercise** link or **Issues** → the active **AgentAlvine** issue. Keep its body open as the progress display.

## 2. Clone that private copy and open only its folder

1. In your own copy select **Code** → the green **Code** button → **HTTPS** and copy its credential-free clone URL.
2. Open desktop VS Code, press **Ctrl+Shift+P** → **Git: Clone**, paste the own-copy URL, and press **Enter**.
3. If choosing **Clone from GitHub**, select the correct private Lab 08 copy, not the public source or any publisher example repository.
4. For an expected sign-in request, select **Allow**; inspect the trusted GitHub browser authorization page and confirm the correct personal account before authorizing VS Code or Git Credential Manager.
5. Switch to the invited account if the wrong one appears; complete authorization and select **Open Visual Studio Code** when offered. Never paste a token or password into a terminal or Chat.
6. Choose a normal local **parent folder** as **Repository Destination**. When Git finishes creating the clone's child folder, select **Open**.
7. Trust only this known repository at **Workspace Trust**; do not trust the whole parent or all future repositories.
8. Inspect **Explorer**: its root must be **this clone**, not the parent containing several labs, a ZIP folder, or `github.dev`. Use **File** → **Open Folder...** to correct it.

![Microsoft reference showing the GitHub clone picker](../docs/images/vscode-clone-github.png)

*REFERENCE — Microsoft publisher example, CC BY 3.0 US. Its repository names are examples, not your private Lab 08 copy. [Sources and attribution](../docs/images/NOTICE.md).*

## 3. Check editor accounts, authorship, and the doctor

1. Select VS Code **Accounts** → **Sign in with GitHub to use GitHub Copilot**, if offered, and use the trusted browser flow with your workshop personal account.
2. Select **Accounts** → **Manage Extension Account Preferences...** and choose that account for Copilot. Check Copilot's status and have the instructor confirm the assigned **Copilot seat**.
3. Use [start-here.md](../docs/start-here.md) to configure repository-local Git author name/email. Those values record authorship; they do not sign you in or grant a seat.
4. Select **Terminal** → **New Terminal**, check this clone's root in the prompt, and run:

```powershell
node scripts/doctor.mjs
```

5. Read every result. If the doctor is absent, the root is wrong, or versions differ, follow [toolchain.md](../docs/toolchain.md) or ask the instructor; do not generate a replacement or silently skip the check.

The doctor is read-only and cannot prove browser authorization, repository write rights, Copilot entitlement, peer review, or cloud readiness. On macOS use **Cmd** in place of **Ctrl** for editor shortcuts; Linux uses **Ctrl**.

## 4. Create the branch and read the sanitized fixture

1. In GitHub **Code** → branch dropdown, identify the branch marked **default**, normally `dev`.
2. In VS Code **Source Control**, confirm a clean working tree; select that default branch and **...** → **Pull**.
3. Press **Ctrl+Shift+P** → **Git: Create Branch...**, enter `lab/capstone`, and confirm the status bar.
4. Press **Ctrl+P**, enter `incidents/oidc-subject.md`, and open the supplied incident. Read it before editing the answer.
5. Identify the failure stage: **OIDC exchange before Terraform backend initialization**, with `AADSTS700213` and no matching federated identity record.
6. Compare the two sanitized strings exactly. These are fixture text, not actual tokens or identifiers from your account:

```text
Old configured subject: repo:team/network:environment:dev-plan
Presented format:      repo:team@12345/network@67890:environment:dev-plan
```

7. Notice the immutable owner/repository identifiers in the presented format. Do not assume every live repository uses these sample values or a name-only subject.
8. Explain why broader **Contributor** access cannot repair failure to match the authentication subject. Authentication must succeed before workload authorization is relevant.

> [!WARNING]
> The incident is explicitly a fictional, sanitized teaching fixture, not a live run. Do not log a JWT, request raw claims, modify Entra federation, change Azure permissions, or use Copilot cloud tools in this copy. The identity owner would review exact authorized claims before a real correction.

## 5. Save the structured diagnosis

1. Press **Ctrl+P**, enter `incidents/selected.json`, and open the answer file.
2. If this requested answer file is missing, select **Explorer** → **New File** at the clone's root and enter that exact path. Missing fixture or module files are package problems, not invitations to invent evidence.
3. Replace the two unfinished values with this exact JSON. Use double quotes and no comments or trailing commas:

```json
{
  "cause": "subject-mismatch",
  "fix": "match-exact-subject"
}
```

4. Press **Ctrl+S**. Confirm the editor reports valid JSON and the unsaved dot disappears.
5. If helpful, open Copilot **Chat** → **Ask**, attach only the sanitized incident, and ask for a read-only comparison of the strings and why extra RBAC does not solve it. Decline edits, commands, credential requests, or cloud tools.

## 6. Inspect the diff, commit, and publish the branch

1. Open **Source Control**; select the JSON under **Changes** and inspect its entire diff.
2. Select **+** to stage just that file, inspect **Staged Changes**, enter `lab: diagnose exact OIDC subject mismatch`, and select **Commit**.
3. Select **Publish Branch** to your private copy's existing `origin`; later commits use **...** → **Push**. Do not create another repository with **Publish to GitHub** or force-push.
4. Refresh your copy's **Code** page, select `lab/capstone`, and open the newest commit. Confirm the two JSON values and SHA match what you pushed.
5. Open **Actions** → **Lab checks** at that branch/SHA, and inspect **Test learner module** rather than an older run.
6. At this early step, compatibility CI may still fail because the additive output and `app` example are intentionally unfinished until step 3. Do not remove the tests to turn the starter green.
7. Refresh the existing **Exercise** issue body. AgentAlvine can accept this diagnosis even while later compatibility work remains unfinished.

## Expected result and precise gate

The JSON parses and has exactly the required values for `cause` and `fix`: `subject-mismatch` and `match-exact-subject`. Both are nonempty, supported structured answers, not free-form guessed descriptions.
The pushed diagnosis advances only this offline checkpoint. Matching a fixture cannot complete any live plan, apply, approval, or cleanup gate in Lab 07.
No PR, manual check command, run-ID entry, evidence PR, or edited progress checkbox is required here.

## Stuck?

- JSON error: check double quotes, spelling, commas, and the actual saved file in this clone; do not paste Markdown fences into the JSON file.
- Wrong branch or missing push: inspect the status bar and current GitHub branch; saving alone does not send a commit to GitHub.
- Missing exercise: inspect **Actions** → **AgentAlvine**, then refresh the existing issue body; do not manufacture a second exercise.
- Unsure about OIDC: compare [the diagnosis reference](../solutions/capstone/incidents/selected.json) and the supplied sanitized fixture, not production tokens.

**Full beginner help:** [start-here.md](../docs/start-here.md) · [git-workflow.md](../docs/git-workflow.md) · [copilot-guide.md](../docs/copilot-guide.md) · [toolchain.md](../docs/toolchain.md) · [troubleshooting.md](../docs/troubleshooting.md).
<!-- FULL-WS-LESSON:END -->

## Original Cycle A/B outcome — 2026-09-08

- **Cycle A: verified offline.** The structured `subject-mismatch` / `match-exact-subject` diagnosis was accepted from the sanitized incident.
- **Cycle B: verified offline.** The fresh private copy independently passed the same diagnosis checkpoint without Azure access or an earlier lab.
- This was a fictional teaching incident, not proof of live federation repair, successful sign-in, or an actual OIDC exchange. Both cycles later completed the four offline activities.

See [simulation.md](simulation.md) for original evidence and whole-lab totals; no test count is assigned to this individual activity.

[Review index](README.md) · [Next activity](activity-02.md)
