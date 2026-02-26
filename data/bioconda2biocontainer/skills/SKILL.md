---
name: bioconda2biocontainer
description: bioconda2biocontainer retrieves container images and metadata for Bioconda packages from the BioContainers registry. Use when user asks to find Docker or Singularity URIs for specific tools, list available package versions, or search the registry for bioinformatics software.
homepage: https://github.com/BioContainers/bioconda2biocontainer
---


# bioconda2biocontainer

## Overview

bioconda2biocontainer is a specialized API client designed to bridge the gap between Bioconda packages and the BioContainers registry. It allows users to programmatically discover container images for specific bioinformatics tools. Use this skill when you need to resolve a Conda package name and version into a functional Docker or Singularity URI for use in reproducible pipelines, cloud environments, or HPC clusters.

## CLI Usage Patterns

### Finding Specific Images
To retrieve a specific container URI for a known package, use the primary `bioconda2biocontainer` command.

*   **Get the latest Docker image:**
    `bioconda2biocontainer --package_name <name> --package_version <version> --container_type Docker`
*   **Get the smallest Singularity image:**
    `bioconda2biocontainer --package_name <name> --package_version <version> --container_type Singularity --sort_by_size`
*   **Find the most downloaded Conda package version:**
    `bioconda2biocontainer --package_name <name> --package_version <version> --container_type Conda --sort_by_download`

### Exploring Package Versions
If you are unsure of the exact version string or want to see all available builds (including different hashes/build numbers):

*   **List all available versions for a tool:**
    `bioconda2biocontainer --package_name <name>`
*   **List all image types and metadata for a specific version:**
    `bioconda2biocontainer --package_name <name> --package_version <version> --all`

### Registry Searching
When the exact Bioconda package name is unknown, use the search utility to query the registry by keyword.

*   **Search by domain (e.g., proteomics):**
    `biocontainers-search --search_term proteomics`
*   **Get search results in JSON format for parsing:**
    `biocontainers-search --search_term <term> --json`

## Expert Tips

*   **Container Selection:** When working on HPC systems, always prefer `Singularity` images as they typically point to the Galaxy Project's depot (depot.galaxyproject.org), which is optimized for such environments.
*   **Build Hashes:** Bioconda packages often have multiple builds for the same version (e.g., `2.27.0--0` vs `2.27.0--he513fc3_4`). Using the `--all` flag is critical to identify the specific build that matches your environment's architecture or requirements.
*   **Sorting:** Use `--sort_by_size` to minimize storage footprint and pull times, especially in ephemeral cloud instances.

## Reference documentation
- [BioContainers API client README](./references/github_com_BioContainers_bioconda2biocontainer.md)
- [bioconda2biocontainer Overview](./references/anaconda_org_channels_bioconda_packages_bioconda2biocontainer_overview.md)