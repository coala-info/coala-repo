---
name: anchore-cli
description: anchore-cli is a command-line interface for managing, inspecting, and analyzing container images within an Anchore Engine environment. Use when user asks to add images for analysis, scan for vulnerabilities, evaluate security policies, or inspect software bill of materials.
homepage: https://github.com/anchore/anchore-cli
---

# anchore-cli

## Overview
The `anchore-cli` is the primary command-line interface for managing and inspecting container images within an Anchore Engine environment. It allows developers and security operations teams to automate the process of image analysis, enabling "gatekeeping" in CI/CD pipelines. By using this skill, you can perform deep inspection of container file systems, identify known vulnerabilities (CVEs), and evaluate images against custom security policies to ensure only compliant containers are deployed.

## Configuration
Before running commands, ensure the CLI is pointed to your Anchore Engine instance. You can use environment variables to avoid passing credentials with every command:

```bash
export ANCHORE_CLI_URL=http://<your-anchore-engine-host>:8228/v1
export ANCHORE_CLI_USER=admin
export ANCHORE_CLI_PASS=foobar
```

Alternatively, use the global flags: `--u` (user), `--p` (password), and `--url`.

## Common Workflows

### Image Analysis Lifecycle
1. **Add an image**: Submit a tag to the engine for analysis.
   `anchore-cli image add docker.io/library/alpine:latest`
2. **Wait for completion**: Block until the analysis state transitions to `analyzed`.
   `anchore-cli image wait docker.io/library/alpine:latest`
3. **Check Policy Status**: Determine if the image passes your defined security policies.
   `anchore-cli evaluate check docker.io/library/alpine:latest --detail`

### Vulnerability Management
* **Scan for OS vulnerabilities**:
  `anchore-cli image vuln docker.io/library/debian:latest os`
* **Scan for non-OS vulnerabilities (NPM, Gem, Python, Java)**:
  `anchore-cli image vuln <image_tag> non-os`
* **List all vulnerabilities**:
  `anchore-cli image vuln <image_tag> all`

### Content Inspection
Use these commands to audit the specific software bill of materials (SBOM) within an image:
* **OS Packages**: `anchore-cli image content <image_tag> os`
* **Python Packages**: `anchore-cli image content <image_tag> python`
* **NPM Packages**: `anchore-cli image content <image_tag> npm`
* **Java Artifacts**: `anchore-cli image content <image_tag> java`

### System and Subscriptions
* **Check Service Status**: Ensure the Anchore Engine components are up.
  `anchore-cli system status`
* **Enable Notifications**: Receive webhooks when new CVEs affect an analyzed image.
  `anchore-cli subscription activate vuln_update <image_tag>`

## Expert Tips
* **Dry-run Repositories**: When adding an entire repository, use `anchore-cli repo add <repo_path> --dry-run` to see how many tags will be added before committing to the scan.
* **Filtering Events**: If troubleshooting analysis failures, use `anchore-cli event list` with filters like `--level error` to narrow down system issues.
* **Image Digests**: For maximum precision in CI/CD, reference images by their SHA256 digest rather than mutable tags to ensure the analysis results match the exact bits being deployed.



## Subcommands

| Command | Description |
|---------|-------------|
| anchore-cli account | Account management operations for Anchore CLI, including adding, deleting, and managing account status and users. |
| anchore-cli analysis-archive | Manage the analysis archive in Anchore Engine, allowing for archiving and restoring image analysis data. |
| anchore-cli evaluate | Evaluate images against policies using anchore-cli |
| anchore-cli event | Anchore CLI event management commands |
| anchore-cli image | Manage images within Anchore CLI, including adding, analyzing, and retrieving vulnerability data. |
| anchore-cli policy | Manage and interact with Anchore policies |
| anchore-cli query | Query system for images based on packages or vulnerabilities |
| anchore-cli registry | Registry management commands for anchore-cli |
| anchore-cli repo | Manage repositories in Anchore Engine, including adding, deleting, listing, and controlling watch status. |
| anchore-cli subscription | Manage subscriptions for image analysis and policy updates in Anchore Engine. |
| anchore-cli system | Anchore engine system operations including status checks, feed management, and service deletion. |

## Reference documentation
- [Anchore CLI Overview and Usage](./references/github_com_anchore_anchore-cli.md)
- [Anchore CLI Changelog and Version History](./references/github_com_anchore_anchore-cli_blob_master_CHANGELOG.md)