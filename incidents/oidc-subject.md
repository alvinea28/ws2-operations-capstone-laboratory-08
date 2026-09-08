# OIDC subject mismatch — sanitized fixture

This is a fictional diagnostic excerpt, not a live token or Azure run.

- Stage: OIDC exchange before Terraform backend initialization.
- Error: **AADSTS700213 — no matching federated identity record**.
- Old configured subject: `repo:team/network:environment:dev-plan`
- Presented format: `repo:team@12345/network@67890:environment:dev-plan`

The new repository uses immutable owner/repository IDs. Extra Contributor
permissions cannot repair this authentication mismatch. The identity owner
must compare actual authorized claims and review an exact trust correction.
Do not log a JWT or modify any live federation from this offline lab.
