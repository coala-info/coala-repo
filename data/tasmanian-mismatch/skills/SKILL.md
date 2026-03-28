---
name: tasmanian-mismatch
description: Tasmanian identifies and quantifies reference mismatches in genomic DNA sequencing data to distinguish true variants from systematic artifacts. Use when user asks to identify sequencing errors, troubleshoot library preparation issues, analyze positional artifacts, or correlate mismatches with specific genomic regions.
homepage: https://github.com/nebiolabs/tasmanian-mismatch
---


# tasmanian-mismatch

## Overview

Tasmanian is a specialized diagnostic tool for genomic DNA sequencing analysis that focuses on identifying and quantifying reference mismatches. Unlike general-purpose variant callers, Tasmanian provides a granular look at how specific genomic features—defined by the user via BED or BedGraph files—correlate with sequencing errors. It classifies every base in a read based on its intersection with these regions (contained, boundary, or non-overlapping) and performs positional analysis across Read 1 and Read 2 to pinpoint where artifacts occur. Use this skill to troubleshoot library preparation issues, reference genome biases, or to validate whether a set of suspected variants are actually systematic artifacts.

## Installation and Setup

Tasmanian can be installed via bioconda or pip:

```bash
# Via Bioconda
conda install -c bioconda tasmanian-mismatch

# Via Pip
pip install tasmanian-mismatch
```

## Core Workflow

The standard Tasmanian pipeline operates on a stream of SAM data. The typical execution pattern involves piping `samtools` output through the intersection engine and then into the main analysis tool.

### Standard Pipeline Command
```bash
samtools view -h input.bam | run_intersections -b regions.bed | run_tasmanian -o experiment_results
```

### Component Breakdown

1.  **`run_intersections`**: This component classifies each base of every read.
    *   **Input**: Requires a BED or BedGraph file containing regions of interest (e.g., known repeats, problematic regions).
    *   **Function**: It marks bases as overlapping (contained or boundary) or non-overlapping with the provided regions.
2.  **`run_tasmanian`**: This component performs the statistical and positional analysis.
    *   **Function**: It splits analysis by Read 1 and Read 2 and generates positional artifact metrics.
    *   **Output**: Produces data tables for custom plotting and a built-in HTML report for rapid data assessment.

## Expert Tips and Best Practices

*   **Identify Systematic Bias**: Use Tasmanian when you notice high mismatch rates in specific genomic contexts. By providing a BED file of those contexts to `run_intersections`, you can confirm if the artifacts are truly localized to those regions.
*   **Positional Analysis**: Pay close attention to the positional analysis output. Artifacts that increase toward the end of reads often indicate sequencing chemistry issues, while artifacts localized to specific read positions regardless of genomic context may indicate library prep bias.
*   **Handling Repeats**: If your reference genome has misplaced or highly similar repeat regions, use a repeats BED file to see if "mismatches" are actually just reads from one repeat instance mapping to another.
*   **Nextflow Integration**: For large-scale processing, Tasmanian includes a Nextflow implementation (`main.nf`) in the root directory of the repository which can be used to parallelize analysis across multiple BAM files.



## Subcommands

| Command | Description |
|---------|-------------|
| tasmanian-mismatch_run_intersections | Run mismatch intersections between BAM and BEDGraph files. |
| tasmanian-mismatch_run_tasmanian | Run Tasmanian mismatch caller |

## Reference documentation
- [Main README and Usage Overview](./references/github_com_nebiolabs_tasmanian-mismatch_blob_master_README.md)
- [Repository File Structure](./references/github_com_nebiolabs_tasmanian-mismatch.md)