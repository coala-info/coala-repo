---
name: optimir
description: OptimiR is a bioinformatics workflow designed for the alignment of microRNA sequencing data that incorporates genetic variation to identify polymiRs and isomiRs. Use when user asks to prepare reference libraries from VCF files, process miRSeq fastq files, or aggregate results into abundance and consistency tables.
homepage: https://github.com/FlorianThibord/OptimiR
---

# optimir

## Overview
OptimiR is a specialized bioinformatics workflow designed for the alignment of microRNA sequencing (miRSeq) data. Unlike general-purpose aligners, it specifically accounts for genetic variation by incorporating VCF files to generate "polymiRs"—alternative miRNA sequences containing known variants. It also provides detailed analysis of isomiRs, including modifications like trimming, templated tailing, and non-templated tailing. This skill provides the necessary command-line patterns to process raw fastq files, manage reference libraries, and interpret the resulting abundance and consistency tables.

## Core Workflows

### 1. Library Preparation
Before processing samples, you must prepare the reference library. This step extracts variants from a VCF that map to miRNA coordinates and generates the necessary alignment indices.

```bash
optimir libprep -v genotypes.vcf -o ./output_dir
```
*   **Tip**: If you are using non-default miRBase versions, specify the paths to matures (`-m`), hairpins (`-p`), and GFF3 (`-g`) files.
*   **Note**: Running `libprep` separately is recommended when processing multiple samples in parallel to avoid redundant index generation.

### 2. Sample Processing
The `process` command handles the actual alignment of miRSeq reads.

```bash
optimir process --fq sample.fq.gz --vcf genotypes.vcf --dir_output ./output_dir --gff_out
```
*   **Sample Naming**: Ensure the sample name inside the VCF matches the fastq filename (excluding extension) for the genotype consistency analysis to work.
*   **Temporary Files**: By default, OptimiR keeps temporary files in `OptimiR_tmp`. If you re-run a sample, it will skip the trimming step to save time unless `--trimAgain` is used. Use `--rmTempFiles` to clean up after a successful run.

### 3. Summarization
After processing all samples in a project, aggregate the results into a single summary.

```bash
optimir summarize --dir ./output_dir/OptimiR_Results
```

## Expert Tips and Best Practices

### Handling Variants
*   **Multi-allelic Sites**: OptimiR requires multi-allelic variants to be split into separate lines in the VCF.
*   **Genotype Consistency**: Providing a VCF with genotypes allows OptimiR to filter out alignments that are inconsistent with the individual's genetic makeup. This is critical for accurate Allele Specific Expression (ASE) analysis.
*   **Coordinates**: Ensure your VCF uses GRCh38 coordinates if you are using the default miRBase 21 resources.

### Understanding Outputs
*   **miRs_and_polymiRs_abundances**: This is the primary count table. PolymiRs are denoted with a `_na` suffix for alternative sequences.
*   **Consistency Table**: Use this to check the reliability of polymiR detections. High "inconsistent" counts may suggest sequencing errors or sample swaps.
*   **IsomiR Distribution**: The workflow categorizes reads into:
    *   **Canonical**: Exact match to reference.
    *   **Trim**: Deletions at ends.
    *   **TA (Templated Tailing)**: Additions matching the precursor hairpin.
    *   **NTA (Non-templated Tailing)**: Additions not matching the precursor (e.g., uridylation/adenylation).

### Downstream Analysis
OptimiR includes R scripts for visualization located in the installation directory (`optimir/libs/R_plot/`):
*   Use `plot_ASE.R` on `polymiRs_table.annot` to visualize Allele Specific Expression.
*   Use `plot_isoDist.R` on `isomiRs_dist.annot` to view the global distribution of isomiR modifications.



## Subcommands

| Command | Description |
|---------|-------------|
| optimir libprep | Prepare reference libraries for OptimiR. |
| optimir summarize | Summarize optimir results |
| optimir_process | Processes sequencing data to identify and analyze microRNAs. |

## Reference documentation
- [OptimiR README](./references/github_com_FlorianThibord_OptimiR_blob_master_README.md)
- [Example Execution Script](./references/github_com_FlorianThibord_OptimiR_blob_master_example_all.sh.md)