---
name: besst
description: BESST (Biochemical Engineering Scaffolding Tool) is a genomic assembly scaffolder designed to bridge the gaps between contigs.
homepage: https://github.com/ksahlin/BESST
---

# besst

## Overview

BESST (Biochemical Engineering Scaffolding Tool) is a genomic assembly scaffolder designed to bridge the gaps between contigs. It utilizes the orientation and distance information provided by paired-end (PE) or mate-pair (MP) reads to order and orient contigs into larger scaffolds. BESST is particularly effective because it can automatically infer library characteristics—such as insert size distributions and contamination levels—directly from the input data, reducing the need for manual parameter tuning.

## Installation

The recommended way to install BESST is via Bioconda:

```bash
conda install bioconda::besst
```

## Basic Usage

The primary command for running the scaffolder is `runBESST`. At a minimum, you must provide a contig file, one or more BAM files, an output directory, and the library orientation.

```bash
runBESST -c /path/to/contigs.fa -f /path/to/library.bam -o /path/to/output -orientation fr
```

### Key Arguments
- `-c`: Path to the contig FASTA file.
- `-f`: Path to one or more sorted and indexed BAM files (space-separated).
- `-o`: Output directory.
- `-orientation`: Library orientation. Use `fr` (forward-reverse, typical for PE) or `rf` (reverse-forward, typical for MP).

## Best Practices and Expert Tips

### 1. Start with Minimal Parameters
BESST is designed to infer as much as possible from the data. For a first run, avoid setting manual thresholds for insert sizes or link counts. Let the tool generate its own estimates and check the `Statistics.txt` file in the output directory to see if the inferred values align with your expectations.

### 2. Aligner Selection and Settings
- **Preferred Aligner**: BWA-mem with default parameters is generally recommended.
- **Uniqueness is Critical**: BESST currently only works with uniquely aligned reads. It detects uniqueness by looking at the BAM flags.
- **Avoid Multi-mapping**: Do not use aligner settings that report multiple suboptimal alignments (e.g., avoid Bowtie's `-k` parameter if set to anything other than 1).

### 3. Handling Mate-Pair (MP) Libraries
- **Adapter Trimming**: Always use an adapter trimming tool (like NxTrim) before alignment. This prevents chimeric reads from creating false links.
- **PE Contamination**: MP libraries often contain PE contamination. BESST can identify these distributions automatically. If you have a mix of MP and PE reads, it is often better to provide the full library with original orientations preserved rather than trying to manually separate them, provided the distributions are distinct.

### 4. Troubleshooting and Debugging
If BESST fails to produce scaffolds or the results seem incorrect, consult the `BESST_output/Statistics.txt` file. Key metrics to check include:
- **Library Statistics**: Ensure the mean and standard deviation of the insert size look realistic.
- **Contamination Rate**: Check the estimated PE contamination rate in MP libraries.
- **Link Counts**: Look at how many read pairs were actually used for scaffolding. If this number is very low, your mapping quality or uniqueness filters may be too stringent.

### 5. Memory and Performance
For large fragmented assemblies, ensure your BAM files are sorted and indexed. This allows BESST to process the data efficiently without loading the entire alignment into memory.

## Reference documentation
- [BESST GitHub Repository](./references/github_com_ksahlin_BESST.md)
- [BESST Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_besst_overview.md)