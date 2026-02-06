# Changelog

All notable changes to terraform-terraform-ai-skills will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-02-06

### Added
- ✨ Multi-cloud support (AWS, GCP, Azure, DigitalOcean)
- ✨ Provider-specific configuration files for each cloud
- ✨ SKILL.md for AI assistant integration
- ✨ INDEX.md complete navigation guide
- ✨ DISTRIBUTION.md for package distribution
- ✨ PROVIDER-SELECTION.md for choosing configs
- ✨ ENV-VARS.md environment variables reference
- ✨ run-with-provider.sh wrapper script
- ✨ Enhanced validation with TFLint and TFSec
- ✨ Comprehensive safety procedures and rollback guides

### Changed
- ⬆️ **BREAKING:** Terraform minimum version updated from 1.5.4 to 1.10.0
- ⬆️ **BREAKING:** Updated all provider versions to latest (AWS 5.80, GCP 6.20, Azure 4.20, DO 2.70)
- 📝 Complete documentation overhaul (2,656 lines)
- 🔧 Refactored global.config to be base config only
- 📖 Enhanced README with SEO optimization
- 🎨 Improved prompt files with provider-specific examples

### Fixed
- 🐛 Fixed provider version constraints for modern Terraform
- 🐛 Corrected organization names for Azure and DigitalOcean
- 📝 Fixed documentation links and cross-references

## [1.0.0] - Initial Release

### Added
- ✨ Initial release for DigitalOcean modules
- ✨ Basic provider upgrade automation
- ✨ GitHub Actions workflow standardization
- ✨ Release creation automation
- ✨ Full maintenance workflow
- ✨ Basic documentation (README, USAGE, EXAMPLES, QUICKREF)
- ✨ Safety checklists
- 📝 MIT License

### Supported
- Terraform 1.5.4+
- DigitalOcean Provider 2.70.0+
- terraform-do-modules organization

---

## Upgrade Guide

### From 1.0.0 to 2.0.0

**Breaking Changes:**
1. Terraform minimum version increased to 1.10.0
2. Configuration structure changed (provider-specific configs)
3. Prompt files updated with new syntax

**Migration Steps:**

1. **Update Terraform:**
   ```bash
   terraform version  # Must be 1.10.0+
   ```

2. **Use Provider-Specific Configs:**
   ```bash
   # Old (1.0.0)
   @copilot use config/global.config

   # New (2.0.0)
   @copilot use config/aws.config  # Or gcp/azure/digitalocean
   ```

3. **Update Scripts:**
   ```bash
   # Use new wrapper
   ./run-with-provider.sh aws batch-provider-upgrade.sh
   ```

4. **Review Documentation:**
   - Read DISTRIBUTION.md for overview
   - Check PROVIDER-SELECTION.md for config guidance
   - Review updated SAFETY.md procedures

**What Stays the Same:**
- Prompt workflow (still 4 main prompts)
- Script functionality
- Safety-first approach
- Validation steps

**Benefits of Upgrading:**
- Access to latest Terraform features
- Multi-cloud support
- Better documentation
- Enhanced safety procedures
- Improved automation

---

## Version Support Policy

| Version | Status | Terraform | Support Until |
|---------|--------|-----------|---------------|
| 2.0.x | ✅ Active | 1.10.0+ | Current |
| 1.0.x | ⚠️ Maintenance | 1.5.4+ | 2026-06-06 |
| 0.x | ❌ Unsupported | Various | N/A |

**Support Levels:**
- ✅ **Active:** Full support, new features, bug fixes
- ⚠️ **Maintenance:** Critical bug fixes only
- ❌ **Unsupported:** No support, upgrade recommended

---

## Coming Soon (Roadmap)

### v2.1.0 (Q2 2026)
- [ ] Policy-as-code validation (OPA)
- [ ] Cost estimation integration (Infracost)
- [ ] Slack notifications
- [ ] Dashboard for tracking status

### v2.2.0 (Q3 2026)
- [ ] Drift detection skill
- [ ] Module dependency graph generator
- [ ] Automated testing skill
- [ ] Compliance checking (CIS benchmarks)

### v3.0.0 (Q4 2026)
- [ ] Terraform Cloud/Enterprise integration
- [ ] Advanced analytics and reporting
- [ ] Custom skill marketplace
- [ ] Multi-repository orchestration

---

## Feedback & Bug Reports

- **Issues:** [GitHub Issues](https://github.com/clouddrove/terraform-terraform-ai-skills/issues)
- **Feature Requests:** [GitHub Discussions](https://github.com/clouddrove/terraform-terraform-ai-skills/discussions)
- **Security:** [security@anmolnagpal.com](mailto:security@anmolnagpal.com)

---

**Legend:**
- ✨ New feature
- ⬆️ Upgrade/Update
- 🐛 Bug fix
- 📝 Documentation
- 🔧 Configuration
- 🎨 Style/Format
- 🔒 Security
- ⚡ Performance
