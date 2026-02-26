---
name: tadbit
description: TADbit is a Python-based framework for processing Hi-C data, from raw sequencing reads to normalized interaction matrices and three-dimensional chromatin models. Use when user asks to map Hi-C reads, normalize interaction matrices, identify Topologically Associating Domains, or generate 3D models of genomic regions.
homepage: http://sgt.cnag.cat/3dg/tadbit/
---


# tadbit

## Overview
TADbit provides a unified framework for the entire Hi-C data processing pipeline. It transforms raw sequencing reads into normalized interaction matrices, identifies Topologically Associating Domains (TADs), and generates three-dimensional models of chromatin folding. It is particularly effective for researchers needing a reproducible, Python-based workflow that moves from raw FASTQ files to publication-quality structural visualizations.

## Core Workflows and CLI Patterns

### 1. Data Pre-processing and Mapping
TADbit uses a fragment-based mapping strategy. Ensure you have the restriction enzyme details and the reference genome indexed.

*   **Mapping**: Use `tadbit map` to align reads. It is recommended to use the iterative mapping strategy for higher resolution.
*   **Parsing**: Convert mapped BAM files into TADbit's internal format using `tadbit parse`.
*   **Filtering**: Remove experimental artifacts (self-ligated fragments, dangling ends, etc.) using `tadbit filter`.

### 2. Normalization and Matrix Generation
Once filtered, data must be binned and normalized to account for genomic biases.

*   **Binning**: Use `tadbit segment` to define the resolution (e.g., 10kb, 50kb, 100kb).
*   **Normalization**: Apply the Vanilla Coverage or ICE (Iterative Correction and Eigenvector decomposition) methods to the interaction matrices.

### 3. Structural Analysis
*   **TAD Calling**: Identify domain boundaries using the `tadbit describe` or specific segmentation commands. TADbit uses a breakpoint detection algorithm based on a Poisson model.
*   **3D Modeling**: Generate 3D restraints from the interaction frequencies to build spatial models of specific genomic regions.

### 4. Common CLI Commands
*   `tadbit map -f fastq1.gz fastq2.gz -r enzyme_name -g genome.fasta`: Map raw reads.
*   `tadbit filter -w work_dir`: Apply standard filters to mapped data.
*   `tadbit bin -w work_dir -binsize 100000`: Generate a 100kb resolution matrix.
*   `tadbit segment -w work_dir`: Identify TAD boundaries.

## Expert Tips
*   **Resolution Selection**: Always choose a bin size that ensures a sufficient number of counts per bin (typically >80% non-zero cells in the matrix).
*   **Quality Control**: Review the filtering statistics provided by `tadbit filter` to ensure the library complexity is sufficient and that "dangling ends" do not dominate the dataset.
*   **Visualization**: Use the Python API (`import pytadbit`) for more granular control over plotting interaction heatmaps and structural models compared to the basic CLI outputs.

## Reference documentation
- [TADbit @ CNAG/CRG Building 3D genomes](./references/sgt_cnag_cat_3dg_tadbit.md)
- [TADbit Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tadbit_overview.md)