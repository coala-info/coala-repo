---
name: outrigger
description: "Outrigger identifies and quantifies novel and known alternative splicing events from RNA-seq data using a graph-database approach. Use when user asks to index splice junctions, validate de novo splicing events against a genome, or calculate Percent Spliced-In scores."
homepage: https://yeolab.github.io/outrigger
---


# outrigger

## Overview

Outrigger is a specialized bioinformatics tool that transforms raw RNA-seq junction data into a quantifiable splicing annotation. Unlike traditional tools that rely solely on existing databases, Outrigger uses a graph-database approach to identify novel exons and splicing patterns directly from your samples. It follows a three-stage workflow: indexing junctions to find events, validating those events against genomic sequences, and calculating the inclusion levels (Psi) across samples.

## Core Workflow

### 1. Building the Splicing Index
The `index` command is the most resource-intensive step. It identifies potential exons and builds the graph of splicing events.

*   **Using STAR Junctions (Recommended):** Faster as counts are pre-aggregated.
    ```bash
    outrigger index --sj-out-tab path/to/*SJ.out.tab --gtf annotation.gtf
    ```
*   **Using BAM Files:** Slower; requires sorted and indexed BAMs.
    ```bash
    outrigger index --bams path/to/*.sorted.bam --gtf annotation.gtf
    ```
*   **Optimization Tip:** Use `--n-jobs` to parallelize. Indexing can take 24+ hours on large datasets; at least 4-8 cores are recommended.

### 2. Validating Splice Sites
The `validate` command filters the de novo events to ensure they follow biological rules (e.g., GT/AG or AT/AC motifs).

```bash
outrigger validate --genome mm10 --fasta path/to/genome.fa
```
*   **Note:** You must provide the genome fasta and, ideally, a chromosome sizes file (`-g`) to ensure coordinates are valid.

### 3. Quantifying Percent Spliced-In (Psi)
The `psi` command calculates the final inclusion scores based on the validated index.

```bash
outrigger psi
```
*   **Default Behavior:** If run in the same directory as the previous steps, it automatically finds the `./outrigger_output/index` folder.
*   **Filtering:** Use `--min-reads` (default 10) to adjust the stringency of junction support required for a Psi calculation.

## Expert Tips and Best Practices

*   **Directory Consistency:** Always run `index`, `validate`, and `psi` from the same working directory. Outrigger relies on a specific folder structure (`outrigger_output/`) created during the index step.
*   **Memory Management:** For large datasets or systems with limited RAM, use the `--low-memory` flag available in the `index`, `validate`, and `psi` subcommands to reduce the footprint when reading large CSV files.
*   **Resuming Progress:** If an indexing run is interrupted, use the `--resume` flag to pick up where it left off. Use `--force` only if you need to overwrite a previous failed or incomplete run.
*   **Specific Event Types:** If you are only interested in one type of splicing, use `--splice-types se` or `--splice-types mxe` during the index step to save time.
*   **Multimapping Reads:** By default, Outrigger includes multimapping reads. If your alignment strategy produced many non-unique mappings that might bias splicing ratios, use the `--ignore-multimapping` flag.

## Reference documentation
- [index: Build a de novo splicing annotation index](./references/yeolab_github_io_outrigger_subcommands_outrigger_index.html.md)
- [validate: Check that the found exons are real](./references/yeolab_github_io_outrigger_subcommands_outrigger_validate.html.md)
- [psi: Calculate percent spliced-in (Psi/Ψ) scores](./references/yeolab_github_io_outrigger_subcommands_outrigger_psi.html.md)
- [Usage Overview](./references/yeolab_github_io_outrigger_usage.html.md)