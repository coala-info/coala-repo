---
name: bioconda-utils
description: Bioconda-utils is a command-line toolkit used to automate the linting, building, and maintenance of bioinformatics software recipes within the Bioconda ecosystem. Use when user asks to lint recipes for quality standards, build packages in isolated Docker environments, update Bioconductor skeletons, or manage recipe dependencies and build failures.
homepage: http://bioconda.github.io/build-system.html
---

# bioconda-utils

## Overview
`bioconda-utils` is the primary toolkit used by the Bioconda community to maintain the integrity of the bioinformatics software ecosystem. It provides a suite of command-line tools to automate the lifecycle of a Conda recipe—from initial skeleton generation to linting for best practices and performing multi-architecture builds. This skill helps ensure that recipes meet Bioconda's strict quality standards and function correctly across different platforms.

## Common CLI Patterns

### Recipe Validation and Linting
Before attempting a build, always lint the recipe to catch common errors such as missing compilers, incorrect versioning, or non-standard metadata.
- **Basic linting**: `bioconda-utils lint --packages <package_name>`
- **Linting against specific recipes**: Point the tool to your local `bioconda-recipes` directory to check specific sub-folders.

### Building Recipes
Bioconda uses isolated environments to ensure reproducibility.
- **Standard build**: `bioconda-utils build --packages <package_name> --docker --mulled-test`
- **Docker-based builds**: Use the `--docker` flag to build in a containerized environment (typically based on `linux-anvil`) to avoid host-system contamination.
- **Mulled tests**: Use `--mulled-test` to run tests in a minimal, auto-generated container that only contains the package and its requirements.

### Managing Bioconductor Recipes
The tool includes specialized logic for the Bioconductor ecosystem.
- **Update Bioconductor recipes**: `bioconda-utils bioconductor-skeleton update-recipes --bioc-version <version>`
- **Patching**: When updating Bioconductor packages, the tool can be configured to keep existing patches while bumping versions.

### Resource Monitoring
Recent versions of the tool allow for tracking resource consumption during the build process.
- **Usage reporting**: Monitor the output for resource usage statistics before and after builds to identify memory-intensive bioinformatics tools.

## Expert Tips
- **Strict Channel Priority**: Ensure your environment is configured with `conda-forge` and `bioconda` channels, with `strict` priority enabled to prevent dependency conflicts.
- **Redundant Solvers**: In version 4.1.0+, host-side solver runs are minimized for Docker builds to speed up the process.
- **Environment TTL**: When running extensive tests, set `local_repodata_ttl` to a higher value (e.g., 3600) to prevent constant re-indexing of the Conda channels.
- **Compiler Lints**: Always include `{{ compiler('c') }}` or `{{ compiler('cxx') }}` in the `host` section for compiled code; `bioconda-utils` will flag missing compilers via the `should_use_compilers` lint.



## Subcommands

| Command | Description |
|---------|-------------|
| bioconda-utils annotate-build-failures | Annotate build failures for recipes. |
| bioconda-utils autobump | Updates recipes in recipe_folder |
| bioconda-utils bioconductor-skeleton | Build a Bioconductor recipe. The recipe will be created in the 'recipes' directory and will be prefixed by "bioconductor-". If --recursive is set, then any R dependency recipes will be prefixed by "r-". |
| bioconda-utils build | Build packages for Bioconda. |
| bioconda-utils clean-cran-skeleton | Cleans skeletons created by ``conda skeleton cran``. |
| bioconda-utils dag | Export the DAG of packages to a graph format file for visualization |
| bioconda-utils dependent | Print recipes dependent on a package |
| bioconda-utils duplicates | Detect packages in bioconda that have duplicates in the other defined channels. |
| bioconda-utils handle-merged-pr | Handle merged pull requests for Bioconda recipes. |
| bioconda-utils lint | Lint recipes |
| bioconda-utils list-build-failures | List recipes with build failure records |
| bioconda-utils update-pinning | Bump a package build number and all dependencies as required due to a change in pinnings |

## Reference documentation
- [Bioconda-utils README](./references/github_com_bioconda_bioconda-utils_blob_master_README.md)
- [Bioconda-utils Changelog](./references/github_com_bioconda_bioconda-utils_blob_master_CHANGELOG.md)
- [Bioconda-utils Dockerfile](./references/github_com_bioconda_bioconda-utils_blob_master_Dockerfile.md)