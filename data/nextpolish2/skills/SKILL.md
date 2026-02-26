---
name: nextpolish2
description: NextPolish2 is a consensus refinement tool that corrects small-scale assembly errors using HiFi reads and short-read k-mer data while preserving haplotype structure. Use when user asks to polish genome assemblies, correct SNVs and indels in long-read assemblies, or refine assemblies using short-read k-mers without collapsing heterozygous regions.
homepage: https://github.com/Nextomics/NextPolish2
---


# nextpolish2

## Overview

NextPolish2 is a specialized consensus refinement tool that targets small-scale assembly errors (SNVs and Indels) while maintaining the original haplotype structure. It is particularly effective for polishing regions where HiFi reads may struggle or where ONT-based gap filling has introduced errors. By utilizing a built-in phasing module and short-read k-mer data, it ensures that corrections do not collapse heterozygous regions or produce artifacts in complex repeats.

## Installation

The tool is available via Bioconda:
```bash
conda install bioconda::nextpolish2
```

## Core Workflow

Polishing with NextPolish2 requires three main components: the assembly FASTA, a sorted/indexed BAM of HiFi reads mapped to that assembly, and k-mer count files generated from short reads.

### 1. Prepare HiFi Mapping
Winnowmap is the preferred aligner for repetitive regions, though Minimap2 is also supported.

**Using Winnowmap (Recommended):**
```bash
# 1. Generate repetitive k-mers
meryl count k=15 output merylDB asm.fa.gz
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt

# 2. Map and sort
winnowmap -t 8 -W repetitive_k15.txt -ax map-pb asm.fa.gz hifi.fastq.gz | samtools sort -o hifi.map.sort.bam -
samtools index hifi.map.sort.bam
```

### 2. Generate K-mer Datasets
Use `yak` to count k-mers from high-quality short reads (>=60X coverage recommended). It is best practice to use multiple k-mer sizes (e.g., 21 and 31).

```bash
# Count 21-mers
yak count -o k21.yak -k 21 -b 37 <(zcat sr.R1.fastq.gz) <(zcat sr.R2.fastq.gz)

# Count 31-mers
yak count -o k31.yak -k 31 -b 37 <(zcat sr.R1.fastq.gz) <(zcat sr.R2.fastq.gz)
```

### 3. Run NextPolish2
Execute the polisher using the BAM and the yak files.

```bash
nextPolish2 -t 8 hifi.map.sort.bam asm.fa.gz k21.yak k31.yak > asm.polished.fa
```

## Expert Tips and Best Practices

- **Short Read Quality:** The accuracy of NextPolish2 depends heavily on short-read quality. Always run `fastp` or a similar tool to remove adapters and low-quality bases before generating yak k-mer files.
- **Haplotype Consistency:** If the genome was assembled via trio binning, discard reads belonging to the alternative haplotype before mapping to the reference to maximize accuracy.
- **Overcorrection Prevention:** NextPolish2 is designed to avoid the overcorrection issues common in the original NextPolish. If you observe unexpected changes in heterozygous regions, ensure your short reads are not contaminated and that the mapping parameters are appropriate for your specific assembly.
- **Memory/Threads:** Adjust the `-t` parameter based on available CPU cores. The tool is written in Rust and scales well with additional threads.
- **Minimum Contig Length:** Use `-L` (or `--min_ctg_len`) to skip very small contigs if they are likely to be assembly artifacts.

## Reference documentation
- [NextPolish2 Main Documentation](./references/github_com_Nextomics_NextPolish2.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nextpolish2_overview.md)