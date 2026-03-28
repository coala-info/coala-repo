---
name: transcov
description: transcov analyzes read depth distribution relative to transcription start sites by processing genomic annotations and alignment files into coverage matrices. Use when user asks to preprocess annotations, generate coverage matrices from BAM files, or collapse multiple matrices for comparative analysis.
homepage: https://github.com/hogfeldt/transcov
---

# transcov

## Overview

`transcov` is a specialized bioinformatics utility for analyzing read depth distribution relative to transcription start sites. It streamlines the process of converting genomic annotations into target regions, calculating coverage from alignment files (BAM), and collapsing data from multiple experiments into a single matrix for downstream visualization or statistical analysis. Use this skill to automate the extraction of TSS-centric coverage data for genomic research.

## Command Line Usage

The `transcov` tool follows a three-step functional workflow: preprocessing, matrix generation, and data collapsing.

### 1. Preprocessing Annotations
Generate the necessary BED and TSS metadata files from a genomic annotation file (e.g., GFF3). This defines the rows of the coverage matrices.

```bash
transcov preprocess <annotation_file> --bed-file <output.bed> --tss-file <output_tss.tsv> --region-size <bp_size>
```
*   **Best Practice**: Use a `--region-size` that captures sufficient upstream and downstream context (e.g., `10000` for a 10kb window).

### 2. Generating Coverage Matrices
Calculate the read depth around the TSS defined in the preprocessing step using a BAM alignment file.

```bash
transcov generate <bam_file> <bed_file> --output-file <output_matrix.npy>
```
*   **Note**: The output is saved as a NumPy binary file (`.npy`), which is optimized for high-performance numerical data handling in Python.
*   **Resource Tip**: This step is computationally intensive. Ensure at least 6GB of memory is available for standard human/mouse datasets.

### 3. Collapsing Matrices
Aggregate multiple coverage matrices into a single file. This is useful for comparing coverage across different biological replicates or samples.

```bash
transcov collapse <matrix1.npy> <matrix2.npy> ... --output-file <collapsed_matrix.npy>
```
*   **Expert Tip**: Collapsing many large matrices can be memory-heavy. For large-scale projects, ensure the environment has significant RAM (e.g., 24GB+) to prevent OOM (Out of Memory) errors.

## Technical Specifications

*   **Input Formats**: GFF3 (Annotations), BAM (Alignments).
*   **Output Formats**: BED, TSV (Metadata), NPY (Matrices).
*   **Dependencies**: Requires `pysam`, `numpy`, `pandas`, and `scipy`.



## Subcommands

| Command | Description |
|---------|-------------|
| transcov collapse | (No description) |
| transcov cut-tails | Cut tails of coverage profiles. |
| transcov generate-coverage | Generate coverage tracks from BAM files based on BED regions. |
| transcov generate-end-length | Generate end-length distributions from BAM and BED files. |
| transcov generate-length | Generate transcript lengths from BAM and BED files. |
| transcov generate-read-ends | Generate read ends from BAM and BED files. |
| transcov pick-subset | Picks a subset of samples from a transcov index. |
| transcov plot-coverage-dist | Plot coverage distribution from a coverage matrix. |
| transcov plot-tensor-dist | Plot distance distribution for tensors. |
| transcov_preprocess | Preprocess annotation file for TransCov |

## Reference documentation
- [Workflow Implementation Details](./references/github_com_Hogfeldt_transcov_blob_master_workflow.py.md)
- [Project Setup and Dependencies](./references/github_com_Hogfeldt_transcov_blob_master_setup.py.md)
- [General Tool Overview](./references/github_com_Hogfeldt_transcov_blob_master_README.md)