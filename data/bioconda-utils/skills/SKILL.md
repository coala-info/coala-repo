---
name: bioconda-utils
description: Bioconda-utils is a toolkit for linting, building, and managing bioinformatics package recipes within the Bioconda ecosystem. Use when user asks to lint recipes for errors, build packages locally, update dependency pinnings, or check for new upstream software versions.
homepage: http://bioconda.github.io/build-system.html
---


# bioconda-utils

## Overview
This skill provides procedural knowledge for using `bioconda-utils`, the core toolkit used by the Bioconda project to maintain its massive repository of bioinformatics packages. It is designed to help automate the linting and building process, ensuring that recipes meet community standards before they are submitted or merged. Use this tool to identify structural issues in `meta.yaml` files, manage environment dependencies, and simulate the CI/CD pipeline locally.

## Common CLI Patterns

### Linting Recipes
The most frequent use case is checking recipes for errors or style violations.
- **Lint all recipes in a directory**: `bioconda-utils lint recipes/ config.yaml`
- **Lint a specific recipe**: `bioconda-utils lint recipes/ config.yaml --packages <package_name>`
- **List available linters**: `bioconda-utils lint --list-linters`

### Building and Testing
Simulate the build process to ensure the recipe is functional.
- **Build a specific package**: `bioconda-utils build recipes/ config.yaml --packages <package_name>`
- **Build with a specific docker image**: Use the `--docker` flag to ensure a clean, reproducible environment.
- **Dry run**: Use `--dry-run` to see what would be built without executing the actual build.

### Dependency Management
- **Update dependencies**: `bioconda-utils update-pinning` can be used to align recipes with the latest global pinnings in the Bioconda distribution.
- **Check for updates**: `bioconda-utils autobump` identifies if a new version of the upstream software is available.

## Expert Tips
- **Config Files**: Always ensure you have a valid `config.yaml` (usually found in the root of the bioconda-recipes repo) as most commands require it to define channels and build parameters.
- **Filtering**: Use the `--exclude` flag to skip problematic recipes or those that require heavy resources during bulk operations.
- **Log Levels**: When debugging complex dependency resolution issues, use `--loglevel debug` to see the underlying solver logic.
- **Local Testing**: Before submitting a PR to Bioconda, run the linting command locally to catch "easy" fixes like trailing whitespace, missing homepages, or incorrect license strings.

## Reference documentation
- [Bioconda Utils Overview](./references/anaconda_org_channels_bioconda_packages_bioconda-utils_overview.md)