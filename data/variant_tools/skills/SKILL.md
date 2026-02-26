---
name: variant_tools
description: `variant_tools` is a project-based framework for manipulating, analyzing, and annotating large-scale genetic variant data. Use when user asks to initialize a project, import variants, access annotation databases, select or filter variants, export variants, or manage multi-sample datasets.
homepage: https://github.com/vatlab/varianttools
---


# variant_tools

## Overview
The `variant_tools` suite (accessed via the `vtools` command) is a project-based framework for the manipulation and analysis of large-scale genetic variant data. It excels at integrating raw variant calls with functional annotations, allowing for complex filtering and selection workflows. It is particularly useful for researchers who need to manage multi-sample datasets and perform population-level or family-based variant prioritization.

## Installation and Setup
The tool is best managed via Conda to ensure all C++ dependencies (Boost, GSL, HDF5) are correctly linked.

```bash
# Recommended installation
conda install variant_tools -c bioconda -c conda-forge
```

## Core CLI Workflow
Most operations in `variant_tools` require an active project.

### 1. Project Initialization
Before importing data, initialize a project container.
```bash
vtools init <project_name>
```

### 2. Data Importation
Import variants from VCF or other supported formats. The tool handles the normalization of indels during this phase to ensure genotype consistency.
```bash
vtools import <file.vcf> --build <genome_build>
```

### 3. Annotation and Database Access
`variant_tools` relies on an annotation database system. You can check available resources or link to specific databases.
```bash
# Check available tests and resources
vtools show tests

# Access or update annotation databases
vtools show annotations
```

### 4. Variant Selection and Filtering
Use the `select` command to isolate variants based on quality, frequency, or functional impact.
```bash
# Example pattern for selecting variants
vtools select <table_name> <condition> -t <target_table>
```

### 5. Data Output and Exporting
Export filtered variants or genotypes for downstream tools.
```bash
# Export variants to a specific format
vtools export <table_name> --format vcf > output.vcf

# Output specific fields or genotypes
vtools output <table_name> <fields>
```

## Expert Tips
- **Indel Normalization**: Always ensure variants are normalized during import (default in recent versions) to prevent the same indel from being treated as multiple distinct variants due to different representations.
- **Genotype Filtering**: Use the `genotype()` function within selection queries to filter based on sample-specific attributes like depth (DP) or genotype quality (GQ).
- **Project Portability**: Since `variant_tools` uses a database backend, ensure you move the entire project directory if transferring data between environments.
- **Process Management**: For Python 3.8+ environments, the tool is configured to handle subprocess creation via the fork method to maintain stability during heavy parallel processing.

## Reference documentation
- [github_com_vatlab_varianttools.md](./references/github_com_vatlab_varianttools.md)
- [anaconda_org_channels_bioconda_packages_variant_tools_overview.md](./references/anaconda_org_channels_bioconda_packages_variant_tools_overview.md)
- [github_com_vatlab_varianttools_issues.md](./references/github_com_vatlab_varianttools_issues.md)