---
name: spectra
description: Spectral is a CLI linter for JSON and YAML files that enforces automated style guides for API descriptions. Use when user asks to lint API specifications, apply custom rulesets to data files, or generate formatted linting reports.
homepage: https://github.com/stoplightio/spectral
metadata:
  docker_image: "biocontainers/spectra:v0.0.11-1-deb-py3_cv1"
---

# spectra

## Overview
Spectral is a versatile linter designed to create and enforce automated style guides for JSON and YAML data. While it functions as a general-purpose linter, it is highly optimized for API descriptions. It helps maintain high-quality documentation and consistent API design by providing immediate feedback on schema violations and stylistic inconsistencies. This skill focuses on the native command-line interface (CLI) for executing linting tasks and managing rulesets.

## CLI Usage and Patterns

### Installation
Install the Spectral CLI globally using npm or yarn:
- `npm install -g @stoplight/spectral-cli`
- `yarn global add @stoplight/spectral-cli`

### Core Linting Commands
- **Basic Linting**: Run `spectral lint <filename>` to check a file against default rules.
- **Custom Ruleset**: Use `spectral lint <filename> --ruleset <ruleset-file>` to apply specific style guides.
- **Multiple Files**: Use glob patterns to lint multiple documents at once: `spectral lint "src/**/*.yaml"`.
- **Remote Files**: Spectral can lint files directly from a URL: `spectral lint https://example.com/api/openapi.yaml`.

### Output Formatting
Spectral supports various output formats to integrate with different tools:
- **Default (Stylish)**: Human-readable output in the terminal.
- **JSON**: `spectral lint <file> --format json` (useful for programmatic processing).
- **JUnit**: `spectral lint <file> --format junit` (standard for CI/CD test reporting).
- **HTML**: `spectral lint <file> --format html` (generates a visual report).

### Severity and Error Handling
- **Fail Severity**: Control which issues cause the process to exit with a non-zero code: `spectral lint <file> --fail-severity warn`.
- **Display Filtering**: Show only failures and hide warnings: `spectral lint <file> --display-only-failures`.

## Expert Tips
- **Built-in Rulesets**: Leverage Spectral's native rulesets for common formats by referencing them in your command-line workflow. These include `spectral:oas` for OpenAPI and `spectral:asyncapi` for AsyncAPI.
- **CI/CD Integration**: Use the `--fail-severity` flag in build pipelines to prevent merging API specifications that do not meet the "error" or "warn" thresholds of your style guide.
- **Proxy Support**: If working behind a corporate firewall, Spectral respects standard environment variables like `HTTP_PROXY` and `HTTPS_PROXY` when fetching remote rulesets or documents.
- **Performance**: For very large specifications, use the `--ignore-unknown-format` flag to speed up processing if you are certain of the document type.

## Reference documentation
- [Spectral README](./references/github_com_stoplightio_spectral.md)
- [Spectral Documentation Structure](./references/github_com_stoplightio_spectral_tree_develop_docs.md)