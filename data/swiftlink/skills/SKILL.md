---
name: swiftlink
description: SwiftLink is a specialized genetic analysis tool designed to overcome the computational limitations of traditional linkage analysis software when dealing with large, complex pedigrees.
homepage: https://github.com/ajm/swiftlink
---

# swiftlink

## Overview

SwiftLink is a specialized genetic analysis tool designed to overcome the computational limitations of traditional linkage analysis software when dealing with large, complex pedigrees. By utilizing Markov Chain Monte Carlo (MCMC) algorithms rather than the Lander-Green approach, it can process high-density SNP data across extensive family trees. It is primarily used for parametric linkage to identify disease loci in consanguineous populations, supporting both autosomal and X-linked inheritance models.

## Core Workflows

### 1. Expected LOD (ELOD) Calculation
Before running a full analysis, use ELOD to perform power analysis or quality control. If the final LOD score differs significantly from the ELOD, it may indicate model misspecification or data errors.

*   **Autosomal Recessive (Default):**
    `swift -p study.ped --elod`
*   **X-linked Recessive:**
    `swift -p study.ped --elod -X`
*   **Dominant Trait (Custom Penetrance):**
    `swift -p study.ped --elod --penetrance=0.0,1.0,1.0`

### 2. Standard Linkage Analysis
SwiftLink requires three files in **LINKAGE format**: pedigree (`.ped`), map (`.map`), and locus data (`.dat`).

*   **Basic Run:**
    `swift -p study.ped -m study.map -d study.dat -o results.txt`
*   **Affected-Only Analysis:**
    Forces all negative affection statuses to unknown.
    `swift -p study.ped -m study.map -d study.dat -a`

### 3. Performance Optimization
SwiftLink is designed for high-performance computing environments.

*   **Multi-core CPU:** Use the `-c` flag to specify the number of threads.
    `swift -p study.ped -m study.map -d study.dat -c 8`
*   **GPU Acceleration:** If compiled with CUDA, use `-g` to offload LOD calculations (Note: GPU support is limited to autosomal analysis).
    `swift -p study.ped -m study.map -d study.dat -g`

### 4. MCMC Convergence and Reliability
For complex pedigrees, default MCMC parameters may be insufficient.

*   **Multiple Replicates:** Run multiple chains and average the results (10 replicates is a standard starting point).
    `swift -p study.ped -m study.map -d study.dat -R 10`
*   **Extended Sampling:** Increase burn-in and total iterations for better convergence.
    `swift -p study.ped -m study.map -d study.dat -b 1000000 -i 1000000 -x 100`
    *   `-b`: Burn-in iterations.
    *   `-i`: Simulation iterations.
    *   `-x`: Scoring period (samples every Nth descent graph).

## Expert Tips

*   **Input Preparation:** If using **Mega2** to generate input files, you must select **"Allegro Format"** to ensure compatibility with SwiftLink's expectations for pedigree and locus data files.
*   **Convergence Diagnostics:** Use the `--trace` and `--traceprefix` flags to generate log files. These logs can be imported into the **CODA R package** to visualize chain convergence and calculate Gelman-Rubin diagnostics.
*   **X-linked Analysis:** While SwiftLink usually detects X-linkage from the `.dat` file header, use the `-X` flag to explicitly force X-linked analysis if the input format is ambiguous.

## Reference documentation

- [SwiftLink GitHub Repository](./references/github_com_ajm_swiftlink.md)
- [Bioconda SwiftLink Overview](./references/anaconda_org_channels_bioconda_packages_swiftlink_overview.md)