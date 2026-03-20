#!/bin/bash
# Batch Provider Upgrade Script
# Updates provider version across all Terraform modules
#
# IMPORTANT: This script handles required_version (Terraform) and
# provider version separately to avoid mixing them up.

set -e

# Load configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="${1:-${SCRIPT_DIR}/../config/global.config}"

if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  echo "Configuration file not found: $CONFIG_FILE"
  echo "Usage: $0 <config-file>"
  echo "  e.g.: $0 ../config/aws.config"
  exit 1
fi

echo "Starting Provider Upgrade"
echo "Provider: ${PROVIDER_NAME}"
echo "Target Provider Version: >= ${PROVIDER_MIN_VERSION}"
echo "Target Terraform Version: >= ${TERRAFORM_MIN_VERSION}"
echo ""

# Find all matching repositories
REPOS=()
for dir in terraform-${PROVIDER_NAME}-*/; do
  repo_name="${dir%/}"
  # Check if in exclude list
  if [[ " ${EXCLUDE_REPOS} " =~ " ${repo_name} " ]]; then
    echo "Skipping $repo_name (excluded)"
    continue
  fi
  if [ -d "$dir" ] && [ -f "$dir/versions.tf" ]; then
    REPOS+=("$repo_name")
  fi
done

echo "Found ${#REPOS[@]} repositories to update"
echo ""

# Function to update a single versions.tf file safely
update_versions_tf() {
  local file="$1"
  local tf_version="$2"
  local provider_version="$3"

  if [ ! -f "$file" ]; then return; fi

  # Update required_version (Terraform version) — match the line specifically
  sed -i.bak "s/required_version = \">=.*\"/required_version = \">= ${tf_version}\"/" "$file"

  # Update provider version — only match lines with just 'version', not 'required_version'
  # This targets lines like:  version = ">= 5.31.0"
  # But NOT lines like:  required_version = ">= 1.6.6"
  sed -i.bak '/required_version/!s/version = ">=.*"/version = ">= '"${provider_version}"'"/' "$file"

  rm -f "${file}.bak"
}

# Process each repository
SUCCESS_COUNT=0
SKIP_COUNT=0

for repo in "${REPOS[@]}"; do
  echo "=== Processing $repo ==="
  cd "$repo"

  # Update main versions.tf
  if [ -f "versions.tf" ]; then
    update_versions_tf "versions.tf" "${TERRAFORM_MIN_VERSION}" "${PROVIDER_MIN_VERSION}"
    echo "  Updated main versions.tf"
  fi

  # Update example versions.tf files (both examples/ and _examples/)
  example_count=0
  for vfile in $(find examples _examples -name "versions.tf" -type f 2>/dev/null); do
    update_versions_tf "$vfile" "${TERRAFORM_MIN_VERSION}" "${PROVIDER_MIN_VERSION}"
    ((example_count++))
  done
  if [ "$example_count" -gt 0 ]; then
    echo "  Updated $example_count example files"
  fi

  # Update tf-checks workflow to use provider: none
  if [ -f ".github/workflows/tf-checks.yml" ]; then
    # Add provider: none after working_directory lines that don't already have provider:
    python3 -c "
import re
with open('.github/workflows/tf-checks.yml', 'r') as f:
    lines = f.read().split('\n')
new_lines = []
for i, line in enumerate(lines):
    new_lines.append(line)
    if 'working_directory:' in line:
        indent = len(line) - len(line.lstrip())
        has_provider = False
        for j in range(i+1, min(i+3, len(lines))):
            if 'provider:' in lines[j]:
                has_provider = True
                break
            if lines[j].strip() and not lines[j].strip().startswith('#'):
                break
        if not has_provider:
            new_lines.append(' ' * indent + 'provider: none')
with open('.github/workflows/tf-checks.yml', 'w') as f:
    f.write('\n'.join(new_lines))
" 2>/dev/null || true
    # Replace existing provider values with none
    sed -i.bak 's/provider: aws/provider: none/' .github/workflows/tf-checks.yml 2>/dev/null || true
    sed -i.bak 's/provider: azurerm/provider: none/' .github/workflows/tf-checks.yml 2>/dev/null || true
    sed -i.bak 's/provider: gcp/provider: none/' .github/workflows/tf-checks.yml 2>/dev/null || true
    sed -i.bak 's/provider: digitalocean/provider: none/' .github/workflows/tf-checks.yml 2>/dev/null || true
    rm -f .github/workflows/tf-checks.yml.bak
    echo "  Updated tf-checks.yml with provider: none"
  fi

  # Format if enabled
  if [ "$RUN_TERRAFORM_FMT" = true ]; then
    terraform fmt -recursive >/dev/null 2>&1 || true
  fi

  # Validate if enabled
  if [ "$RUN_TERRAFORM_VALIDATE" = true ]; then
    if terraform init -backend=false >/dev/null 2>&1 && terraform validate >/dev/null 2>&1; then
      echo "  Validation passed"
    else
      echo "  Validation failed (continuing anyway)"
    fi
  fi

  # Commit changes (conventional commit format — NO emojis)
  git add -A 2>/dev/null || true
  if git diff --staged --quiet; then
    echo "  No changes to commit"
    ((SKIP_COUNT++))
  else
    git commit -m "chore: upgrade ${PROVIDER_NAME} provider to >= ${PROVIDER_MIN_VERSION} and Terraform to >= ${TERRAFORM_MIN_VERSION}" >/dev/null
    echo "  Changes committed"
    ((SUCCESS_COUNT++))
  fi

  cd ..
  echo ""
done

echo "========================================="
echo "Upgrade Complete!"
echo "  Successfully updated: $SUCCESS_COUNT"
echo "  Skipped (no changes): $SKIP_COUNT"
echo ""
echo "Next steps:"
echo "1. Review changes with: git diff"
echo "2. Push branches and create PRs"
echo "3. Wait for CI to pass"
echo "4. Merge PRs (some may require 2 approving reviews)"
