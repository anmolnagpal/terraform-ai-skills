# Terraform AI Skills — Prompt Reference

Quick reference for all available prompts. Copy-paste the command for your provider.

## Providers

| Provider     | Config                       |
|--------------|------------------------------|
| AWS          | `config/aws.config`          |
| GCP          | `config/gcp.config`          |
| Azure        | `config/azure.config`        |
| DigitalOcean | `config/digitalocean.config` |

---

## 1. Provider Upgrade

Upgrades Terraform & provider versions across all modules, updates examples, validates, and formats.

```
use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/1-provider-upgrade.prompt
```

| Provider     | Command |
|--------------|---------|
| AWS          | `use config/aws.config + prompts/1-provider-upgrade.prompt` |
| GCP          | `use config/gcp.config + prompts/1-provider-upgrade.prompt` |
| Azure        | `use config/azure.config + prompts/1-provider-upgrade.prompt` |
| DigitalOcean | `use config/digitalocean.config + prompts/1-provider-upgrade.prompt` |

---

## 2. Workflow Standardization

Standardizes GitHub Actions workflows, pins to SHA, removes deprecated files.

```
use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/2-workflow-standardization.prompt
```

| Provider     | Command |
|--------------|---------|
| AWS          | `use config/aws.config + prompts/2-workflow-standardization.prompt` |
| GCP          | `use config/gcp.config + prompts/2-workflow-standardization.prompt` |
| Azure        | `use config/azure.config + prompts/2-workflow-standardization.prompt` |
| DigitalOcean | `use config/digitalocean.config + prompts/2-workflow-standardization.prompt` |

---

## 3. Release Creation

Creates semantic versioned releases with changelogs and GitHub releases.

```
use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/3-release-creation.prompt
```

| Provider     | Command |
|--------------|---------|
| AWS          | `use config/aws.config + prompts/3-release-creation.prompt` |
| GCP          | `use config/gcp.config + prompts/3-release-creation.prompt` |
| Azure        | `use config/azure.config + prompts/3-release-creation.prompt` |
| DigitalOcean | `use config/digitalocean.config + prompts/3-release-creation.prompt` |

---

## 4. Full Maintenance (Recommended)

Complete cycle: discovery, upgrades, workflows, validation, docs, releases, and reporting.

```
use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/4-full-maintenance.prompt
```

| Provider     | Command |
|--------------|---------|
| AWS          | `use config/aws.config + prompts/4-full-maintenance.prompt` |
| GCP          | `use config/gcp.config + prompts/4-full-maintenance.prompt` |
| Azure        | `use config/azure.config + prompts/4-full-maintenance.prompt` |
| DigitalOcean | `use config/digitalocean.config + prompts/4-full-maintenance.prompt` |

---

## Time Estimates

| Skill                    | <20 repos   | 20-50 repos | 50-100 repos | 170+ repos  |
|--------------------------|-------------|-------------|--------------|-------------|
| Provider Upgrade         | 10-15 min   | 30-45 min   | 45-60 min    | 60-90 min   |
| Workflow Standardization | 15-20 min   | 20-25 min   | 25-30 min    | 30 min      |
| Release Creation         | 10 min      | 10-15 min   | 15-20 min    | 20 min      |
| Full Maintenance         | 30-45 min   | 45-75 min   | 90-120 min   | 2-3 hours   |

---

## Commit Format (CRITICAL)

All CloudDrove repos enforce conventional commits via commitlint.

**Format:** `type: description`
**Allowed types:** fix, feat, docs, ci, chore, test, refactor, style, perf, build, revert
**NO emojis** in commit messages or PR titles.

---

## Key Rules

1. `required_version` (Terraform) and provider `version` are DIFFERENT values — never mix them
2. Set `provider: none` in tf-checks.yml for validate-only (no cloud auth needed)
3. Some repos require 2 approving reviews — track these for manual merge

---

## Safety Reminders

1. **Always test on 1 repo first** before bulk operations
2. Review summary before proceeding to releases
3. Monitor GitHub Actions during execution
4. Stop immediately if unexpected errors occur
5. See `references/safety.md` for rollback procedures and lessons learned
