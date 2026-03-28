---
name: nextpolish2
description: NextPolish2 improves the consensus accuracy of genome assemblies by correcting errors in homopolymers and microsatellites using short-read k-mer distributions. Use when user asks to polish a genome assembly, improve consensus accuracy with short reads, or correct errors in PacBio HiFi assemblies while maintaining haplotype phasing.
homepage: https://github.com/Nextomics/NextPolish2
---

# nextpolish2

## Overview

NextPolish2 is a specialized genomic tool used to improve the consensus accuracy of high-quality genome assemblies, particularly those generated from PacBio HiFi reads. While HiFi assemblies are generally excellent, they often contain small errors in microsatellites or homopolymer runs. NextPolish2 resolves these by leveraging the accuracy of short-read k-mer distributions. Unlike its predecessor, it includes a phasing module that ensures corrections do not collapse haplotypes, making it ideal for heterozygous regions and complex repeats.

## Workflow and CLI Usage

The polishing process requires three main components: the draft assembly, a sorted/indexed BAM file of HiFi reads mapped to that assembly, and k-mer files generated from short reads.

### 1. Prepare the HiFi Mapping File
It is recommended to use `winnowmap` for mapping to better handle repetitive regions.

```bash
# 1. Count k-mers for winnowmap
meryl count k=15 output merylDB asm.fa.gz
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt

# 2. Map HiFi reads and sort
winnowmap -t 8 -W repetitive_k15.txt -ax map-pb asm.fa.gz hifi.fasta.gz | samtools sort -o hifi.map.sort.bam -

# 3. Index the BAM
samtools index hifi.map.sort.bam
```

### 2. Generate K-mer Datasets
Use `yak` to create k-mer files from Illumina short reads (recommended coverage >= 60X). Perform quality control with `fastp` before counting.

```bash
# Generate 21-mer and 31-mer datasets
yak count -o k21.yak -k 21 -b 37 <(zcat sr.R1.clean.fq.gz) <(zcat sr.R2.clean.fq.gz)
yak count -o k31.yak -k 31 -b 37 <(zcat sr.R1.clean.fq.gz) <(zcat sr.R2.clean.fq.gz)
```

### 3. Run NextPolish2
Execute the polishing command by providing the BAM, the assembly, and the yak files.

```bash
nextPolish2 -t 10 hifi.map.sort.bam asm.fa.gz k21.yak k31.yak > polished_assembly.fa
```

## Expert Tips and Best Practices

*   **Short Read Quality**: The accuracy of NextPolish2 is heavily dependent on the quality of the short reads. Always perform adapter removal and quality trimming (e.g., using `fastp`) to prevent overcorrection.
*   **Haplotype Consistency**: If your genome was assembled via trio binning, you should discard reads belonging to the other haplotype before the mapping step to maximize accuracy.
*   **The `-r` Flag**: Use the `-r` option if you want to try an alternative correction mode that may perform differently in specific genomic contexts.
*   **Mapping Parameters**: If certain regions are not being corrected, it is often because HiFi reads failed to map there due to high local error rates. Try relaxing mapping parameters in `winnowmap` or `minimap2` to increase coverage in those areas.
*   **Memory Management**: NextPolish2 is written in Rust and is generally efficient, but processing large T2T genomes with many k-mer files requires significant RAM. Ensure your environment has sufficient resources for the number of threads (`-t`) specified.



## Subcommands

| Command | Description |
|---------|-------------|
| nextPolish2 | Repeat-aware polishing genomes assembled using HiFi long reads |
| yak | yak <command> <argument> |

## Reference documentation
- [NextPolish2 Main Documentation](./references/github_com_Nextomics_NextPolish2_blob_main_README.md)
- [NextPolish2 Benchmarking and Examples](./references/github_com_Nextomics_NextPolish2_blob_main_doc_benchmark1.md)
- [NextPolish2 FAQ](./references/github_com_Nextomics_NextPolish2_blob_main_doc_faq.md)