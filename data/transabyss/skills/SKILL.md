---
name: transabyss
description: Trans-ABySS performs de novo assembly of RNA-Seq data. Use when user asks to assemble RNA-Seq data, perform individual k-mer assemblies, merge multiple assemblies, or produce a transcriptome.
homepage: http://www.bcgsc.ca/platform/bioinfo/software/trans-abyss
---


# transabyss

## Overview
Trans-ABySS is a pipeline designed for the de novo assembly of RNA-Seq data, leveraging the ABySS assembler. Unlike genomic assembly, RNA-Seq assembly must account for highly variable expression levels. This skill provides guidance on executing the two primary stages of the Trans-ABySS workflow: individual k-mer assemblies and the subsequent merging of those assemblies to produce a comprehensive transcriptome.

## Usage Patterns

### Single k-mer Assembly
To run an assembly for a specific k-mer size, use the `transabyss` command. Small k-mer sizes (e.g., 25–32) are often effective for capturing both rare and common transcripts in version 1.5.1+.

```bash
transabyss --kmer <size> --name <output_prefix> --pe <reads_1.fastq> <reads_2.fastq>
```

### Merging Multiple Assemblies
A key strength of Trans-ABySS is merging assemblies from different k-mer lengths to maximize sensitivity. Use `transabyss-merge` to consolidate these results and remove redundancy.

```bash
transabyss-merge --input <assembly1.fa> <assembly2.fa> <assembly3.fa> --out <merged_transcriptome.fa>
```

## Best Practices and Expert Tips
- **K-mer Selection**: It is standard practice to run multiple assemblies across a range of k-mer sizes (e.g., k25 to k75 in increments of 10) and then merge them.
- **Strand-Specific Data**: If using strand-specific RNA-Seq, ensure you utilize the support introduced in version 1.5.1 to improve assembly contiguity and orientation.
- **Contig Filtering**: By default, the shortest contig length is set to 100 bp (as of version 1.5.5). If you are looking for very short transcripts, you may need to adjust the filtering cutoffs.
- **Structural Variants**: For structural variant detection, while older versions included `transabyss-analyze`, the developers now recommend using **PAVFinder** for more robust results.
- **Resource Management**: Assembly is memory-intensive. Ensure your environment has sufficient RAM, especially when using large k-mer sizes or processing high-depth libraries.

## Reference documentation
- [Trans-ABySS Software Overview](./references/www_bcgsc_ca_resources_software_trans-abyss.md)
- [Bioconda Trans-ABySS Package Details](./references/anaconda_org_channels_bioconda_packages_transabyss_overview.md)