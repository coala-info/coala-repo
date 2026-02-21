---
name: clever-toolkit
description: The CLEVER Toolkit (CTK) is a specialized suite designed for the sensitive discovery and accurate genotyping of genomic insertions and deletions.
homepage: https://bitbucket.org/tobiasmarschall/clever-toolkit
---

# clever-toolkit

## Overview
The CLEVER Toolkit (CTK) is a specialized suite designed for the sensitive discovery and accurate genotyping of genomic insertions and deletions. It excels at processing paired-end sequencing data by leveraging a clique-enumeration algorithm to identify clusters of discordant read pairs that signal structural variations. Use this tool when high-precision indel calling is required, particularly in complex genomic regions where standard mappers might struggle.

## Core Workflows and CLI Patterns

### 1. Discovery and Genotyping (The CLEVER Pipeline)
The primary entry point for most users is the `clever` command, which wraps the discovery and genotyping steps.

```bash
# Basic discovery and genotyping
clever --use-xa [ref.fa] [sorted_reads.bam] [output_directory]
```

- **Input**: Requires a reference genome (FASTA) and coordinate-sorted, indexed BAM files.
- **--use-xa**: Recommended when using BWA-MEM alignments to utilize alternative hit tags for better sensitivity in repetitive regions.

### 2. Component Tools
The toolkit consists of several specialized modules that can be run independently for custom pipelines:

- **`clever-core`**: The main discovery engine. It identifies candidate indel locations.
- **`clever-genotype`**: Takes candidate variants (VCF) and alignments (BAM) to provide genotype likelihoods and quality scores.
- **`insert-size-dist`**: A utility to estimate the library insert size distribution, which is a critical parameter for the discovery algorithm.

### 3. Best Practices for Structural Variant Calling
- **Read Mapping**: Ensure reads are mapped with a structural-variant-aware aligner (like BWA-MEM). CLEVER relies heavily on the distance and orientation of paired-end reads.
- **Library Statistics**: For the best results, ensure your BAM files have proper header information. If the automated library estimation fails, manually calculate the mean and standard deviation of your insert sizes.
- **Filtering**: The output is provided in VCF format. Always apply quality filters (QUAL field) to the resulting VCF to balance sensitivity and precision based on your specific project needs.

## Reference documentation
- [clever-toolkit Overview](./references/anaconda_org_channels_bioconda_packages_clever-toolkit_overview.md)
- [CLEVER Bitbucket Repository](./references/bitbucket_org_tobiasmarschall_clever-toolkit.md)