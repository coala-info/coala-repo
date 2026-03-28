---
name: priorcons
description: PriorCons fills gaps in viral consensus sequences by integrating candidate sequences into trusted sequences using evolutionary priors to validate variation. Use when user asks to build a priors database from viral sequences, integrate consensus sequences to fill N-gaps, or perform quality control on integrated viral genomes.
homepage: https://github.com/GERMAN00VP/priorcons
---

# priorcons

## Overview

PriorCons is a bioinformatics tool designed to fill gaps in viral consensus sequences. It works by comparing a "trusted" but potentially incomplete sequence (full of Ns) against a "candidate" sequence that is more complete but less certain. To ensure the integrated result is accurate, PriorCons uses a database of evolutionary priors—statistical models of expected variation derived from known genomes of the same virus. If a candidate sequence's variation falls within a 95th percentile likelihood threshold based on these priors, it is accepted into the final consensus.

## CLI Usage and Best Practices

### 1. Building the Priors Database
Before integration, you must create a statistical model of the virus's expected variation.

*   **Input Requirement**: A FASTA file containing a large collection of relevant viral sequences (e.g., from GISAID or NCBI).
*   **Critical Step**: Sequences must be aligned to the reference genome. Use MAFFT in reference-anchored mode to maintain coordinate consistency.

```bash
# Build the priors file (JSON or Parquet)
priorcons build-priors --input database_aligned.fasta --output virus_priors.json
```

### 2. Preparing Sequences for Integration
You must align three specific sequences before running the integration command:
1.  **Trusted**: High-confidence sequence (stringent filtering, contains Ns).
2.  **Candidate**: Less conservative sequence (relaxed filtering, more informative).
3.  **Reference**: The reference genome used during assembly.

**Recommended Alignment Strategy**:
Use MAFFT with high-sensitivity settings for these three sequences:
```bash
mafft --localpair --maxiterate 1000 input.fasta > aligned_input.fasta
```

### 3. Integrating the Consensus
Run the integration to produce the final sequence.

```bash
priorcons integrate-consensus \
    --aligned-fasta aligned_input.fasta \
    --priors virus_priors.json \
    --output output_dir
```

### 4. Quality Control (QC)
After integration, analyze the results to identify recovery hotspots and performance metrics.

```bash
priorcons qc --input_dir output_dir --output_dir qc_results
```

## Expert Tips and Workflow Details

*   **Window-Based Evaluation**: PriorCons slides overlapping windows across the genome. It only evaluates windows where the trusted sequence has missing regions (Ns).
*   **Statistical Thresholds**: The tool calculates a normalized negative log-likelihood (nLL). Windows exceeding the 95th percentile of the empirical distribution are rejected as "atypical" to prevent the introduction of sequencing artifacts.
*   **Output Interpretation**:
    *   `{sample_name}-INTEGRATED.fasta`: Your final optimized sequence.
    *   `qc.json`: Summary statistics of the integration.
    *   `windows_trace.csv`: Detailed records of which windows were accepted or rejected and why.
*   **Coordinate Consistency**: Always ensure your priors database and your integration input use the exact same reference genome coordinates.



## Subcommands

| Command | Description |
|---------|-------------|
| Ellipsis | Integrates prior information into consensus sequence generation. |
| priorcons | Build empirical priors from alignment |

## Reference documentation
- [PriorCons README](./references/github_com_GERMAN00VP_PriorCons_blob_main_README.md)
- [PriorCons Changelog](./references/github_com_GERMAN00VP_PriorCons_blob_main_CHANGELOG.md)
- [PriorCons Project Configuration](./references/github_com_GERMAN00VP_PriorCons_blob_main_pyproject.toml.md)