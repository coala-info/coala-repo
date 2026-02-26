---
name: pgscatalog.core
description: The pgscatalog.core package downloads, formats, and manages polygenic scoring files from the PGS Catalog. Use when user asks to download scoring files by ID or trait, standardize scoring file schemas, or relabel variant identifiers to match genotype data.
homepage: https://github.com/PGScatalog/pygscatalog/
---


# pgscatalog.core

## Overview

The `pgscatalog.core` package is the foundational library for the PGS Catalog utility suite. It simplifies the process of acquiring and preparing polygenic scoring files—which contain the variant weights necessary for calculating genetic risk. Use this skill to programmatically download data from the PGS Catalog, ensure scoring files adhere to a consistent format, and manage variant ID mapping. It is particularly useful for ensuring that scoring files match the genome build (e.g., GRCh37 or GRCh38) of your target genotype data.

## Installation

Install the core tools using pipx (recommended for CLI apps) or conda:

```bash
pipx install pgscatalog.core
# OR
conda install -c bioconda pgscatalog.core
```

## Common CLI Patterns

### Downloading Scoring Files
The `pgscatalog-download` tool retrieves scoring files directly from the PGS Catalog.

*   **Download by PGS ID**:
    ```bash
    pgscatalog-download -i PGS000001 PGS000002 --genome_build GRCh38 -o ./scoring_files/
    ```
*   **Download by Trait ID (EFO)**:
    ```bash
    pgscatalog-download -t EFO_0001645 --genome_build GRCh37 -o ./trait_scores/
    ```

### Formatting Scoring Files
The `pgscatalog-format` tool standardizes various scoring file versions into a consistent, machine-readable schema. This is a critical step before attempting to match variants to a target genome.

```bash
pgscatalog-format -s raw_score_file.txt -o formatted_score_file.txt.gz
```

### Relabeling Variant IDs
Use `pgscatalog-relabel` when you need to change variant identifiers in a scoring file to match your genotype data (e.g., changing rsIDs to chromosome:position format).

```bash
pgscatalog-relabel --input scoring_file.txt --maps mapping_file.txt --cols target_col:map_col
```

## Expert Tips and Best Practices

1.  **Genome Build Consistency**: Always explicitly define the `--genome_build` (GRCh37 or GRCh38) during download. The PGS Catalog often hosts scores in multiple builds; using the wrong one will result in zero matches during the scoring process.
2.  **Automated Formatting**: Even if a file looks "correct," always run it through `pgscatalog-format`. This tool handles edge cases in header metadata and column naming that can break downstream calculation engines.
3.  **Batch Processing**: `pgscatalog-download` supports multiple IDs in a single command. Use this to minimize API overhead when setting up large-scale benchmarks.
4.  **Namespace Awareness**: Remember that `pgscatalog.core` is part of a modular ecosystem. It handles data acquisition and formatting, while `pgscatalog.match` handles variant matching and `pgscatalog.calc` handles the actual score summation.

## Reference documentation
- [pygscatalog README](./references/github_com_PGScatalog_pygscatalog.md)
- [pgscatalog.core Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_pgscatalog.core_overview.md)