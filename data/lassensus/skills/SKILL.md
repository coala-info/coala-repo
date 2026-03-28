---
name: lassensus
description: Lassensus is a bioinformatics pipeline that generates consensus sequences for Lassa virus by automatically selecting the best-matching reference from GenBank. Use when user asks to generate Lassa virus consensus sequences, identify the best reference genome for highly divergent samples, or perform long-read polishing of L and S segments.
homepage: https://github.com/DaanJansen94/lassensus
---

# lassensus

## Overview

Lassensus is a specialized bioinformatics pipeline designed to address the extreme genetic variability of Lassa virus (LASV). Standard consensus generation often fails with LASV due to poor reference matching; this tool solves that by automatically downloading and testing sample reads against all near-complete Lassa genomes in GenBank. It identifies the best-matching reference to guide the assembly, then utilizes `ivar` for consensus calling and `medaka` for long-read polishing of both the L and S segments.

## Usage Guidelines

### Basic Execution
The tool requires an input directory containing FASTQ files and an output directory for results.

```bash
lassensus --input_dir /path/to/fastqs --output_dir /path/to/results
```

### Optimizing Reference Selection
Because LASV is highly divergent, the reference selection step is critical. Use these flags to tune how the tool picks a starting point:

*   **Increase Sensitivity**: If a sample has a low viral load, increase `--ref_reads` (default 10,000) to ensure enough Lassa-specific reads are captured during the initial mapping phase.
*   **Filter Reference Database**: If the sample source is known, narrow the search to improve accuracy:
    *   `--host 1`: Human-derived references only.
    *   `--host 2`: Rodent-derived references only.
    *   `--genome 1`: Only use complete genomes as references.
*   **Identity Threshold**: Adjust `--min_identity` (default 90.0) to control the stringency of the initial reference match.

### Consensus Calling Parameters
Adjust these based on your sequencing depth and required confidence:

*   **Stringent Calling**: For high-confidence clinical or research sequences:
    ```bash
    lassensus -i <in> -o <out> --min_depth 100 --min_quality 40 --majority_threshold 0.9
    ```
*   **Lenient Calling**: For low-coverage samples where some ambiguity is acceptable:
    ```bash
    lassensus -i <in> -o <out> --min_depth 20 --min_quality 20 --majority_threshold 0.5
    ```

### Expert Tips
*   **Rarefaction Logic**: Note that `--ref_reads` is used only for the quick reference selection step, while `--max_reads` (default 1,000,000) is the limit for the actual consensus generation.
*   **Environment**: Always ensure the `lassensus` conda environment is active, as the tool relies on a specific stack including `minimap2`, `samtools`, `ivar`, and `medaka`.
*   **Output Structure**: The tool produces individual polished FASTAs for L and S segments per sample, but also aggregates them in the `AllConsensus` directory, which is ideal for downstream phylogenetic analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| lassensus consensus | Consensus calling pipeline |
| lassensus reference-selection | Selects the best reference genome from a directory of input FASTQ files based on various criteria. |

## Reference documentation
- [Lassensus README](./references/github_com_DaanJansen94_lassensus_blob_main_README.md)
- [Lassensus Setup and Dependencies](./references/github_com_DaanJansen94_lassensus_blob_main_setup.py.md)