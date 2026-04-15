---
name: drprg
description: drprg predicts antimicrobial drug resistance by using reference graphs to capture a wide range of genetic variation from sequencing reads. Use when user asks to download or build genomic indices, predict drug resistance from Illumina or Nanopore reads, and perform high-sensitivity resistance profiling.
homepage: https://github.com/mbhall88/drprg
metadata:
  docker_image: "quay.io/biocontainers/drprg:0.1.1--h5076881_1"
---

# drprg

## Overview

`drprg` (Drug Resistance Prediction with Reference Graphs) is a specialized bioinformatics tool that moves beyond the "single-reference" paradigm by using reference graphs to describe genetic variation. By utilizing the Pandora method, it captures a broader range of resistance-associated haplotypes, including SNPs, indels, and large gene deletions (such as *katG* or *pncA*). Use this skill to guide users through the workflow of preparing genomic indices and performing high-sensitivity resistance profiling that outperforms traditional pileup-based tools in both speed and memory efficiency.

## Command Line Usage

### 1. Index Management
Before prediction, you must have a species-specific index. The tool provides prebuilt indices for common pathogens.

*   **Download a prebuilt index (e.g., M. tuberculosis):**
    ```bash
    drprg index --download mtb
    ```
*   **List available indices or interact with local ones:**
    ```bash
    drprg index --help
    ```

### 2. Predicting Drug Resistance
The `predict` command is the primary interface for analyzing sequencing reads.

*   **Basic Illumina Prediction:**
    ```bash
    drprg predict -x mtb -i reads.fq.gz --illumina -o output_directory/
    ```
*   **Using Multiple Threads:**
    To speed up the graph mapping process, specify the thread count (default is 1).
    ```bash
    drprg predict -t 8 -x mtb -i reads.fq.gz --illumina -o output_directory/
    ```

### 3. Building Custom Indices
If a prebuilt index is not available for your specific strain or species, you can build one from a collection of samples and a resistance catalogue.

*   **Build Command:**
    ```bash
    drprg build [OPTIONS] --resource <catalogue> --outdir <dir>
    ```

## Expert Tips and Best Practices

*   **Platform Compatibility:** `drprg` is natively supported on Linux. For macOS or Windows users, recommend using the official Docker container to avoid compatibility issues with the underlying Rust-based graph processing engine.
*   **Input Handling:** While the tool is highly efficient, ensure that input FASTQ files are quality-trimmed for the best results, especially when dealing with Nanopore data where error rates are higher.
*   **Memory Efficiency:** `drprg` is designed to use significantly less memory than competitors like Mykrobe or TBProfiler. It is suitable for execution on standard laptops or cloud instances with limited RAM.
*   **Verbosity:** Use the `-v` or `--verbose` flag when troubleshooting index downloads or complex builds to see the underlying progress of the reference graph construction.



## Subcommands

| Command | Description |
|---------|-------------|
| drprg | Build a DRaWoR program |
| drprg | For more information, try '--help'. |
| drprg | A command-line tool for managing and processing data. This specific invocation seems to be for a subcommand that is not recognized. |
| drprg | Command-line tool for running various prediction tasks. |
| drprg | A command-line tool for managing and processing data. |
| drprg | For more information, try '--help'. |
| drprg build | Build an index to predict resistance from |
| drprg index | Download and interact with indices |
| drprg predict | Predict drug resistance |

## Reference documentation

- [drprg Main Documentation and Quickstart](./references/github_com_mbhall88_drprg_blob_main_README.md)
- [Methodology and Citation Information](./references/github_com_mbhall88_drprg_blob_main_CITATION.cff.md)