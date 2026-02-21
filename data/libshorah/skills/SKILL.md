---
name: libshorah
description: This skill provides procedural knowledge for using `libshorah` (via the `viloca` command-line interface) to reconstruct local haplotypes and call mutations in heterogeneous viral samples.
homepage: https://github.com/LaraFuhrmann/VILOCA
---

# libshorah

## Overview
This skill provides procedural knowledge for using `libshorah` (via the `viloca` command-line interface) to reconstruct local haplotypes and call mutations in heterogeneous viral samples. It excels at processing primary alignments in BAM/CRAM format to produce error-corrected variant calls and frequency estimations, supporting both shotgun sequencing and amplicon-based strategies.

## Core Workflows

### Standard Shotgun Analysis
Use this pattern when analyzing randomly fragmented sequencing data without a specific amplicon scheme.
```bash
viloca run -f reference.fasta -b reads.sorted.bam -w 90 --mode use_quality_scores
```
*   **-w (windowsize)**: Set this to roughly the average length of your reads. This defines the length of the reconstructed haplotypes.

### Targeted Amplicon Analysis
Use this pattern when the sequencing strategy uses specific primers/amplicons. Providing the insert BED file significantly improves accuracy by aligning windows to known genomic regions.
```bash
viloca run -f reference.fasta -b reads.sorted.bam -z scheme.insert.bed --mode use_quality_scores
```

### Model Selection
Choose the appropriate `--mode` based on data quality:
*   `use_quality_scores`: (Recommended) Best for standard Illumina or high-quality long-read data where Phred scores are reliable.
*   `learn_error_params`: Use if sequencing quality scores are untrustworthy or if working with technologies with specific error profiles; the tool will estimate error parameters directly from the data.
*   `shorah`: Use for legacy compatibility with the original ShoRAH algorithm.

## Expert Tips & Constraints

### Input Preparation
*   **Primary Alignments Only**: The input BAM file must contain only primary alignments. Filter your BAM before running `viloca` to remove secondary and supplementary alignments (e.g., using `samtools view -F 2308`).
*   **Indexing**: Ensure your reference FASTA and BAM files are indexed (`samtools faidx` and `samtools index`).

### Parameter Tuning
*   **Variant Filtering**: Use `--exclude_non_var_pos_threshold` to set a frequency floor. Mutations appearing below this percentage (e.g., 0.01 for 1%) will be treated as reference bases.
*   **Posterior Threshold**: The default `-p 0.9` is standard for variant calling. Increase this for higher stringency in low-diversity samples.
*   **Insertions**: By default, insertions are not called. Enable them using the `--extended_window_mode` flag.
*   **Overlap Requirement**: The `--win_min_ext` (default 0.85) controls how much of a read must overlap a window to be included. If you have very short reads relative to your window size, you may need to lower this, though it may increase N-filling.

### Interpreting Output
*   `haplotypes/`: Contains FASTA files for each local region.
*   `cooccurring_mutations.csv`: Essential for linked-variant analysis; shows which mutations appear together on the same reconstructed haplotypes.
*   `coverage.txt`: Check this first to ensure the read depth per window is sufficient for confident reconstruction.

## Reference documentation
- [VILOCA: Viral Local Haplotype Reconstruction](./references/github_com_cbg-ethz_VILOCA.md)
- [libshorah Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_libshorah_overview.md)