---
name: anchore-cli
description: anchore-cli manages container security by inspecting images for vulnerabilities and policy compliance via the Anchore Engine API. Use when user asks to add images for analysis, scan for vulnerabilities, check policy evaluation status, or list container image content.
homepage: https://github.com/anchore/anchore-cli
---


# anchore-cli

## Overview
The `anchore-cli` skill provides a specialized interface for managing container security through the Anchore Engine REST API. It allows for the automated inspection of container images to identify vulnerabilities and ensure compliance with organizational policies. Use this skill when you need to add images for analysis, monitor analysis progress, retrieve vulnerability reports, or audit the specific contents (OS packages and language-specific libraries) of a container image.

## Configuration
To avoid passing credentials in plain text via command-line arguments, it is a best practice to configure the CLI using environment variables:

- `ANCHORE_CLI_URL`: The URL of the Anchore Engine service (e.g., `http://localhost:8228/v1`).
- `ANCHORE_CLI_USER`: Your Anchore Engine username.
- `ANCHORE_CLI_PASS`: Your Anchore Engine password.

If environment variables are not used, you must provide `--u <user>`, `--p <pass>`, and `--url <url>` with every command.

## Common CLI Patterns

### Image Management and Analysis
The standard workflow for analyzing a new image involves adding it and then waiting for the engine to complete the deep inspection.

- **Add an image**: `anchore-cli image add <registry>/<repo>:<tag>`
- **Wait for analysis**: `anchore-cli image wait <image_name>`
  *Tip: This is essential for CI/CD scripts to ensure the analysis is finished before attempting to read results.*
- **List analyzed images**: `anchore-cli image list`
- **Get image metadata**: `anchore-cli image get <image_name>`

### Vulnerability Scanning
Retrieve security findings for specific layers or package types within an image.

- **Scan for OS vulnerabilities**: `anchore-cli image vuln <image_name> os`
- **Scan for non-OS vulnerabilities**: `anchore-cli image vuln <image_name> all`

### Policy Evaluation
Check if an image passes the defined policy gates (e.g., "Stop if High vulnerability found").

- **Check policy status**: `anchore-cli evaluate check <image_name>`
- **View detailed policy failures**: `anchore-cli evaluate check <image_name> --detail`
  *Tip: Use `--detail` to identify exactly which policy trigger caused a "Fail" status.*

### Content Inspection (SBOM)
Inspect the specific packages and files discovered during analysis.

- **List OS packages**: `anchore-cli image content <image_name> os`
- **List Python packages**: `anchore-cli image content <image_name> python`
- **List NPM packages**: `anchore-cli image content <image_name> npm`
- **List Java archives**: `anchore-cli image content <image_name> java`

### Subscriptions
Automate notifications for security updates.

- **Activate vulnerability alerts**: `anchore-cli subscription activate vuln_update <image_name>`

## Expert Tips
- **Archived Status**: Be aware that `anchore-cli` is archived. For Anchore Enterprise environments, consider transitioning to `anchorectl` if available, though `anchore-cli` remains the standard for legacy Anchore Engine instances.
- **Path Configuration**: Ensure `~/.local/bin` is in your `PATH` after installation to call the tool directly.
- **Registry Management**: If using private registries, ensure you have added the registry credentials to Anchore Engine first using `anchore-cli registry add`.

## Reference documentation
- [Anchore CLI README](./references/github_com_anchore_anchore-cli.md)