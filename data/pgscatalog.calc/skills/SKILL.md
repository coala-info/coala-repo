---
name: pgscatalog.calc
description: This tool calculates polygenic scores and performs statistical adjustments based on genetic ancestry. Use when user asks to calculate polygenic scores, convert genomic data to Zarr format, aggregate results from multiple files, or adjust scores for genetic ancestry.
homepage: https://github.com/PGScatalog/pygscatalog/
---


# pgscatalog.calc

## Overview
The `pgscatalog.calc` package provides specialized tools for the final stages of polygenic score application. While other components of the suite handle downloading and matching, this skill focuses on the computational execution of scores and the statistical adjustment of those scores based on genetic ancestry. It introduces a high-performance Zarr-based workflow (`pgsc_calc`) for handling large-scale genomic data efficiently and provides utilities to merge results across split genomic files.

## Installation
Install the package via bioconda or pip:
```bash
conda install bioconda::pgscatalog.calc
# OR
pip install pgscatalog.calc
```

## Core CLI Workflows

### 1. High-Performance Scoring (Zarr Workflow)
For large datasets, use the two-step `pgsc_calc` process which converts genomic data to an optimized Zarr format before scoring.

**Step A: Load and Index**
Convert VCF or BGEN files into a compressed Zarr archive:
```bash
pgsc_calc load --input target_genotypes.vcf.gz --output genotypes.zarr.zip
```

**Step B: Calculate Scores**
Execute the calculation using the prepared Zarr archive and a matched scoring file:
```bash
pgsc_calc score --zarr genotypes.zarr.zip --scorefile matched_scores.txt.gz --output results.txt.gz
```

### 2. Aggregating Results
If scores were calculated per-chromosome or across multiple batches, use `pgscatalog-aggregate` to combine them into a single dataset:
```bash
pgscatalog-aggregate --input score_file_1.txt score_file_2.txt --output combined_scores.txt.gz
```

### 3. Genetic Ancestry Adjustment
To normalize scores and account for ancestry-driven variation, use the adjustment tool. This typically requires a reference distribution or principal components (PCs):
```bash
pgscatalog-ancestry-adjust --scorefile combined_scores.txt.gz --pcs samples_pcs.txt --output adjusted_scores.txt.gz
```

## Expert Tips and Best Practices
- **Handling Ambiguous Variants**: When running `pgsc_calc score`, use the `--keep_ambiguous` or `--keep_multiallelic` flags if your research design requires including variants that are typically filtered out for strand-ambiguity or complexity.
- **Memory Efficiency**: The Zarr-based `pgsc_calc` workflow is significantly more memory-efficient than traditional text-based processing. Always prefer `pgsc_calc load` for datasets exceeding a few hundred samples.
- **Input Validation**: Ensure your scoring files have been processed by `pgscatalog-match` before attempting calculation, as `pgscatalog.calc` expects variants to be pre-aligned to the target genome.
- **Parallelization**: When working with biobank-scale data, run `pgsc_calc load` per chromosome in parallel, then aggregate the final scores.

## Reference documentation
- [pgscatalog.calc Overview](./references/anaconda_org_channels_bioconda_packages_pgscatalog.calc_overview.md)
- [pygscatalog Repository Main](./references/github_com_PGScatalog_pygscatalog.md)
- [pygscatalog Version Tags and CLI Flags](./references/github_com_PGScatalog_pygscatalog_tags.md)