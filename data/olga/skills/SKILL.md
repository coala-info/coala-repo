---
name: olga
description: OLGA computes the generation probability of immune receptor sequences and generates synthetic repertoires using V(D)J recombination models. Use when user asks to calculate the probability of specific CDR3 sequences, assess sequence publicness, or generate synthetic baseline repertoires for human or mouse T-cell and B-cell chains.
homepage: https://github.com/zsethna/OLGA
---


# olga

## Overview

OLGA (Optimized Likelihood estimate of immunoGlobulin Amino-acid sequences) is a high-performance tool designed for the statistical analysis of immune repertoires. It implements a dynamic programming algorithm to compute the probability that a specific CDR3 sequence—either amino acid or in-frame nucleotide—is generated during the V(D)J recombination process. This skill allows for the rapid assessment of sequence "publicness" and the generation of synthetic repertoires for baseline comparisons in immunology research.

## Core CLI Usage

OLGA provides two primary command-line entry points: `olga-compute_pgen` and `olga-generate_sequences`.

### Computing Generation Probabilities (Pgen)

Use `olga-compute_pgen` to determine the likelihood of specific sequences.

*   **Single Amino Acid Sequence:**
    `olga-compute_pgen --humanTRB CASSLGRDGGHEQYF`
*   **Batch Processing from File:**
    `olga-compute_pgen --humanTRB -i input_sequences.tsv -o output_pgens.tsv`
*   **Limit Processing:**
    Use `-m [number]` to process only the first N sequences of a file for quick testing.
    `olga-compute_pgen --humanTRB -i large_file.tsv -m 100`

### Generating Synthetic Sequences

Use `olga-generate_sequences` to create baseline repertoires.

*   **Generate to Stdout:**
    `olga-generate_sequences --humanTRB -n 10`
*   **Save to File:**
    `olga-generate_sequences --humanTRB -n 1000 -o synthetic_repertoire.tsv`

## Model Selection

You must specify a genomic model for every command. OLGA includes several built-in models:

| Chain Type | Human Flags | Mouse Flags |
| :--- | :--- | :--- |
| T-cell Alpha (VJ) | `--humanTRA` | `--mouseTRA` |
| T-cell Beta (VDJ) | `--humanTRB` | `--mouseTRB` |
| B-cell Heavy (VDJ) | `--humanIGH` | `--mouseIGH` |
| B-cell Kappa (VJ) | `--humanIGK` | `--mouseIGK` |
| B-cell Lambda (VJ) | `--humanIGL` | `--mouseIGL` |

### Custom Models
To use a custom model (e.g., inferred via IGoR), point to the directory containing the required parameter and anchor files:
*   **VJ Models:** `olga-compute_pgen --set_custom_model_VJ path/to/model/`
*   **VDJ Models:** `olga-compute_pgen --set_custom_model_VDJ path/to/model/`

## Expert Tips and Best Practices

*   **CDR3 Trimming:** Sequences must be trimmed strictly to the CDR3 region. By default, OLGA expects the inclusion of the conserved anchor residues (the 'C' at the end of the V-region and the 'F' or 'W' at the start of the J-region).
*   **Performance Boost:** For large-scale datasets, ensure `numba` is installed. OLGA's performance module uses JIT compilation to speed up Pgen calculations by up to 100x. This is enabled by default but can be bypassed with `--skip_fast_pgen` if troubleshooting.
*   **Ambiguous Symbols:** OLGA can handle expanded amino acid alphabets. If your data contains ambiguous symbols (like 'X' or 'B'), ensure you provide an alphabet definition file if the default behavior is insufficient.
*   **Memory Management:** When processing millions of sequences, use the file input/output flags (`-i` and `-o`) rather than piping large amounts of text through stdout to maintain stability and track progress.



## Subcommands

| Command | Description |
|---------|-------------|
| olga-compute_pgen | Compute Pgens for TCR and Ig sequences. |
| olga-generate_sequences | Generates CDR3 sequences using VDJ generative models. |

## Reference documentation
- [OLGA Main README](./references/github_com_statbiophys_OLGA_blob_master_README.md)
- [Project Configuration and Dependencies](./references/github_com_statbiophys_OLGA_blob_master_pyproject.toml.md)