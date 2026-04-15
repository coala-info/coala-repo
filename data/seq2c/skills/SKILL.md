---
name: seq2c
description: Seq2C is a gene-centric framework that identifies copy number variations and genomic imbalances by comparing read depths across targeted sequencing regions. Use when user asks to call CNVs from NGS panels, detect intragenic deletions or amplifications, and normalize sequencing coverage using cohort-based statistics.
homepage: https://github.com/AstraZeneca-NGS/Seq2C
metadata:
  docker_image: "quay.io/biocontainers/seq2c:2019.05.30--pl526_0"
---

# seq2c

## Overview

Seq2C is a gene-centric CNV calling framework that identifies genomic imbalances by comparing read depths across targeted regions. It transforms raw sequencing coverage into normalized log2 ratios, allowing for the detection of significant copy number changes even in the absence of matched normal controls by utilizing cohort-based statistics. The tool is particularly effective for clinical NGS panels where identifying intragenic breakpoints (such as single-exon deletions) is critical.

## Environment Setup

Ensure the following prerequisites are met before execution:
- **Dependencies**: Install `samtools` and ensure Perl (v5.8+) is available.
- **Path Configuration**: Add the Seq2C scripts directory and the `plotting` subdirectory to your system PATH to ensure `seq2c.sh` can locate its component Perl scripts.

## Core Workflow

The primary entry point is the `seq2c.sh` wrapper script, which executes the full pipeline (coverage calculation, read mapping statistics, normalization, and gene-level calling).

### 1. Prepare Input Files

- **Sample Mapping (`sample2bam.txt`)**: Create a tab-delimited file with two columns: `Sample_Name` and `Path_to_BAM`.
  - **CRITICAL**: The file must contain one empty line at the very end to be parsed correctly.
- **Target Regions (`.bed`)**:
  - **Simple Mode**: Use a 4-column BED (Chr, Start, End, Gene_Name).
  - **Amplicon Mode**: Use an 8-column BED. Column 7 must be the amplicon start and Column 8 the amplicon end.

### 2. Execute the Pipeline

Run the main wrapper script:
```bash
seq2c.sh sample2bam.txt regions.bed [control_sample1:control_sample2]
```
If multiple control samples are used, separate them with colons.

### 3. Interpret Results

The output `seq2c_results.txt` provides several key metrics:
- **Log2ratio**: The normalized median depth ratio.
- **Sig**: Significance indicator (0 typically indicates a call).
- **Amp_Del**: Categorical call (AMP for amplification, DEL for deletion).
- **Ab_Seg / Total_Seg**: Ratio of affected segments to total segments in the gene, useful for identifying partial gene deletions.

## Expert Tips and Best Practices

- **Cohort Size**: When running without a matched normal control, use a large, heterogeneous cohort. A minimum of 10 samples is required, but >30 samples is highly recommended for robust MAD (Median Absolute Deviation) normalization.
- **Systemic Bias**: If samples share a common origin (e.g., different clones from the same cell line), always include a known diploid normal control to prevent systemic shifts in log2 ratios.
- **Amplicon Parameters**: For PCR-based sequencing, use the `-a` option in the underlying `seq2cov.pl` script (defaulting to `10:0.95`) to ensure reads are only counted if they align strictly within the primer-defined boundaries.
- **Advanced Normalization**: If the cohort size exceeds 30, consider using the `-M` option in `cov2lr.pl` to adjust the MAD during distribution transformation for better performance.
- **Gender Handling**: For sex chromosome analysis, run `testGender.pl` or provide gender files to the sub-scripts to avoid false positive calls on ChrX and ChrY.



## Subcommands

| Command | Description |
|---------|-------------|
| perl cov2lr.pl | The cov2lr.pl program will convert a coverage file to copy number profile. |
| seq2c_lr2gene.pl | The lr2gene.pl program will convert a coverage file to copy number profile. The default parameters are designed for detecting such aberrations for high tumor purity samples, such as cancer cell lines. |
| seq2cov.pl | Calculate candidate variance for a given region(s) in an indexed BAM file. The default input is IGV's one or more entries in refGene.txt, but can be regions. |

## Reference documentation
- [Seq2C Main Repository](./references/github_com_AstraZeneca-NGS_Seq2C.md)
- [Seq2C Wiki Home](./references/github_com_AstraZeneca-NGS_Seq2C_wiki.md)