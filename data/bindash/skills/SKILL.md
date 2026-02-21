---
name: bindash
description: BinDash is a high-performance command-line utility designed for the comparison of massive genomic datasets, including pangenomes and metagenomes.
homepage: https://github.com/zhaoxiaofei/bindash
---

# bindash

## Overview

BinDash is a high-performance command-line utility designed for the comparison of massive genomic datasets, including pangenomes and metagenomes. It utilizes a bin-wise densified MinHash scheme to provide extremely fast and memory-efficient distance estimations. By converting raw sequence data into compact "sketches," BinDash allows users to estimate the Jaccard Index and Average Nucleotide Identity (ANI) between genomes without the computational overhead of traditional alignment methods.

## Core Workflow

The standard BinDash workflow consists of two primary steps: sketching the input sequences and then calculating the distances between those sketches.

### 1. Sketching Sequences
Create a compressed representation of your genomic data. BinDash supports FASTA and FASTQ formats (including gzipped files).

**Single file sketching:**
```bash
bindash sketch --outfname=genome.sketch input.fasta
```

**Batch sketching (using a list file):**
Create a text file (e.g., `genomes.txt`) containing the path to one genome per line.
```bash
bindash sketch --listfname=genomes.txt --outfname=all_genomes.sketch
```

### 2. Distance Estimation
Compare sketches to generate distance metrics. The output includes the query name, target name, mutation distance, p-value, and Jaccard Index.

**All-vs-all comparison:**
```bash
bindash dist --outfname=results.txt all_genomes.sketch
```

**Query against a database:**
```bash
bindash dist --outfname=query_results.txt query.sketch database.sketch
```

## Expert Parameters and Best Practices

### Accuracy Tuning
*   **Sketch Size:** For high-accuracy comparisons (ANI > 99.5%), ensure the `--sketchsize64` parameter is set to at least **188**. This results in an actual sketch size of approximately 12,000, which is necessary to resolve very fine differences between closely related strains.
*   **K-mer Size:** While default k-mer sizes are often sufficient, remember that larger genomes generally require larger k-mer sizes to maintain specificity.

### Statistical Models
BinDash allows you to choose the underlying probabilistic model for ANI estimation via the `--model` option:
*   **Poisson:** Use for general distance estimation.
*   **Binomial:** Use when the binomial assumption better fits your specific genomic architecture or comparison scale.

### Densification Strategies
If you need to tune the MinHash performance or behavior, use the `--dens` flag:
*   `--dens=1`: Optimal densification (Shrivastava 2017).
*   `--dens=2`: Faster densification (Mai et al. 2020), offering O(k*log(k)) complexity.
*   `--dens=3`: Re-randomized densification (Li et al. 2019).

### Performance Optimization
*   **Parallelization:** BinDash is designed to utilize available CPU instructions (like AVX2 or AVX512) automatically for POPCOUNT operations.
*   **Memory:** Because it operates on sketches, you can compare terabytes of data on a standard laptop once the initial sketching phase is complete.

## Reference documentation
- [BinDash GitHub Repository](./references/github_com_zhaoxiaofei_bindash.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_bindash_overview.md)