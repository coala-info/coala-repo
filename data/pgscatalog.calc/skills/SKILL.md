---
name: pgscatalog.calc
description: The pgscatalog.calc package performs polygenic score calculation, result aggregation, and genetic ancestry adjustment using a high-performance scoring engine. Use when user asks to aggregate scores across genomic segments, adjust scores for genetic ancestry, or calculate polygenic scores using the Zarr-based engine.
homepage: https://github.com/PGScatalog/pygscatalog/
metadata:
  docker_image: "quay.io/biocontainers/pgscatalog.calc:0.3.1--pyhdfd78af_1"
---

# pgscatalog.calc

## Overview

The `pgscatalog.calc` package provides specialized tools for the final stages of polygenic score calculation and refinement. While other components of the suite handle downloading and matching, this package focuses on the mathematical execution: aggregating results from genomic segments, adjusting scores to account for genetic ancestry (normalization), and providing a high-performance scoring engine that uses the Zarr format for efficient data handling. It is designed to work seamlessly with outputs from `pgscatalog.match` and is a core component of the PGS Catalog Calculator workflow.

## CLI Usage and Best Practices

### 1. Aggregating Calculated Scores
When scores are calculated across multiple chromosomes or genomic chunks, use `pgscatalog-aggregate` to combine them into a single final report.

*   **Basic Pattern**:
    `pgscatalog-aggregate --scores <score_file1> <score_file2> -o aggregated_scores.txt`
*   **Expert Tip**: Use the `--verify_variants` flag to ensure that the variants in your scoring files perfectly match the variants used during the scoring step. This prevents silent errors where missing variants might lead to underestimated scores.

### 2. Genetic Ancestry Adjustment
To make polygenic scores comparable across different populations, use `pgscatalog-ancestry-adjust`. This tool performs normalization (e.g., calculating Z-scores or percentiles) based on genetic ancestry.

*   **Workflow**:
    1.  Provide the calculated PGS.
    2.  Provide genetic ancestry data (typically PCA projections).
    3.  Run the adjustment to produce normalized outputs.
*   **Key Feature**: It supports adjusting averages and distributions to mitigate the bias often found in PGS when applied to non-European populations.

### 3. High-Performance Scoring (Zarr Engine)
For large-scale datasets, `pgscatalog.calc` introduces the `pgsc_calc` command, which uses an optimized Zarr-based backend.

*   **Loading Data**:
    `pgsc_calc load --vcf <input.vcf.gz> --zarr <output.zarr.zip>`
    This converts standard genomic formats (VCF/BGEN) into an indexed, compressed Zarr archive optimized for rapid scoring.
*   **Calculating Scores**:
    `pgsc_calc score --zarr <input.zarr.zip> --scoring_file <formatted_score.txt> -o results.txt`
    This executes the actual matrix multiplication between genotypes and effect weights.

### 4. Implementation Tips
*   **Sample IDs**: The tool automatically handles Family IDs (FIDs) and Individual IDs (IIDs). If FIDs are available in your input data, they will be used to ensure unique sample identification.
*   **Memory Efficiency**: When working with large cohorts, prefer the `pgsc_calc load/score` workflow over traditional text-based processing to reduce memory overhead and execution time.



## Subcommands

| Command | Description |
|---------|-------------|
| pgscatalog-aggregate | Aggregate plink .sscore files into a combined TSV table. |
| pgscatalog-ancestry-adjust | Program to analyze ancestry outputs of the pgscatalog/pgsc_calc pipeline. Current inputs:    - PCA projections from reference and target datasets (*.pcs)    - calculated polygenic scores (e.g. aggregated_scores.txt.gz),    - information about related samples in the reference dataset (e.g. deg2_hg38.king.cutoff.out.id). |

## Reference documentation
- [pgscatalog.calc README](./references/github_com_PGScatalog_pygscatalog_blob_main_pgscatalog.utils_packages_pgscatalog.calc_README.md)
- [pygscatalog Main README](./references/github_com_PGScatalog_pygscatalog_blob_main_README.md)
- [pygscatalog Changelog](./references/github_com_PGScatalog_pygscatalog_blob_main_CHANGELOG.md)