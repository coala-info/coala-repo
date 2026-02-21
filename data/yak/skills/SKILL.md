---
name: yak
description: yak (Yet Another K-mer analyzer) is a high-performance tool for genomic quality assessment.
homepage: https://github.com/lh3/yak
---

# yak

## Overview
yak (Yet Another K-mer analyzer) is a high-performance tool for genomic quality assessment. It operates by comparing the k-mer distributions of high-accuracy sequences (like assemblies or HiFi reads) against the k-mer spectrum of short-read data. Its primary strength lies in its empirical model for estimating base accuracy (QV), which remains reliable even as accuracy approaches Q50 by accounting for unsampled and erroneous k-mers in the reference short-read set.

## Common CLI Patterns

### 1. Building K-mer Hash Tables
The `count` command is the prerequisite for most analyses. It generates a `.yak` file representing the k-mer profile of your reads or assembly.

**For assemblies (counting singletons):**
```bash
yak count -K1.5g -t32 -o asm.yak asm.fa.gz
```

**For high-coverage reads (discarding singletons to save memory):**
```bash
yak count -b37 -t32 -o reads.yak reads.fq.gz
```

**For paired-end short reads:**
To provide two identical streams for counting:
```bash
yak count -b37 -t32 -o sr.yak <(zcat sr*.fq.gz) <(zcat sr*.fq.gz)
```

### 2. Estimating Base Accuracy (QV)
The `qv` command calculates the consensus quality of an assembly or a set of reads by comparing them to a short-read k-mer hash table.

**Compute assembly QV:**
```bash
yak qv -t32 -p -K3.2g -l100k sr.yak asm.fa.gz > asm-sr.qv.txt
```

**Compute CCS read QV:**
```bash
yak qv -t32 -p sr.yak ccs-reads.fq.gz > ccs-sr.qv.txt
```

### 3. Evaluating Assembly Completeness
Use the `inspect` command with two yak files (typically short-read k-mers vs. assembly k-mers) to determine how many k-mers from the reads are represented in the assembly.

```bash
yak inspect sr.yak asm.yak > sr-asm.kqv.txt
```

### 4. Generating K-mer Histograms
To visualize the k-mer frequency distribution of a dataset:
```bash
yak inspect sr.yak > sr.hist
```

### 5. Sex Chromosome Partitioning
Yak can be used to partition X and Y chromosomes in human de novo assemblies using specific k-mer sets for Y-unique, X-unique, and Pseudo-Autosomal Regions (PAR).

```bash
yak sexchr -K2g -t16 chrY-no-par.yak chrX-no-par.yak par.yak hap1.fa hap2.fa > cnt.txt
```

## Expert Tips and Best Practices

*   **Memory Management**: Use the `-K` flag to pre-allocate the hash table size. It supports human-readable suffixes (e.g., `1.5g` for 1.5 billion entries). If the hash table is too small, performance degrades; if too large, it wastes RAM.
*   **Singleton Handling**: For high-coverage short reads (e.g., Illumina), use `-b` (typically `-b37`) to ignore k-mers appearing only once. This significantly reduces the memory footprint and filters out most sequencing errors. For assemblies, do not use `-b` as you want to count every k-mer.
*   **Thread Scaling**: Most yak commands scale well with the `-t` flag. For large genomes, 16-32 threads are recommended.
*   **QV Interpretation**: When accuracy is very high (Q50+), the `-p` flag is essential as it invokes the empirical model that compensates for the limitations of the short-read "truth" set.
*   **Output Redirection**: Most yak commands output to stdout; always redirect to a file for record-keeping.

## Reference documentation
- [bioconda / yak Overview](./references/anaconda_org_channels_bioconda_packages_yak_overview.md)
- [lh3/yak GitHub Repository](./references/github_com_lh3_yak.md)