---
name: grenedalf
description: grenedalf is a high-performance command-line toolkit for the statistical analysis of pool-sequencing data. Use when user asks to calculate genetic diversity metrics, estimate population differentiation, analyze allele frequencies, or convert genomic files into sync format.
homepage: https://github.com/lczech/grenedalf
metadata:
  docker_image: "quay.io/biocontainers/grenedalf:0.6.3--hbefcdb2_0"
---

# grenedalf

## Overview

grenedalf is a high-performance command-line toolkit designed for the statistical analysis of pool-sequencing (Pool-seq) data. It serves as a faster, more memory-efficient alternative to older tools like PoPoolation and PoPoolation2. The tool handles the unique statistical challenges of pooled data—where multiple individuals are sequenced together—by applying corrections for pool size and sequencing depth. It supports a wide range of genomic formats and provides specialized workflows for calculating population genetics metrics across sliding windows or specific genomic regions.

## Core Workflows

### 1. Calculating Genetic Diversity
Use the `diversity` command to compute corrected measures of nucleotide diversity and neutrality tests.
- **Metrics**: Theta Pi ($\pi$), Theta Watterson ($\theta_W$), and Tajima's D.
- **Key Options**: Requires pool sizes to be specified for accurate correction.
- **Example**:
  ```bash
  grenedalf diversity --pool-sizes 50 50 100 --sam-path sample1.sam sample2.sam sample3.sam --window-width 10000
  ```

### 2. Estimating Population Differentiation (FST)
Use the `fst` command to compare genetic differentiation between pools.
- **Methods**: Supports various estimators including those following PoPoolation2 and poolfstat.
- **Example**:
  ```bash
  grenedalf fst --sync-path input.sync --pool-sizes 100 --window-width 50000 --window-stride 10000
  ```

### 3. Allele Frequency Analysis
Use the `frequency` command to extract per-sample or total base counts and frequencies.
- **Use Case**: Generating tables for downstream custom R scripts or visualizing allele frequency spectrums (AFS).
- **Example**:
  ```bash
  grenedalf frequency --vcf-path variants.vcf.gz --out-dir frequency_results/
  ```

### 4. File Conversion and Simulation
- **Sync Generation**: Convert BAM/SAM/VCF files into the `sync` format (common in Pool-seq) using `grenedalf sync`.
- **Simulation**: Generate random frequency data for null model testing using `grenedalf simulate`.

## Expert Tips and Best Practices

### Handling Pool Sizes
Accurate statistics require knowing the number of diploid individuals in each pool.
- Use `--pool-sizes <int>` to set a global size for all samples.
- Use a file with `--pool-sizes-file <file>` for varying sizes across many samples.

### Filtering and Masking
Pool-seq data is sensitive to sequencing errors and mapping biases.
- **Region Filtering**: Use `--filter-region-mask-fasta` to restrict analysis to specific genomic areas.
- **Quality Control**: Always apply depth filters (min/max coverage) to avoid regions with copy number variation or low confidence.
- **Masking**: Provide a BED file to `--filter-mask-bed` to exclude repetitive regions or known problematic loci.

### Windowing Strategies
- **Sliding Windows**: Define `---window-width` and `--window-stride`. If stride is less than width, windows will overlap.
- **Averaging**: grenedalf uses a "window averaging policy." By default, it considers the number of "valid" positions (those passing filters) rather than just the raw window size to avoid underestimating diversity in sparse regions.

### Performance Optimization
- **Input Formats**: While grenedalf reads BAM/SAM directly, converting to a `sync` file first can significantly speed up iterative analyses.
- **Multithreading**: Use the `-j` or `--threads` flag to parallelize computations across genomic contigs.



## Subcommands

| Command | Description |
|---------|-------------|
| grenedalf cathedral-plot | Create a cathedral plot, using the pre-computated cathedral data. |
| grenedalf citation | Print references to be cited when using grenedalf. |
| grenedalf diversity | Compute pool-sequencing corrected diversity measures Theta Pi, Theta Watterson, and Tajima's D. |
| grenedalf frequency | Create a table with per-sample and/or total base counts and/or frequencies at positions in the genome. |
| grenedalf fst | Compute pool-sequencing corrected measures of FST. |
| grenedalf fst-cathedral | Compute the data for an FST cathedral plot. |
| grenedalf simulate | Create a file with simulated random frequency data. |
| grenedalf sync | Create a sync file that lists per-sample base counts at each position in the genome. |

## Reference documentation

- [Home: Wiki Overview](./references/github_com_lczech_grenedalf_wiki.md)
- [Subcommand: diversity](./references/github_com_lczech_grenedalf_wiki_Subcommand_-diversity.md)
- [Subcommand: fst](./references/github_com_lczech_grenedalf_wiki_Subcommand_-fst.md)
- [Filtering Best Practices](./references/github_com_lczech_grenedalf_wiki_Filtering.md)
- [Windowing and Averaging](./references/github_com_lczech_grenedalf_wiki_Windowing.md)