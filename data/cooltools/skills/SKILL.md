---
name: cooltools
description: cooltools is the primary suite for processing and analyzing Hi-C data within the Open2C ecosystem.
homepage: https://github.com/mirnylab/cooltools
---

# cooltools

## Overview

cooltools is the primary suite for processing and analyzing Hi-C data within the Open2C ecosystem. It is specifically optimized to work with the sparse `.cool` format, enabling efficient analysis of high-resolution datasets that would otherwise be memory-prohibitive. This skill provides guidance on using the cooltools Command Line Interface (CLI) to extract biological insights from chromosome conformation capture data, ranging from basic distance-scaling properties to complex structural features like compartments and boundaries.

## Installation and Setup

Install cooltools via bioconda for the most stable environment:

```bash
conda install -c bioconda cooltools
```

Ensure your input files are in `.cool` or `.mcool` format. Use the `cooler` suite to generate these from raw contact lists if necessary.

## Common CLI Workflows

### 1. Contacts vs. Distance (Expected)
To calculate how contact frequency decays with genomic distance (scaling), use the `expected` commands. This is a prerequisite for many other analyses like normalization and loop calling.

*   **Cis-expected (within chromosomes):**
    ```bash
    cooltools expected-cis --view regions.bed -o output.expected.tsv input.cool
    ```
*   **Trans-expected (between chromosomes):**
    ```bash
    cooltools expected-trans --view regions.bed -o output.trans.tsv input.cool
    ```

### 2. Compartment Analysis (Eigenvectors)
To identify A/B compartments (active vs. inactive chromatin), use the `eigs` commands.

*   **Calculate Eigenvectors:**
    ```bash
    cooltools eigs-cis --view regions.bed --phasing-track phasing_track.bigWig -o output_prefix input.cool
    ```
    *Tip: Providing a phasing track (like GC content or H3K4me1) ensures the sign of the eigenvector correctly corresponds to A/B compartments.*

### 3. Insulation and TAD Boundaries
To identify Topologically Associating Domain (TAD) boundaries using the insulation score method:

```bash
cooltools insulation --window-sizes 10000,20000,50000 input.cool > output.insulation.tsv
```
*   **Boundary Calling:** The output TSV contains insulation minima which represent potential boundaries. Filter these based on the "boundary strength" column.

### 4. Pileups (Aggregate Analysis)
To create average maps around specific genomic features (e.g., CTCF sites or called loops):

```bash
cooltools pileup --features features.bed --view regions.bed -o output.pileup.npy input.cool
```

## Expert Tips and Best Practices

*   **Resolution Selection:** Always match the resolution (bin size) of your `.cool` file to the feature you are studying. Use 100kb+ for compartments, 10kb-25kb for TAD boundaries, and 1kb-5kb for loops/pileups.
*   **Normalization:** Most cooltools commands expect "balanced" data. Ensure your cooler file has been balanced (using `cooler balance`) and use the `--clr-weight-name weight` flag if your weight column is named differently.
*   **View Files:** Use a `--view` BED file to define the specific genomic regions (e.g., chromosomes or specific arms) to be analyzed. This prevents artifacts from centromeres or unplaced scaffolds.
*   **Memory Management:** For very high-resolution data, use the `--nproc` flag to parallelize tasks, but monitor memory usage as Hi-C matrices can be extremely large when expanded.

## Reference documentation
- [GitHub Repository](./references/github_com_open2c_cooltools.md)
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cooltools_overview.md)