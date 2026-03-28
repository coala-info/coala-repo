---
name: bioconda2biocontainer
description: bioconda2biocontainer maps Bioconda packages to their corresponding containerized versions and searches the BioContainers registry for tool metadata. Use when user asks to find Docker or Singularity images for specific packages, search for tools by keyword, or retrieve container metadata like image size and download counts.
homepage: https://github.com/BioContainers/bioconda2biocontainer
---


# bioconda2biocontainer

## Overview

The `bioconda2biocontainer` tool provides a programmatic interface to the BioContainers registry. It allows you to map Bioconda packages to their corresponding containerized versions, ensuring that you can find the exact Docker or Singularity image required for a specific bioinformatics task. It also includes discovery features to search the registry for tools by domain (e.g., "proteomics") and retrieve metadata such as download counts, image sizes, and licenses.

## CLI Usage Patterns

### Finding Container Images

To find a specific container for a known Bioconda package, use the `bioconda2biocontainer` command.

**List all available images and formats for a package:**
```bash
bioconda2biocontainer --package_name bedtools --package_version 2.27.0 --all
```

**Get the latest Docker image for a specific version:**
```bash
bioconda2biocontainer --package_name bedtools --package_version 2.27.0 --container_type Docker
```

**Find the smallest Singularity image available:**
```bash
bioconda2biocontainer --package_name bedtools --package_version 2.27.0 --container_type Singularity --sort_by_size
```

**Identify the Conda package with the most downloads:**
```bash
bioconda2biocontainer --package_name bedtools --package_version 2.27.0 --container_type Conda --sort_by_download
```

### Discovering Tools

To search the registry for tools based on keywords or functional descriptions, use the `biocontainers-search` command.

**Search for tools by keyword:**
```bash
biocontainers-search --search_term proteomics
```

**Retrieve search results in JSON format for automated parsing:**
```bash
biocontainers-search --search_term mapping --json
```

### Version Discovery

If you are unsure of the exact version string used in the registry, query the package name without a version flag to see all registered IDs and versions.

```bash
bioconda2biocontainer --package_name samtools
```

## Expert Tips

- **Container Type Specificity**: Always define `--container_type` (Docker, Singularity, or Conda) when you need a single URI for a configuration file or script to avoid ambiguous output.
- **Metadata Verification**: Use the `--all` flag to check the `updated` timestamp. This helps ensure you are not pulling an outdated build if multiple builds exist for the same version.
- **Sorting Logic**: When using `--sort_by_size`, the tool helps optimize workflow performance by identifying the most lightweight image, which reduces pull times in cloud environments.
- **Registry API**: Note that these scripts query `api.biocontainers.pro`. If the tool returns no results, verify the package name matches the Bioconda recipe name exactly.

## Reference documentation
- [bioconda2biocontainer README](./references/github_com_BioContainers_bioconda2biocontainer_blob_master_README.md)