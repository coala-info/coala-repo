---
name: seq2c
description: Seq2C is a gene-centric CNV discovery tool that identifies genomic amplifications and deletions by normalizing read coverage into log2 ratios.
homepage: https://github.com/AstraZeneca-NGS/Seq2C
---

# seq2c

## Overview

Seq2C is a gene-centric CNV discovery tool that identifies genomic amplifications and deletions by normalizing read coverage into log2 ratios. Unlike tools that rely strictly on matched pairs, Seq2C can utilize cohort-level statistics to establish a baseline, making it highly effective for large-scale sequencing projects. It provides both gene-level calls and intragenic breakpoint analysis (e.g., exon-level deletions in BRCA1/2).

## Core Workflow

The primary entry point is the `seq2c.sh` wrapper script, which executes the underlying Perl components (`seq2cov.pl`, `bam2reads.pl`, `cov2lr.pl`, and `lr2gene.pl`) in sequence.

### Basic Usage
```bash
seq2c.sh sample2bam.txt regions.bed [control_sample1:control_sample2]
```

### Input Requirements
1.  **sample2bam.txt**: A tab-delimited file containing the sample name and the absolute path to the indexed BAM file.
    *   **CRITICAL**: The file must contain one empty line at the very end.
    *   Format: `SampleName    /path/to/sample.bam`
2.  **BED File**:
    *   **Simple Mode (4 columns)**: `Chr  Start  End  Gene`
    *   **Amplicon Mode (8 columns)**: Used for PCR-based calling. Columns 7 and 8 must contain the specific amplicon start and end coordinates.
3.  **Control Samples (Optional)**: A colon-separated list of sample names (matching the IDs in `sample2bam.txt`) to be used as the normalization baseline.

## Expert Tips and Best Practices

### Cohort Composition
*   **Sample Size**: When running without matched normal controls, use a cohort of at least 10 samples. For optimal normalization, a cohort of >30 samples is recommended.
*   **Heterogeneity**: Ensure the cohort is heterogeneous. If more than 50% of the samples in a cohort share the same amplification or deletion, the normalization logic may treat the variant as the baseline, leading to false negatives.
*   **Systemic Shifts**: If analyzing samples from the same origin (e.g., multiple clones from one cell line), you must include a known diploid normal control to prevent systemic log2ratio shifts.

### Advanced Scripting Patterns
If you need to inject specific parameters like tumor purity or gender files, run the individual components manually:

1.  **Generate Coverage**: `seq2cov.pl -b sample.bam regions.bed > coverage.txt`
2.  **Generate Read Stats**: `bam2reads.pl sample2bam.txt > read_stats.txt`
3.  **Calculate Log2 Ratios**: `cov2lr.pl read_stats.txt coverage.txt > log2ratios.txt`
    *   Use `-M` for cohorts >30 to adjust Median Absolute Deviation (MAD).
    *   Use `-a` for exon-level or amplicon-based calling instead of gene-level aggregation.
4.  **Call CNVs**: `lr2gene.pl log2ratios.txt > seq2c_results.txt`

### Output Interpretation
The `seq2c_results.txt` file includes several key columns:
*   **Log2ratio**: The normalized median depth ratio.
*   **Sig**: Significance level (0 indicates a high-confidence AMP or DEL).
*   **Ab_Seg / Total_Seg**: The ratio of affected segments to total segments in the gene, useful for identifying partial gene deletions.

## Reference documentation
- [Seq2C Main Documentation](./references/github_com_AstraZeneca-NGS_Seq2C.md)
- [Seq2C Wiki and Cohort Guidance](./references/github_com_AstraZeneca-NGS_Seq2C_wiki.md)