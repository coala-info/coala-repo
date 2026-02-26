---
name: pgscatalog-utils
description: This tool retrieves, standardizes, and applies polygenic scores from the PGS Catalog to genomic data. Use when user asks to download scoring files, match variants between scores and target genotypes, calculate polygenic scores, or perform ancestry-based score normalization.
homepage: https://github.com/PGScatalog/pygscatalog
---


# pgscatalog-utils

## Overview

This skill provides a specialized workflow for interacting with the Polygenic Score (PGS) Catalog and applying polygenic scores to genomic data. It enables the automated retrieval of standardized scoring files, variant matching between scores and target genotypes, and the calculation of scores with optional ancestry-based normalization. Use this skill when you need to perform reproducible PGS analysis, ensure genome build consistency, or validate scoring file formats against the official PGS Catalog schema.

## Core CLI Applications

The `pgscatalog-utils` package (also known as `pygscatalog`) is a suite of modular tools. Below are the primary commands and their use cases.

### 1. Data Acquisition and Preparation
*   **pgscatalog-download**: Fetches scoring files from the PGS Catalog.
    *   *Tip*: Always specify the genome build (`-b`) to ensure compatibility with your target genotype data.
*   **pgscatalog-format**: Standardizes custom or downloaded scoring files into a consistent schema.
*   **pgscatalog-validate**: Verifies that a scoring file adheres to the PGS Catalog format requirements.

### 2. Variant Matching
Matching is a critical step to ensure that the effect alleles in the scoring file correctly correspond to the alleles in your target sample (VCF/BGEN).
*   **pgscatalog-match**: Matches structured scoring files to variants in target genomes. It handles strand flips and allele orientation.
*   **pgscatalog-matchmerge**: Used for large datasets to merge match results from multiple runs or chromosomes.
*   **pgscatalog-intersect**: Identifies overlapping variants across two different variant information files (e.g., comparing a reference panel to a target genome).

### 3. Score Calculation and Adjustment
*   **pgsc_calc load**: Converts indexed VCF or BGEN files into a Zarr archive for high-performance access.
*   **pgsc_calc score**: Calculates polygenic scores directly from the Zarr archives created by the load command.
*   **pgscatalog-aggregate**: Combines calculated PGS results that were split across multiple files or chromosomes.
*   **pgscatalog-ancestry-adjust**: Adjusts calculated scores based on genetic ancestry similarity estimation and normalization.

## Common Workflow Patterns

### Downloading and Validating
To fetch a specific score and ensure it is ready for use:
```bash
pgscatalog-download --id PGS000001 --build GRCh38 -o my_scores/
pgscatalog-validate --scorefile my_scores/PGS000001.txt.gz
```

### Matching Variants
To match a scoring file against a target VCF:
```bash
pgscatalog-match --scorefile scores.txt --target target_genotypes.vcf.gz --outdir match_results/
```

### High-Performance Calculation
For large-scale biobank data, use the Zarr-based workflow:
1.  **Load**: `pgsc_calc load --vcf target.vcf.gz --out target.zarr.zip`
2.  **Score**: `pgsc_calc score --zarr target.zarr.zip --scorefile matched_scores.txt --out final_scores.tsv`

## Expert Tips
*   **Namespace Modularity**: If you are developing custom Python scripts, you can import specific libraries like `pgscatalog.core` for data handling, `pgscatalog.match` for variant logic, and `pgscatalog.calc` for ancestry adjustments.
*   **Relabeling**: Use `pgscatalog-relabel` if your target genotype IDs (e.g., RSIDs) do not match the IDs in the scoring file but share a common mapping in a separate file.
*   **Memory Management**: When working with large-scale genomic data, prefer the `pgsc_calc` Zarr-based commands as they are optimized for chunked, parallel access compared to raw VCF parsing.

## Reference documentation
- [pygscatalog README](./references/github_com_PGScatalog_pygscatalog.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_pgscatalog-utils_overview.md)