---
name: methylmap
description: Methylmap is a specialized visualization tool designed to handle large-scale cohort data for nucleotide modifications.
homepage: https://github.com/EliseCoopman/methylmap
---

# methylmap

## Overview
Methylmap is a specialized visualization tool designed to handle large-scale cohort data for nucleotide modifications. It allows researchers to compare methylation patterns across multiple samples or experimental groups (e.g., case vs. control) within specific genomic windows. The tool supports modern long-read data formats and provides features like hierarchical clustering (dendrograms), haplotyping, and gene annotation tracks.

## Core CLI Usage Patterns

### 1. Visualizing from BAM/CRAM Files
When working with modern Nanopore alignments containing base modification tags (MM/ML), use the `--files` and `--fasta` arguments.
```bash
methylmap --files sample1.cram sample2.cram \
          --fasta reference.fa \
          --gff sorted_annotation.gff3.gz \
          --window chr20:58839718-58911192
```

### 2. Visualizing from Nanopolish Data
If using nanopolish, ensure files are first processed by `calculate_methylation_frequency.py`.
```bash
methylmap --files freq1.tsv freq2.tsv \
          --gff sorted_annotation.gff3.gz \
          --window chr20:58839718-58911192
```

### 3. Using an Overview Table for Large Cohorts
For complex experiments, create a tab-separated "overview table" with headers `file`, `name`, and `group` to manage metadata efficiently.
```bash
# overview.tsv content:
# file    name    group
# /path/s1.bam    SampleA    case
# /path/s2.bam    SampleB    control

methylmap --table overview.tsv \
          --fasta reference.fa \
          --gff sorted_annotation.gff3.gz \
          --window chr20:58839718-58911192
```

## Data Preparation Requirements

### GFF3 Annotation Track (Mandatory)
The `--gff` argument is required for the tool to function. The file must be specifically prepared:
1.  **Sort**: `zcat annotation.gff3.gz | sort -k1,1V -k4,4n | bgzip > sorted.gff3.gz`
2.  **Index**: `tabix -p gff sorted.gff3.gz`

### Reference Genome
When using BAM/CRAM input, the reference FASTA must be uncompressed (not zipped/bgzipped) and its index (`.fai`) must be in the same directory.

## Expert Tips and Advanced Options

*   **Clustering**: Use `--dendro` to perform hierarchical clustering of samples based on their modification patterns.
*   **Haplotypes**: Use `--hapl` to visualize phased methylation data if your input files contain haplotype information.
*   **Modification Types**: Specify the modification type with `--mod {m,h}` (e.g., 'm' for 5mC, 'h' for 5hmC).
*   **Missing Data**: Methylmap automatically removes individuals with >40% missing data. Remaining gaps are estimated using pandas interpolation. If interpolation fails, the individual is removed from the plot.
*   **Performance**: Use `--threads` to speed up processing of multiple large BAM/CRAM files.
*   **Pre-parsing**: For extremely large datasets, use the `multiparsetable.py` script (found in the tool's `scripts/` folder) to generate a frequency table once, then use `--table` for rapid iterative plotting.

## Reference documentation
- [Methylmap GitHub Repository](./references/github_com_EliseCoopman_methylmap.md)
- [Bioconda Methylmap Package](./references/anaconda_org_channels_bioconda_packages_methylmap_overview.md)