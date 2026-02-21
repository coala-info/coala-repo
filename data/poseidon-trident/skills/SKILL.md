---
name: poseidon-trident
description: The `trident` CLI is the primary interface for interacting with Poseidon-formatted genetic data.
homepage: https://poseidon-framework.github.io/#/
---

# poseidon-trident

## Overview
The `trident` CLI is the primary interface for interacting with Poseidon-formatted genetic data. It allows researchers to treat genotype datasets as modular packages, facilitating version control and reproducibility in archaeogenetics. Use this tool to bridge the gap between raw genotype files (EIGENSTRAT/PLINK) and structured, meta-data-rich Poseidon packages.

## Core Command Patterns

### Package Management
*   **Initialize a package**: Create a new Poseidon package from existing genotype data.
    `trident init -g <genotype_file> -p <snp_file> -i <ind_file> -o <output_dir> --packageTitle <name>`
*   **Validate**: Check if a package conforms to the Poseidon specification and if the genotype data matches the meta-data.
    `trident validate -d <package_dir>`
*   **Summarize**: View a high-level summary of individuals, groups, and locations within a package.
    `trident list -d <package_dir> --all`

### Data Manipulation (Forge)
The `forge` command is used to create new datasets by subsetting or merging existing ones.
*   **Subset by Individual**: `trident forge -d <source_dir> -f "Ind(Sample1)" -o <out_dir>`
*   **Subset by Group/Population**: `trident forge -d <source_dir> -f "Group(PopulationName)" -o <out_dir>`
*   **Combine Multiple Criteria**: Use comma-separated lists within the selection language to merge specific sets of data into a new unified package.

### Remote Integration
*   **List Remote**: Browse available datasets on the Poseidon public archives.
    `trident list --remote`
*   **Fetch**: Download specific packages directly from the community repository.
    `trident fetch -d <local_archive_dir> -f <package_name>`

## Best Practices
*   **Directory Structure**: Always point `-d` (base directory) to a folder containing one or more Poseidon packages; `trident` recursively searches for `.yml` files.
*   **Entity Selection**: When using `forge`, remember that the selection language is case-sensitive and relies on the `Poseidon.yml` definitions.
*   **Version Control**: Use the `--ignorePackageVersion` flag only when necessary for compatibility, as Poseidon relies on strict versioning for reproducibility.

## Reference documentation
- [Poseidon Project Homepage](./references/www_poseidon-adna_org_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_poseidon-trident_overview.md)