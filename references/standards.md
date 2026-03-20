# Module Standards Reference

Standards based on terraform-aws-modules best practices, adapted for CloudDrove.

## Required Files (Every Module)

| File | Purpose |
|------|---------|
| `main.tf` | Primary resource definitions |
| `variables.tf` | Input variable declarations |
| `outputs.tf` | Output definitions |
| `versions.tf` | Terraform and provider version constraints |
| `README.md` | Documentation (auto-generated from README.yaml) |
| `README.yaml` | Canonical documentation source |
| `CHANGELOG.md` | Semantic version history |
| `LICENSE` | Apache 2.0 |
| `SECURITY.md` | Vulnerability reporting policy |
| `CONTRIBUTING.md` | Development guidelines |
| `.pre-commit-config.yaml` | Pre-commit hooks (antonbabenko/pre-commit-terraform) |
| `.editorconfig` | Code style (2-space indent, UTF-8, LF) |
| `.releaserc.json` | Semantic-release automation |
| `.gitignore` | VCS exclusions |
| `.deepsource.toml` | Code quality analysis |
| `Makefile` | Build/doc generation commands |

## Required Directories

| Directory | Purpose |
|-----------|---------|
| `.github/workflows/` | CI/CD workflows |
| `.github/PULL_REQUEST_TEMPLATE.md` | PR template |
| `.github/CODEOWNERS` | Team ownership |
| `.github/dependabot.yml` | Dependency auto-updates |
| `examples/basic/` | Minimal working example |
| `examples/complete/` | Full-featured example |
| `docs/` | Additional documentation (io.md) |

## versions.tf Format

```hcl
terraform {
  required_version = ">= 1.10.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.80.0"
    }
  }
}
```

CRITICAL RULES:
- `required_version` = Terraform core version (always 1.x)
- `version` under `required_providers` = provider version (varies per provider)
- NEVER mix these values
- Keep versions consistent across the org

## Commit Message Format

All repos enforce conventional commits via commitlint.

```
type: description
```

Allowed types: `fix`, `feat`, `docs`, `ci`, `chore`, `test`, `refactor`, `style`, `perf`, `build`, `revert`

NO emojis in commit messages or PR titles.

## Pre-commit Standard

Use `antonbabenko/pre-commit-terraform v1.105.0` with:
- `terraform_fmt` — auto-format
- `terraform_docs` — generate docs
- `terraform_tflint` — 12 specific lint rules
- `terraform_validate` — syntax validation
- Standard hooks: merge-conflict, EOF-fixer, trailing-whitespace

## CI/CD Workflows

Required workflows per module:
1. `tf-checks.yml` — terraform validate/fmt/init (use `provider: none`)
2. `tflint.yml` — linting
3. `tfsec.yml` or `checkov.yml` — security scanning
4. `pr_checks.yml` — PR title/commit validation
5. `automerge.yml` — auto-merge
6. `stale_pr.yml` — stale PR management
7. `tag-release.yml` — semantic versioning

Always set `provider: none` in tf-checks for validate-only (no cloud auth).
Pin shared workflow references to SHA for reproducibility.

## Scoring Criteria

When auditing a module, score 1-10 on:
1. Module structure (required files present)
2. versions.tf quality (correct, consistent)
3. CI/CD maturity (all workflows, provider: none)
4. Pre-commit hooks (antonbabenko, current version)
5. Documentation (README quality, examples)
6. Examples quality (basic + complete minimum)
7. Changelog (maintained, semantic versioning)
8. Testing (examples validated in CI minimum)
9. Release automation (.releaserc.json)
10. Security (SECURITY.md, tfsec/checkov)
11. Contributing guide (CONTRIBUTING.md)
12. Consistency across org

Target: 8+ on all categories.
