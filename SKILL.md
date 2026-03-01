---
name: terraform-ai-skills
description: AI-powered multi-cloud Terraform module management — automate provider upgrades, workflow standardization, releases, and validation across AWS, GCP, Azure, and DigitalOcean at scale
version: 0.0.1
metadata:
  openclaw:
    requires:
      bins:
        - terraform
        - git
        - bash
      bins_optional:
        - gh
        - tflint
        - tfsec
        - trivy
        - checkov
    os:
      - linux
      - macos
    homepage: https://github.com/anmolnagpal/terraform-ai-skills
    tags:
      - terraform
      - multi-cloud
      - aws
      - gcp
      - azure
      - digitalocean
      - infrastructure-as-code
      - devops
      - automation
      - ci-cd
      - github-copilot
    license: MIT
    author: CloudDrove
---

# Terraform AI Skills — Multi-Cloud Module Management

AI-powered automation framework for managing Terraform modules at scale across AWS, GCP, Azure, and DigitalOcean. Automate provider upgrades, GitHub Actions workflows, releases, and validation across hundreds of repositories with 97% time savings.

## When to Use

**Activate these skills when:**
- Managing 10–200+ Terraform module repositories
- Upgrading provider versions across an organization
- Standardizing GitHub Actions workflows
- Creating versioned releases with automated changelogs
- Performing bulk maintenance operations
- Validating Terraform code at scale

**Not ideal for:**
- Single Terraform project maintenance
- Writing individual Terraform configurations
- Cloud-specific resource questions

## Available Skills

### 1. Provider Upgrade 🔄
```
@copilot use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/1-provider-upgrade.prompt
```
Updates provider version constraints, Terraform versions, examples, and runs validation.  
**Time:** 10–90 min

### 2. Workflow Standardization 🔧
```
@copilot use terraform-ai-skills/config/gcp.config and follow terraform-ai-skills/prompts/2-workflow-standardization.prompt
```
Pins GitHub Actions workflows to SHAs and removes deprecated actions.  
**Time:** 15–30 min

### 3. Release Creation 🚀
```
@copilot use terraform-ai-skills/config/azure.config and follow terraform-ai-skills/prompts/3-release-creation.prompt
```
Generates changelogs, creates semantic version tags, and publishes GitHub releases.  
**Time:** 10–20 min

### 4. Full Maintenance ⚡ _(Recommended)_
```
@copilot use terraform-ai-skills/config/digitalocean.config and follow terraform-ai-skills/prompts/4-full-maintenance.prompt
```
Complete end-to-end cycle: discovery → upgrades → workflows → validation → releases.  
**Time:** 45–180 min

## Quick Start

```bash
# 1. Test on a single repo first (always!)
@copilot use terraform-ai-skills/config/aws.config and upgrade provider in terraform-aws-vpc only

# 2. Run full maintenance on all repos
@copilot use terraform-ai-skills/config/aws.config and follow terraform-ai-skills/prompts/4-full-maintenance.prompt

# 3. Verify results
git status && gh run list && gh release list
```

## Cloud Provider Support

| Provider     | Config file                   | Terraform | Min Provider |
|--------------|-------------------------------|-----------|--------------|
| AWS          | `config/aws.config`           | 1.10.0+   | 5.80.0+      |
| GCP          | `config/gcp.config`           | 1.10.0+   | 6.20.0+      |
| Azure        | `config/azure.config`         | 1.10.0+   | 4.20.0+      |
| DigitalOcean | `config/digitalocean.config`  | 1.10.0+   | 2.70.0+      |

## Proven Results

| Operation            | Manual (170 repos) | With Skills | Savings |
|----------------------|--------------------|-------------|---------|
| Provider upgrade     | 56 hours           | 90 minutes  | 97% ⬇️  |
| Workflow fixes       | 20 hours           | 30 minutes  | 97% ⬇️  |
| Release creation     | 10 hours           | 15 minutes  | 97% ⬇️  |
| Full maintenance     | 86 hours           | 2–3 hours   | 97% ⬇️  |

## Requirements

- **Terraform** 1.10.0+
- **Git** 2.30+
- **Bash** 4.0+
- **GitHub Copilot CLI** or compatible AI assistant (Claude, ChatGPT, Cursor)
- `gh` CLI _(optional — recommended for release automation)_
- TFLint / TFSec / Trivy / Checkov _(optional — for enhanced validation)_

## Safety

Always read [docs/SAFETY.md](docs/SAFETY.md) before running bulk operations. Built-in safeguards include exclude patterns, dry-run mode, validation checkpoints, and documented rollback procedures.

## License

MIT © 2026 CloudDrove
