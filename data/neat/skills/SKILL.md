---
name: neat
description: NEAT (NExt-generation Analysis Toolkit) is a specialized suite for creating high-fidelity synthetic sequencing data with an established ground truth.
homepage: https://github.com/ncsa/NEAT/
---

# neat

---

## Overview
NEAT (NExt-generation Analysis Toolkit) is a specialized suite for creating high-fidelity synthetic sequencing data with an established ground truth. Unlike basic simulators, NEAT can "learn" the characteristics of real sequencing runs—such as error profiles, fragment length distributions, and mutational models—to produce data that closely mimics actual laboratory results. It is primarily used to stress-test alignment and variant calling workflows by providing "golden" reference files (BAM/VCF) that represent the exact truth of the simulated reads.

## Core Functionality and CLI Patterns

### Primary Simulation
The main entry point for generating reads is the `read-simulator`. In recent versions (4.3.5+), performance is significantly improved through parallel processing.

*   **Check Installation**: Verify the environment and available sub-commands.
    ```bash
    neat --help
    ```
*   **Parallel Execution**: Use the threads parameter to speed up simulation for large genomes.
    ```bash
    neat read-simulator --threads <number_of_threads>
    ```
*   **Log Management**: If the output is too verbose, restrict logging to errors only.
    ```bash
    neat read-simulator --log-level ERROR
    ```

### Modeling Utilities
NEAT provides specific utilities to extract parameters from existing datasets to make simulations more realistic.

*   **Fragment Length Modeling**: Learn the distribution of fragment lengths from an existing BAM file.
    ```bash
    neat model-fraglen
    ```
*   **Mutation Modeling**: Generate a model of mutational frequencies.
    ```bash
    neat gen-mut-model
    ```
*   **Sequencing Error Modeling**: Create a custom error model based on a specific sequencing run or machine type.
    ```bash
    neat model-seq-err
    ```

### Validation and Comparison
After running a variant caller on NEAT-generated data, use the comparison tool to evaluate performance.

*   **VCF Comparison**: Compare your pipeline's VCF output against the "golden" VCF produced by NEAT to calculate sensitivity and precision.
    ```bash
    neat vcf_compare
    ```

## Expert Tips and Best Practices

*   **Environment Setup**: NEAT is designed for Linux (tested on Ubuntu). If working on Windows or macOS, use WSL or a containerized environment. For macOS users, ensure `libgcc` is handled correctly in the environment setup.
*   **VCF Requirements**: To generate VCF files containing the variants NEAT added, ensure `bcftools` is installed and available in your PATH.
*   **Ploidy Considerations**: When simulating non-human or specific experimental organisms, ensure the ploidy settings match the biological reality of your target to avoid artifacts in variant frequency.
*   **Long-Read Simulation**: While originally designed for short reads, NEAT can handle long-read simulation by adjusting the error models and read length parameters to match technologies like PacBio or Oxford Nanopore.
*   **Ground Truth**: Always retain the "golden" BAM and VCF files produced during simulation; these are your primary assets for calculating the accuracy of any downstream bioinformatics tools.

## Reference documentation
- [NEAT GitHub Repository](./references/github_com_ncsa_NEAT.md)
- [Bioconda NEAT Overview](./references/anaconda_org_channels_bioconda_packages_neat_overview.md)