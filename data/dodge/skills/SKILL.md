---
name: dodge
description: DODGE identifies bacterial outbreak clusters from genomic datasets by integrating genetic differences with temporal metadata for continuous surveillance. Use when user asks to identify investigation clusters, perform longitudinal outbreak detection, analyze cgMLST or SNP-based genomic data, or establish background population clusters.
homepage: https://github.com/LanLab/dodge
metadata:
  docker_image: "quay.io/biocontainers/dodge:1.0.1--pyhdfd78af_0"
---

# dodge

## Overview

DODGE (Dynamic Outbreak Detection for Genomic Epidemiology) is a specialized tool for public health microbiology that identifies bacterial outbreak clusters from large-scale genomic datasets. Unlike static clustering tools, DODGE is designed for continuous surveillance. it processes genetic difference data alongside temporal metadata to distinguish between stable background populations and active "investigation clusters" that warrant epidemiological follow-up. It supports both allele-based (cgMLST) and SNP-based (Snippy) inputs and can utilize nomenclature from systems like Enterobase (hierCC) or MGTdb.

## Core CLI Usage

The primary entry point is `dodge.py`. You must specify the input type, the variant data, and the associated metadata.

### Basic Execution Patterns

**Allele-based Analysis (cgMLST):**
```bash
dodge.py -i allele_profiles.tab --inputtype allele -s strain_metadata.tab --outputPrefix results/outbreak_analysis
```

**SNP-based Analysis:**
```bash
dodge.py -i ./vcf_directory/ --inputtype snp -s snp_metadata.tab --outputPrefix results/snp_analysis
```
*Note: For SNP inputs, the directory should contain `.subs.vcf` and optionally `.consensus.subs.fa` files produced by Snippy.*

### Longitudinal Surveillance Workflow

DODGE is most effective when used in a multi-step process to track clusters over time.

1.  **Establish Background:** Run the tool on historical data to define existing clusters without triggering outbreak alerts.
    ```bash
    dodge.py -i historical_data.tab --inputtype allele -s historical_meta.tab --outputPrefix background --background_data
    ```
2.  **Incremental Analysis:** Use the output from the background run (or a previous time period) to analyze new data.
    ```bash
    dodge.py -i new_data.tab --inputtype allele -s new_meta.tab -c background_all_clusters.txt --outputPrefix period_1
    ```

## Expert Tips and Best Practices

### Performance Optimization
For large datasets, pairwise distance calculation is the bottleneck.
*   **Precompute Distances:** Use the `pairwise_dist.py` script to generate a matrix, then pass it with `-d`.
*   **Multithreading:** Use `-n` (default is 8) to increase the number of cores for distance calculations.
    ```bash
    dodge.py -i data.tab --inputtype allele -s meta.tab --outputPrefix out -n 16 -d precomputed_distances.txt
    ```

### Metadata Requirements
*   **SNP Data:** Requires a tab-delimited file with 'Strain' (or 'Isolate'), 'Year', 'Month', and 'Date' columns.
*   **Isolate Mapping:** If your metadata column for strain names isn't 'Strain', 'Name', or 'Isolate', specify it using `--isolatecolumn`.

### SNP-Specific Refinements
*   **Quality Filtering:** Use `--snpqual` (default 1000) to filter low-confidence calls.
*   **Masking:** Use `--mask` with a BED file to exclude problematic regions (e.g., phages or repetitive regions) from the analysis.
*   **Missing Data:** Use `--usegenomes` to allow the tool to check consensus FASTA files for missing data when a SNP is not called at a specific position.

### Interpreting Outputs
*   **_investigation_clusters.txt:** This is the primary file for epidemiologists. It lists clusters flagged as potential outbreaks.
*   **Status Column:** Pay attention to the `status` field in output files, which labels clusters as `new`, `expanded`, or `unchanged`.
*   **Nomenclature:** If using Enterobase data, ensure `--enterobase_data` is set to utilize hierCC levels for cluster naming.

## Reference documentation
- [DODGE GitHub Repository](./references/github_com_LanLab_dodge.md)
- [Bioconda DODGE Overview](./references/anaconda_org_channels_bioconda_packages_dodge_overview.md)