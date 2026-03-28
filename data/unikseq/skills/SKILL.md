---
name: unikseq
description: unikseq is an alignment-free tool that identifies unique genomic regions in a reference sequence by comparing k-mers against ingroup and outgroup datasets. Use when user asks to find unique sequences for eDNA applications, identify species-specific k-mers, or design highly specific qPCR primers from fragmented genomic data.
homepage: https://github.com/bcgsc/unikseq
---

# unikseq

## Overview

unikseq is a k-mer based tool designed to find genomic regions that are unique to a specific reference sequence relative to a set of outgroup sequences. Unlike Multiple Sequence Alignment (MSA) methods, unikseq is alignment-free, making it significantly faster and capable of handling unstructured data such as raw sequencing reads, fragmented contigs, or unordered genome sequences. It is particularly effective for environmental DNA (eDNA) applications where high specificity is required to distinguish between closely related species.

## Installation and Setup

The most reliable way to install unikseq and its dependencies (including Bloom filter libraries) is via Conda:

```bash
conda install -c bioconda unikseq
```

Alternatively, clone the repository for the Perl source:

```bash
git clone https://github.com/BirolLab/unikseq
cd unikseq
```

## Core Usage Patterns

### Standard Uniqueness Analysis
The primary script `unikseq.pl` identifies k-mers in the reference that are found in the ingroup but not in the outgroup.

```bash
perl unikseq.pl -r reference.fa -i ingroup.fa -o outgroup.fa -k 25 > unique_regions.txt
```

### Large-Scale Analysis (Bloom Filter Version)
For Gbp-scale genomes or massive sequencing datasets, use the Bloom filter variant to save memory. This requires a two-step process:

1. **Generate Bloom Filters**:
   ```bash
   # Create a Bloom filter for the outgroup sequences
   perl tools/writeBloom.pl outgroup.fa 25 10G outgroup.bf
   ```

2. **Run unikseq-Bloom**:
   Use the specialized Bloom filter implementation (typically provided in the `tools/` directory or via conda) to check k-mer presence against the pre-built filter.

## Expert Tips and Best Practices

- **Outgroup Completeness**: The uniqueness of identified regions is strictly relative to the outgroup provided. Ensure your outgroup is as complete as possible to avoid false positives (regions flagged as unique only because the corresponding sequence was missing from the outgroup file).
- **K-mer Size Selection**: A k-mer size of 25 is standard for many applications, but you should increase `k` for highly repetitive genomes or decrease it if looking for very short conserved motifs.
- **Handling Incomplete Data**: unikseq is robust against fragmented data. You can mix raw WGS reads and finished genomes in your ingroup/outgroup files without prior assembly or orientation.
- **qPCR Design**: Use the output coordinates to extract sequences for primer-probe design. Since the regions are pre-validated against the outgroup, the resulting assays typically require less manual screening for cross-reactivity.

## Visualization

To visualize the distribution of unique k-mers across a reference (e.g., a mitogenome), use the provided R script to generate a "butterfly plot":

```bash
Rscript butterfly-plot.r <data_file> <species_name>
```
This produces a PDF showing the proportion of species sharing specific k-mers at each position of the reference.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/unikseq.pl | v2.0.0 |
| unikseq_writeBloom.pl | Writes a bloom filter from sequences. |

## Reference documentation
- [unikseq GitHub Repository](./references/github_com_BirolLab_unikseq.md)
- [unikseq README](./references/github_com_BirolLab_unikseq_blob_main_README.md)
- [Butterfly Plot Script](./references/github_com_BirolLab_unikseq_blob_main_butterfly-plot.r.md)