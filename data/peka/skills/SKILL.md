---
name: peka
description: PEKA identifies enriched protein-RNA binding motifs from CLIP datasets by comparing k-mer distributions around high-confidence crosslink sites. Use when user asks to determine PEKA scores, rank k-mers, or visualize motif enrichment profiles around crosslink sites.
homepage: https://github.com/ulelab/peka
---


# peka

## Overview

PEKA (Positionally-enriched k-mer analysis) is a bioinformatics tool designed to identify enriched protein-RNA binding motifs from CLIP datasets. It works by comparing k-mer enrichment in the proximity of high-confidence crosslink sites (thresholded crosslinks) against low-count crosslink sites located outside of peaks. This methodology effectively reduces technical biases, such as the uridine-preference often seen in UV crosslinking. Use this skill to determine PEKA scores, rank k-mers, and visualize motif enrichment profiles around crosslink sites.

## Command Line Usage

The primary interface for the tool is the `peka.py` script.

### Required Arguments

To run a standard analysis, provide the following inputs:

*   `-i <FILE.bed>`: CLIP peaks (intervals of crosslinks) in BED format.
*   `-x <FILE.bed>`: CLIP crosslinks in BED format.
*   `-g <FILE.fasta>`: Genome FASTA file (must match the alignment version).
*   `-gi <FILE.fai>`: Genome FASTA index file.
*   `-r <FILE>`: Genome segmentation file (typically produced by `iCount segment`).

### Common Parameter Adjustments

*   **K-mer Length**: Use `-k` to set the length (3, 4, 5, 6, or 7). Default is 5.
*   **Search Window**: Use `-w` to define the window around crosslinks for finding enriched k-mers. Default is 20 nt.
*   **Distal Window**: Use `-dw` to set the window for calculating the background distribution. Default is 150 nt.
*   **Thresholding**: Use `-p` to set the percentile (0 to 1) for considering thresholded crosslinks. Default is 0.7.
*   **Clustering**: Use `-c` to specify how many enriched k-mers to cluster and plot. Default is 5.

### Handling Repetitive Elements

Control how the tool treats genomic repeats using the `-re` flag:
*   `unmasked` (Default): Uses the genome as provided.
*   `masked`: Uses soft-masked (lowercase) sequences.
*   `remove_repeats`: Excludes repeat regions from analysis.
*   `repeats_only`: Analyzes only the repeat regions.

## Best Practices and Expert Tips

### Chromosome Naming Consistency
Ensure all input files (BED, FASTA, FAI, and Regions) follow the exact same chromosome naming convention. Mixing UCSC (e.g., "chr1") and Ensembl (e.g., "1") naming will cause the tool to fail or produce empty results.

### Region-Specific Analysis
If you are only interested in specific transcriptomic regions, use the `-sr` argument to limit the search space. Valid options include:
*   `UTR3`
*   `intron`
*   `whole_gene`
*   `ncRNA`
*   `intergenic`

### Performance Optimization
For very large crosslink files, enable subsampling with `-sub True` to reduce runtime without significantly compromising the enrichment profile.

### Relevant Position Thresholding
By default, PEKA uses a relaxed threshold (`-relax True`) for calculating scores, which is recommended for most datasets. If working with extremely high-complexity data and short k-mers (<=5), consider setting a manual threshold using `-pos <FLOAT>` to increase specificity.

## Reference documentation

- [PEKA GitHub Repository](./references/github_com_ulelab_peka.md)
- [PEKA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_peka_overview.md)