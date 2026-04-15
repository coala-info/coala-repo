---
name: xpclr
description: xpclr infers natural selection by identifying genomic regions with selective sweeps in one population compared to another. Use when user asks to infer natural selection, identify selective sweeps, or compare populations for selection signatures.
homepage: https://github.com/hardingnj/xpclr
metadata:
  docker_image: "quay.io/biocontainers/xpclr:1.1.2--py_0"
---

# xpclr

## Overview

The `xpclr` tool implements the Cross-Population Composite Likelihood Ratio method to infer natural selection. By comparing the multi-locus allele frequency differentiation between two populations, it identifies regions where one population shows a signature of a selective sweep that is absent in the other. This specific implementation is designed to be more robust than the original tool and supports modern genomic data formats like VCF and HDF5.

## Installation

The tool is most easily installed via bioconda:
```bash
conda install -c bioconda xpclr
```

## Common CLI Patterns

### Basic Analysis from VCF
To run a basic comparison between two populations using a VCF file:
```bash
xpclr --out output_prefix \
      --format vcf \
      --input input_file.vcf.gz \
      --samplesA popA_samples.txt \
      --samplesB popB_samples.txt \
      --chr 1 \
      --rrate 1e-8 \
      --size 50000 \
      --step 5000
```

### Using HDF5 for Performance
For large datasets, converting VCF to HDF5 (via `scikit-allel`) and using the HDF5 format is significantly faster:
```bash
xpclr --out output_prefix \
      --format hdf5 \
      --input input_data.h5 \
      --samplesA popA_list.txt \
      --samplesB popB_list.txt \
      --chr 2 \
      --size 100000
```

### Defining Populations
Populations can be defined in two ways:
1.  **Comma-separated list**: `--samplesA sample1,sample2,sample3`
2.  **File path**: `--samplesA path/to/sample_list.txt` (one ID per line).

## Parameter Optimization

*   **Window Size (`--size`)**: Typically set in base pairs. Common values range from 50kb to 200kb depending on the expected decay of linkage disequilibrium (LD) in the species.
*   **SNP Density (`--maxsnps` / `--minsnps`)**: 
    *   Use `--maxsnps` (e.g., 200) to prevent a single high-density region from dominating the likelihood calculation.
    *   Use `--minsnps` (e.g., 10) to filter out windows with insufficient data that might produce noisy results.
*   **LD Cutoff (`--ld`)**: The default weighting helps account for redundant information from linked SNPs. Use `--ld 0.95` or similar to tune the weighting.
*   **Phased Data (`--phased`)**: If your VCF is phased, include this flag for more precise $r^2$ calculations during LD weighting.

## Interpreting Outputs

The output file contains several key columns:
*   **xpclr**: The raw log-likelihood ratio. Higher values indicate stronger evidence for a selective sweep.
*   **xpclr_norm**: The normalized score. This is generally the preferred metric for identifying outliers across the genome.
*   **sel_coef**: The best-fitting selection coefficient for the window.
*   **nSNPs / nSNPs avail**: If `nSNPs avail` is consistently much larger than `nSNPs`, your window size (`--size`) may be too large for the specified `--maxsnps`.

## Expert Tips

*   **Recombination Maps**: While a constant recombination rate (`--rrate`) is often used, providing a specific genetic map via `--map` (6-column space-delimited format) provides much higher accuracy in species with well-characterized recombination landscapes.
*   **Memory Management**: When working with whole-genome data, process one chromosome at a time using the `--chr` flag to manage memory usage effectively.
*   **Normalization**: Always use the `xpclr_norm` values for plotting Manhattan plots or identifying the top 1% of genomic regions under selection.

## Reference documentation
- [GitHub Repository - xpclr](./references/github_com_hardingnj_xpclr.md)
- [Bioconda Package - xpclr](./references/anaconda_org_channels_bioconda_packages_xpclr_overview.md)