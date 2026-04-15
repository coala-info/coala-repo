---
name: pgscatalog-utils
description: pgscatalog-utils is a suite of command-line tools designed to automate the application of polygenic scores from the PGS Catalog to genetic data. Use when user asks to download scoring files, standardize file formats, match variants to target genotypes, or perform ancestry-adjusted score normalization.
homepage: https://github.com/PGScatalog/pygscatalog
metadata:
  docker_image: "quay.io/biocontainers/pgscatalog-utils:2.0.2--pyhdfd78af_0"
---

# pgscatalog-utils

## Overview

The `pgscatalog-utils` suite provides a modular set of command-line applications designed to streamline the application of polygenic scores from the PGS Catalog to genetic data. It handles the entire lifecycle of PGS application, including automated downloading of scoring files in specific genome builds, standardizing file formats, matching variants to target genotypes (handling strand flips and ambiguous alleles), and performing final score aggregation and ancestry-adjusted normalization.

## Core CLI Applications

### Data Acquisition and Preparation
- `pgscatalog-download`: Fetches scoring files from the PGS Catalog. Use the `-b` flag to specify the target genome build (e.g., GRCh37 or GRCh38).
- `pgscatalog-format`: Standardizes various scoring file formats into a consistent schema. This is a prerequisite for matching and calculation.
- `pgscatalog-validate`: Ensures scoring files adhere to the PGS Catalog standard format before processing.

### Variant Matching
- `pgscatalog-match`: Matches variants in scoring files to those in target genomes (VCF/BGEN/PGEN).
    - **Best Practice**: Use `--keep_ambiguous` only if you have external information to resolve A/T and C/G variants; otherwise, they are typically excluded to prevent strand errors.
    - **Performance**: For large datasets, use `pgscatalog-matchmerge` to combine results from parallelized matching runs.
- `pgscatalog-intersect`: Identifies common variants across different variant information files, useful for aligning reference and target panels.

### Score Calculation and Adjustment
- `pgscatalog-aggregate`: Combines calculated scores that were split across multiple files or chromosomes.
    - **Tip**: Use `--verify_variants` to ensure the variants used in calculation perfectly match the input scoring file.
- `pgscatalog-ancestry-adjust`: Adjusts raw polygenic scores based on genetic ancestry similarity, typically using PCA-based methods to provide normalized scores.

## Expert Tips

- **Namespace Modularity**: The tools are distributed as namespace packages (e.g., `pgscatalog.core`, `pgscatalog.match`, `pgscatalog.calc`). If you only need specific functionality, you can install just that component to minimize dependencies.
- **Multiprocessing**: `pgscatalog-format` supports multiprocessing. When dealing with many scoring files, ensure you leverage this to write to separate output files simultaneously.
- **Handling Strand Flips**: The matching engine is designed to automatically detect and correct strand flips. If you are certain your data is on the same strand as the scoring file, you can use `--ignore_strand_flips` to speed up processing, though this is generally discouraged for clinical or high-precision research.
- **Sample ID Handling**: `pgscatalog-calc` utilities prioritize Family IDs (FID) if available in the input genetic data to ensure compatibility with PLINK-style downstream analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| pgscatalog-aggregate | Aggregate plink .sscore files into a combined TSV table. |
| pgscatalog-ancestry-adjust | Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs:    - PCA projections from reference and target datasets (*.pcs)    - calculated polygenic scores (e.g. aggregated_scores.txt.gz),    - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id). |
| pgscatalog-download | Download a set of scoring files from the PGS Catalog using PGS Scoring IDs, traits, or publication accessions. |
| pgscatalog-intersect | Program to find matched variants (same strand) between a set of reference and target data .pvar/bim files. This also evaluate whether the variants in the TARGET are suitable for inclusion in a PCA analysis (excludes strand ambiguous and multi-allelic/INDEL variants), and can also uses the .afreq and .vmiss files exclude variants with missingness and MAF filters. |
| pgscatalog-match | Match variants from a combined scoring file against a set of target genomes from the same fileset, and output scoring files compatible with the plink2 --score function. |
| pgscatalog-matchmerge | Match and merge score files with genotype data. |
| pgscatalog-relabel | Relabel the column values in one file based on a pair of columns in another |

## Reference documentation

- [PGS Catalog Utilities Overview](./references/github_com_PGScatalog_pygscatalog_blob_main_README.md)
- [Core Package Guide (Download/Format)](./references/github_com_PGScatalog_pygscatalog_blob_main_pgscatalog.utils_packages_pgscatalog.core_README.md)
- [Calculation and Ancestry Adjustment Guide](./references/github_com_PGScatalog_pygscatalog_blob_main_pgscatalog.utils_packages_pgscatalog.calc_README.md)
- [Version History and Patch Notes](./references/github_com_PGScatalog_pygscatalog_blob_main_CHANGELOG.md)