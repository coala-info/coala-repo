---
name: cycle_finder
description: The cycle_finder tool identifies and characterizes genomic repeats from short-read sequencing data using de Bruijn graphs. Use when user asks to detect tandem or interspersed repeats, estimate repeat copy numbers, or compare repeat content between two samples.
homepage: https://github.com/rkajitani/cycle_finder
metadata:
  docker_image: "biocontainers/cycle:v0.3.1-14-deb_cv1"
---

# cycle_finder

## Overview
The `cycle_finder` tool implements a graph-based approach to identify genomic repeats directly from short reads. It utilizes de Bruijn graphs to find cycles (representing tandem repeats) and paths (representing interspersed repeats). The workflow typically involves k-mer extraction, cycle/path detection, and clustering to provide a comprehensive repeat profile including consensus sequences and copy number estimations.

## Core Workflows

### Single Mode Analysis
Use this for a standard de novo repeat discovery on a single sample.
```bash
cycle_finder all -f reads.fastq -o output_prefix -t 8
```

### Compare Mode Analysis
Use this to identify differences in repeat content between two samples (e.g., identifying expanded repeats in a mutant vs. wild-type).
```bash
cycle_finder all -f1 sample1.fastq -f2 sample2.fastq -o comparison_results -t 8
```

## Step-by-Step Subcommands
If you need to run the pipeline modularly or resume from a specific stage:

1.  **Extract High-Frequency K-mers**:
    ```bash
    cycle_finder extract -f reads.fastq -o out
    ```
    *   Generates `out_for_detect.fa` and `out_for_estimate.fa`.
    *   Calculates k-mer peaks automatically unless provided.

2.  **Detect Tandem Repeats (Cycles)**:
    ```bash
    cycle_finder cycle -f out_for_detect.fa -r reads.fastq -p [KMER_PEAK] -o out
    ```

3.  **Cluster and Estimate Copy Number**:
    ```bash
    cycle_finder cluster -f1 out_for_estimate.fa -f2 out_T_repeat_num -f3 out_T_repeat_num_min -o out
    ```

## Expert Tips and Best Practices

### Performance Optimization
*   **Threading**: Always use the `-t` option to specify available CPU cores, as the k-mer counting (Jellyfish) and graph traversal stages are computationally intensive.
*   **Memory Management**: The tool relies on Jellyfish for k-mer counting. If you have pre-computed Jellyfish files (`.jf`, `.dm`, or `.hs`), provide them using `-jf`, `-dm`, or `-hs` to skip the most time-consuming step of the `extract` command.

### Parameter Tuning
*   **K-mer Peak (`-p`)**: While the tool attempts to detect the k-mer peak automatically, providing an explicit peak value based on your expected sequencing depth improves the accuracy of copy number estimation.
*   **Detection Thresholds**:
    *   `-l`: Minimum repeat length to detect.
    *   `-d`: Search depth in the de Bruijn graph. Increase this if you suspect very long or complex repeat structures.
*   **Mismatch Tolerance**: In the `cluster` stage, use `-m` to adjust the mismatch threshold for k-mer alignment if your data has a high sequencing error rate.

### Output Interpretation
*   **PREFIX_T.fa**: Contains the consensus sequences of detected tandem repeats.
*   **PREFIX_T.tsv**: Provides the copy number estimation for each detected repeat.
*   **PREFIX_I.fa/tsv**: Contains results for interspersed repeats (detected via path-finding after cycles are removed).

## Reference documentation
- [github_com_rkajitani_cycle_finder.md](./references/github_com_rkajitani_cycle_finder.md)
- [anaconda_org_channels_bioconda_packages_cycle_finder_overview.md](./references/anaconda_org_channels_bioconda_packages_cycle_finder_overview.md)