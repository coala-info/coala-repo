---
name: survivor
description: SURVIVOR manages structural variation data by merging results from multiple callers, simulating datasets, and evaluating variant calling performance. Use when user asks to merge VCF files into a consensus set, simulate structural variations, evaluate SV callers against a truth set, or convert between VCF and BED formats.
homepage: https://github.com/fritzsedlazeck/SURVIVOR
metadata:
  docker_image: "quay.io/biocontainers/survivor:1.0.7--h077b44d_7"
---

# survivor

## Overview
The `survivor` skill provides a streamlined workflow for managing structural variation data. It is primarily used to increase the reliability of SV calls by merging results from multiple tools (like Manta, Delly, or Lumpy) into a consensus set. It also supports the generation of simulated SV datasets to evaluate the sensitivity and false discovery rates of variant calling pipelines.

## Installation and Setup
Install via bioconda:
```bash
conda install bioconda::survivor
```

## Core Workflows

### Merging VCF Files (Consensus Calling)
To create a consensus call set from multiple SV callers or samples:

1.  **Create a file list**: Generate a text file containing the paths to all VCF files to be merged.
    ```bash
    ls *.vcf > sample_files.txt
    ```
2.  **Execute merge**:
    ```bash
    SURVIVOR merge sample_files.txt 1000 2 1 1 0 30 merged_out.vcf
    ```
    **Parameter Breakdown**:
    *   `1000`: Max distance (bp) allowed between breakpoints.
    *   `2`: Minimum number of callers supporting the variant.
    *   `1`: Take type into account (1=yes, 0=no).
    *   `1`: Take strand into account (1=yes, 0=no).
    *   `0`: Estimate distance based on the size of SV (1=yes, 0=no).
    *   `30`: Minimum size of SVs to be included.

### Simulating Structural Variations
1.  **Generate parameter file**:
    ```bash
    SURVIVOR simSV parameter_file
    ```
2.  **Edit the file**: Modify the generated `parameter_file` to specify the number and types of SVs (Inversions, Deletions, etc.).
3.  **Run simulation**:
    ```bash
    SURVIVOR simSV reference.fa parameter_file 0.1 0 simulated_output
    ```
    *   `0.1`: Error rate.
    *   `0`: Simulate reads based on generated sequence (1 = map real reads to simulated genome).

### Evaluating SV Callers
Compare a caller's output against a known truth set (e.g., from a simulation):
```bash
SURVIVOR eval caller_output.vcf truth_set.bed 10 evaluation_results
```
*   `10`: Maximum "wobble" (bp) allowed for a breakpoint to be considered a match.

## Format Conversion and Utilities
*   **VCF to BED**: `SURVIVOR vcftobed input.vcf min_size max_size output.bed`
*   **BED to VCF**: `SURVIVOR bedtovcf input.bed type output.vcf`
*   **Summary Stats**: `SURVIVOR stats input.vcf`
*   **Filter VCF**: `SURVIVOR filter input.vcf min_size max_size min_support output.vcf`

## Expert Tips
*   **Sorting**: Always ensure VCF files are sorted before merging to avoid unexpected behavior.
*   **Support Vector**: After merging, the `SUPP_VEC` tag in the INFO field of the output VCF indicates which input files supported the call (e.g., `110` means supported by the first and second file, but not the third).
*   **Low MQ Filtering**: Use `bincov` to identify regions with high densities of low mapping quality reads, which often cause false positive SV calls.
    ```bash
    # Cluster coverage of low MQ reads into a BED file
    SURVIVOR bincov lowMQ.cov 10 2 > lowMQ_regions.bed
    ```

## Reference documentation
- [SURVIVOR GitHub README](./references/github_com_fritzsedlazeck_SURVIVOR.md)
- [SURVIVOR Wiki - Home](./references/github_com_fritzsedlazeck_SURVIVOR_wiki.md)