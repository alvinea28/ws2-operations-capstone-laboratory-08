# Laboratory 08 · Operations, recovery and compatible upgrade

**Public source template (not the clone URL after copying):** [alvinea28/ws2-operations-capstone-laboratory-08](https://github.com/alvinea28/ws2-operations-capstone-laboratory-08) · **Recommended order:** 08 of 08 · **Time:** 60–90 minutes

> [!NOTE]
> **This laboratory is independent.** No earlier repository or Azure deployment required. The incident is sanitized and the complete module is supplied. Any later live follow-up belongs to one instructor-designated delivery copy, not to this lab.
> New to the tools? The complete [illustrated first-time setup](docs/start-here.md) is included here—no other lab is required.

## Start here — copy, clone, open and sign in

**Before cloning:** if Git or desktop VS Code is not installed, complete [the official installation steps](docs/toolchain.md), restart VS Code, then continue below. If you have no GitHub account yet, choose **Sign up** on GitHub and verify your email as shown in [Start here](docs/start-here.md).

1. **Browser:** sign in to your intended personal GitHub account. If the instructor assigned an organization, accept its invitation using that personal account.
2. **GitHub:** create your own **Private** copy below, retaining **-laboratory-08** at the end of its name. If you already made a copy, do not copy again.
3. **Desktop VS Code:** press **Ctrl+Shift+P** (macOS **Cmd+Shift+P**) → **Git: Clone** → paste **your own copy's HTTPS URL**, not this public source URL. Complete the trusted browser sign-in with the correct account.
4. **Open the clone:** choose a local parent folder, then **Open** the newly cloned repository. Trust only the known workshop copy. Explorer must show this repository, not a parent with multiple labs or a browser-only virtual workspace.
5. **Accounts:** verify GitHub and **GitHub Copilot** sign-in/seat. Git commit name/email is not sign-in. Use [account and context screenshots](docs/copilot-guide.md) if anything is unclear.
6. **Terminal → New Terminal:** follow [tool installation and version checks](docs/toolchain.md), configure local Git authorship, then run **node scripts/doctor.mjs**. It checks local readiness, not browser/Copilot authorization.
7. **Exercise:** refresh your copy after 20–60 seconds and open its Exercise issue. Follow the current detailed task and [save → stage → commit → push guide](docs/git-workflow.md).

![Microsoft reference: cloning from GitHub in VS Code](docs/images/vscode-clone-github.png)

*REFERENCE — Microsoft documentation example, not your account/repository. [Image attribution](docs/images/NOTICE.md). Detailed clone steps are in [Start here](docs/start-here.md#clone-your-copy-into-desktop-vs-code).*

<!-- AGENTALVINE:START -->
## Copy this exercise once

[![Copy exercise](.github/images/copy-exercise.svg)](https://github.com/new?template_owner=alvinea28&template_name=ws2-operations-capstone-laboratory-08&owner=%40me&name=my-ws2-operations-capstone-laboratory-08&visibility=private)

Select the intended Owner, keep **Private**, leave **Include all branches** off, and create the copy. Its own AgentAlvine issue will appear automatically.
<!-- AGENTALVINE:END -->

## Full workshop review

[Complete setup, all activities and simulation evidence](full-ws-content/README.md) · [Public source Exercise #1 — read-only instructor Preview](https://github.com/alvinea28/ws2-operations-capstone-laboratory-08/issues/1).

The source preview stays at zero learner progress. Learners use the **Exercise link in their own private copy's README**; AgentAlvine validates real work and updates that same issue body, not a separate ticket per activity. Lab 08 completes offline; optional later release/live work stays separate.

## What is included and what remains external

- This copy has its own instructions, exercises, reference code and tests. The catalogue sequence builds concepts; there is no required earlier repository.
- Git, VS Code, Node24.16.0 and Terraform1.16.1 are required. AzureRM5.4.0 is pinned; tests use mocks, not an Azure account.
- Tool/setup instructions and a read-only doctor are provided locally.
- Offline completion needs no earlier deployment. Any optional later release/live follow-up must use one instructor-designated private delivery copy with real approvals; this lab never creates a second state writer.

## Help without guessing

[First-time setup](docs/start-here.md) · [Git actions](docs/git-workflow.md) · [Copilot accounts/context](docs/copilot-guide.md) · [Toolchain](docs/toolchain.md) · [Settings/Actions troubleshooting](docs/troubleshooting.md) · [Glossary](docs/glossary.md)

Do not edit progress checkboxes or send manual evidence commands. AgentAlvine updates the same issue from real activity; a green checklist is not Azure authorization.

[All eight numbered laboratories](https://github.com/alvinea28/ws2-workshop-catalogue) · [MIT code license](LICENSE) · [Screenshot licenses](docs/images/NOTICE.md)
