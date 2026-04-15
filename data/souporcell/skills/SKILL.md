---
name: souporcell
description: souporcell is a genetic demultiplexing pipeline that assigns single-cell RNA-seq data from pooled samples to their donors of origin using natural genetic variation. Use when user asks to demultiplex pooled scRNA-seq samples, assign cells to donors, or detect doublets in pooled transcriptomic data.
homepage: https://github.com/wheaton5/souporcell
metadata:
  docker_image: "quay.io/biocontainers/souporcell:2.5--hc1c3326_0"
---

# souporcell

## Overview

souporcell is a robust pipeline for the genetic demultiplexing of pooled scRNA-seq samples. By analyzing the natural genetic variation captured in transcriptomic data, it assigns cells to their respective donors of origin. This is essential for experiments where multiple biological samples are processed in a single lane to reduce batch effects and costs. The pipeline integrates several bioinformatics tools—including minimap2 for remapping, freebayes for variant calling, and vartrix for allele counting—to perform clustering and doublet detection through a sparse mixture model.

## Core Pipeline Usage

The recommended way to run souporcell is via a Singularity/Apptainer container to ensure all dependencies (minimap2, freebayes, vartrix, etc.) are correctly configured.

### Basic Command Pattern
```bash
singularity exec souporcell_latest.sif souporcell_pipeline.py \
    -i /path/to/possorted_genome_bam.bam \
    -b /path/to/barcodes.tsv \
    -f /path/to/reference.fasta \
    -t 8 \
    -o output_directory \
    -k 4
```

### Required Arguments
- `-i / --bam`: The position-sorted BAM file (typically `possorted_genome_bam.bam` from CellRanger).
- `-b / --barcodes`: The `barcodes.tsv` file from the CellRanger filtered output.
- `-f / --fasta`: The reference genome FASTA file used for alignment.
- `-t / --threads`: Number of CPU threads to allocate.
- `-o / --out_dir`: The directory where results will be stored.
- `-k / --clusters`: The expected number of individuals (donors) in the pool.

## Expert Tips and Best Practices

### Performance Optimization
- **Use Common Variants**: Providing a VCF of known population variants using `--common_variants` significantly speeds up the process by allowing the tool to skip the computationally expensive de novo variant calling step (freebayes).
- **Skip Remapping**: You can use `--skip_remap` to save time, but this is **only recommended** if you are also providing a `--common_variants` file.
- **Memory Requirements**: For human datasets, ensure the environment has at least 24GB of RAM available, primarily for the minimap2 indexing step.
- **Disk Space**: souporcell generates intermediate files. Ensure you have disk space equivalent to at least 2x the size of your input BAM file.

### Advanced Configuration
- **Ploidy**: Default is 2 (human). Use `-p 1` for haploid organisms or specific experimental setups.
- **Known Genotypes**: If you have pre-existing genotypes for your donors, provide them via `--known_genotypes` (VCF format) to assign clusters to specific individuals directly.
- **Restart Clustering**: If you are clustering a large number of individuals (k > 12), increase the `--restarts` parameter to avoid getting stuck in local minima during the clustering phase.

### Troubleshooting
- **Input Compatibility**: Ensure the reference FASTA matches the one used for the original alignment.
- **Barcodes**: If using CellRanger 3.0+, ensure you point to the unzipped `barcodes.tsv` or handle the `.gz` extension appropriately depending on your version of souporcell.
- **Data Errors**: If the pipeline fails due to assertion errors in the data, you can use `--ignore True` to bypass them, though this should be done with caution as it may indicate underlying data quality issues.

## Reference documentation
- [souporcell GitHub Repository](./references/github_com_wheaton5_souporcell.md)
- [souporcell Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_souporcell_overview.md)