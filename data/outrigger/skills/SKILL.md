---
name: outrigger
description: Outrigger identifies and quantifies alternative splicing events like skipped exons and mutually exclusive exons from RNA-seq data using a graph-based approach. Use when user asks to build a splicing index from junctions or BAM files, validate de novo splice sites against a reference genome, or calculate Percent Spliced-In scores.
homepage: https://yeolab.github.io/outrigger
---


# outrigger

## Overview
Outrigger is a specialized bioinformatics tool designed to identify and quantify alternative splicing events—specifically Skipped Exons (SE) and Mutually Exclusive Exons (MXE)—directly from RNA-seq data. Unlike tools that rely solely on existing annotations, Outrigger uses a graph database approach to discover novel exons and junctions present in your specific dataset. The workflow follows a three-step process: indexing junctions to find events, validating those events against biological splice-site rules, and calculating the final Psi scores.

## Core Workflow and CLI Patterns

### 1. Building the Splicing Index (`index`)
This step is computationally intensive and builds the graph of potential splicing events.

*   **Using STAR Junctions (Recommended):** Faster than BAM files as counts are pre-aggregated.
    ```bash
    outrigger index --sj-out-tab *SJ.out.tab --gtf <annotation.gtf>
    ```
*   **Using BAM Files:** Slower; requires sorted and indexed BAMs.
    ```bash
    outrigger index --bam *sorted.bam --gtf <annotation.gtf>
    ```
*   **Optimization Tips:**
    *   **Parallelization:** Always use multiple cores. Use `--n-jobs -1` to use all available processors.
    *   **Memory Management:** Use the `--low-memory` flag for large datasets to reduce the RAM footprint during CSV operations.
    *   **Filtering:** Use `--min-reads` (default 10) to ignore low-confidence junctions and speed up graph construction.

### 2. Validating Splice Sites (`validate`)
Filters the de novo events to ensure they follow canonical biological rules (e.g., GT/AG or AT/AC).

```bash
outrigger validate --genome <genome_id> --fasta <reference.fasta>
```
*   **Note:** This step requires a genome fasta file and is highly recommended to remove noise from the de novo index.

### 3. Quantifying Splicing (`psi`)
Calculates the Percent Spliced-In (Ψ) scores for the validated (or indexed) events.

```bash
outrigger psi
```
*   **Execution:** Run this in the same directory where `index` was performed. It automatically looks for the `outrigger_output` folder.
*   **Output:** The primary result is `outrigger_output/psi/outrigger_psi.csv`, containing a matrix of events (rows) by samples (columns).

## Expert Tips and Best Practices
*   **Directory Consistency:** Always run `index`, `validate`, and `psi` from the same working directory. Outrigger relies on a specific folder structure (`outrigger_output/`) created during the indexing phase.
*   **Runtime Expectations:** 
    *   `index`: 24–48 hours (highly dependent on junction count).
    *   `validate`: 2–4 hours.
    *   `psi`: 4–8 hours.
*   **Resuming Interrupted Jobs:** If an indexing job fails, use the `--resume` flag to continue from the last checkpoint, or `--force` to overwrite and start over.
*   **Multimapping Reads:** By default, Outrigger includes multimapping reads. Use `--ignore-multimapping` if you require higher stringency, particularly when working with repetitive genomic regions.
*   **Custom Splice Sites:** For non-mammalian systems, you can adjust the valid splice sites during the `validate` step if the defaults (GT/AG, AT/AC) are not applicable.



## Subcommands

| Command | Description |
|---------|-------------|
| outrigger | outrigger: error: invalid choice: 'correct' (choose from 'index', 'validate', 'psi') |
| outrigger | outrigger: error: invalid choice: 'database' (choose from 'index', 'validate', 'psi') |
| outrigger | outrigger: error: invalid choice: 'splicing' (choose from 'index', 'validate', 'psi') |
| outrigger psi | Calculate PSI scores |
| outrigger validate | Validate splice site sequences against a genome. |
| outrigger_index | Build an index of alternative splicing events from splice junction data. |

## Reference documentation
- [Usage Guide](./references/yeolab_github_io_outrigger_usage.html.md)
- [Index Subcommand](./references/yeolab_github_io_outrigger_subcommands_outrigger_index.html.md)
- [Validate Subcommand](./references/yeolab_github_io_outrigger_subcommands_outrigger_validate.html.md)
- [Psi Subcommand](./references/yeolab_github_io_outrigger_subcommands_outrigger_psi.html.md)