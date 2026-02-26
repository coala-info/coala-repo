---
name: orna
description: ORNA reduces the size of Next-Generation Sequencing datasets through in silico normalization while preserving all k-mers for downstream assembly. Use when user asks to normalize sequencing reads, reduce dataset size for de novo assembly, or perform quality-based or abundance-based read sorting.
homepage: https://github.com/SchulzLab/ORNA
---


# orna

## Overview

ORNA (Optimized Read Normalization Algorithm) is a specialized tool for reducing the size of Next-Generation Sequencing (NGS) datasets through in silico normalization. Unlike random downsampling, ORNA treats normalization as a set multicover problem, ensuring that the minimum number of reads required to retain all k-mers (and their relative abundances) is kept. This approach guarantees that no connections in the De Bruijn Graph (DBG) are lost, making it a superior pre-processing step for memory-intensive de novo assemblers like Oases or TransABySS.

## CLI Usage and Best Practices

### Basic Command Patterns

**Single-end Normalization**
```bash
ORNA -input input.fasta -kmer 21 -base 1.7 -output normalized_reads
```

**Paired-end Normalization**
```bash
ORNA -pair1 reads_R1.fastq -pair2 reads_R2.fastq -type fastq -output normalized_PE
```

### Optimization Modes

ORNA provides two specialized sorting modes to improve the quality of the normalized dataset:

*   **ORNA-Q (Quality-based):** Use `-sorting 1` to prioritize reads with higher Phred quality scores. This maximizes the total read quality in the output.
*   **ORNA-K (Abundance-based):** Use `-ksorting 1` to prioritize reads based on median k-mer abundance.

### Key Parameter Tuning

*   **k-mer Size (`-kmer`):** Set this to the k-mer size you intend to use for your subsequent assembly. Note that ORNA internally increments this value by 1 (k+1) to preserve edge labels.
*   **Logarithmic Base (`-base`):** This controls the reduction stringency. A higher base value results in more aggressive normalization (fewer reads retained), while a lower base preserves more data. The default is 1.7.
*   **Output Type (`-type`):** Specify `fasta` or `fastq` based on your input. Default is fasta.

### Expert Tips and Constraints

*   **Error Correction:** Because ORNA guarantees the preservation of all k-mers, it will also preserve sequencing errors. It is highly recommended to run error correction (e.g., SEECER for RNA-seq) before using ORNA to achieve better reduction and assembly quality.
*   **Multithreading:** The `-nb-cores` parameter only works for single-end mode. Paired-end mode and the specialized sorting modes (ORNA-Q/ORNA-K) currently do not support multithreading.
*   **Memory Management:** ORNA is designed to be memory-efficient, but for extremely large datasets, ensure your environment has sufficient overhead for the GATB-core k-mer management system.
*   **Assembly Impact:** Normalization is a lossy process. Always validate the impact on your specific assembly by comparing metrics like N50 and gene representation if possible.

## Reference documentation
- [ORNA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_orna_overview.md)
- [ORNA GitHub Documentation](./references/github_com_SchulzLab_ORNA.md)