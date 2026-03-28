---
name: merqury
description: Merqury evaluates genome assembly quality and completeness by comparing assembly k-mer spectra against raw sequencing read k-mer spectra. Use when user asks to quantify assembly accuracy, calculate consensus quality scores, assess k-mer completeness, or perform trio-based phasing evaluation.
homepage: https://github.com/marbl/merqury
---

# merqury

## Overview
Merqury is a toolkit designed for the independent evaluation of genome assemblies by comparing the k-mer spectrum of the assembly against the k-mer spectrum of the raw sequencing reads (typically Illumina). It allows researchers to quantify assembly accuracy and completeness without requiring a high-quality reference genome. It is particularly powerful for diploid or polyploid genomes where it can assess how well different haplotypes have been separated or "binned."

## Core Workflow

### 1. Database Preparation
Before running Merqury, you must generate k-mer databases using `meryl`.

*   **Determine k-size**: Use the `best_k.sh` script based on your genome size.
    ```bash
    $MERQURY/best_k.sh <genome_size>
    ```
    *Note: k=31 is generally recommended for human-sized genomes to improve QV prediction accuracy.*
*   **Build Read Database**:
    ```bash
    meryl k=31 count output reads.meryl reads.fastq.gz
    ```

### 2. Standard Assembly Evaluation
For a single or diploid assembly without parental data:
```bash
# Usage: merqury.sh <read-db.meryl> <asm1.fasta> [asm2.fasta] <out_prefix>
$MERQURY/merqury.sh reads.meryl primary.fasta associated.fasta output_name
```

### 3. Trio-Based Evaluation (Phasing)
If parental Illumina data is available, first generate "hap-mers" (haplotype-specific k-mers):
```bash
# Generate hap-mers
$MERQURY/trio/hapmers.sh mat.meryl pat.meryl child.meryl

# Run Merqury with hap-mers
$MERQURY/merqury.sh child.meryl mat.hapmers.meryl pat.hapmers.meryl asm1.fasta asm2.fasta output_name
```

## Key Outputs and Interpretation

*   **QV (.qv)**: Provides consensus quality scores and error rates. Higher QV indicates fewer base-calling errors in the assembly.
*   **Completeness (.completeness.stats)**: Measures the fraction of "solid" k-mers from the reads found in the assembly.
*   **Spectra-CN Plots (.spectra-cn.st.png)**: Stacked histograms showing k-mer copy number distribution.
    *   *Red bar at 0*: K-mers present in the assembly but missing from reads (likely assembly errors).
    *   *Black distribution*: K-mers in reads missing from the assembly (missing genomic content).
*   **Hap-mer Plots**: In trio mode, these visualize the separation of maternal and paternal k-mers to detect "switches" or mis-binning.

## Expert Tips
*   **Memory Management**: `meryl` defaults to using all available memory. Limit it on shared systems using `memory=48g` as a parameter in the meryl command.
*   **Compressed K-mers**: For assemblies like Verkko that use homopolymer compression, ensure you use the `-c` flag during meryl counting and Merqury execution.
*   **Input Formats**: Merqury accepts `.fasta` and `.fa` extensions. Ensure your meryl databases end in the `.meryl` suffix.
*   **Parallelization**: For large genomes, use the `_submit_merqury.sh` script to leverage SLURM job arrays for faster processing.



## Subcommands

| Command | Description |
|---------|-------------|
| merqury.sh | Generates k-mer counts for read sets and assemblies to assess assembly quality. |
| meryl | A meryl command line is formed as a series of commands and files, possibly grouped using square brackets. Each command operates on the file(s) that are listed after it. |

## Reference documentation
- [Prepare meryl dbs](./references/github_com_marbl_merqury_wiki_1.-Prepare-meryl-dbs.md)
- [Overall k-mer evaluation](./references/github_com_marbl_merqury_wiki_2.-Overall-k-mer-evaluation.md)
- [Phasing assessment with hap-mers](./references/github_com_marbl_merqury_wiki_3.-Phasing-assessment-with-hap-mers.md)