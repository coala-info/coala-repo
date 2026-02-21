---
name: transcov
description: The `transcov` tool is designed for high-resolution mapping of sequencing reads around transcription start sites.
homepage: https://github.com/hogfeldt/transcov
---

# transcov

## Overview
The `transcov` tool is designed for high-resolution mapping of sequencing reads around transcription start sites. It allows researchers to quantify and visualize how transcriptional activity or protein binding (in the case of ChIP-seq) is distributed relative to the start of genes. It is particularly useful for identifying promoter-proximal pausing, determining TSS strength, and generating aggregate coverage plots across multiple genomic loci.

## Installation
The recommended way to install `transcov` is via the Bioconda channel:

```bash
conda install -c bioconda transcov
```

## Common CLI Patterns
While specific subcommands depend on the version, the general workflow involves providing genomic coordinates (often in BED format) and alignment files (BAM).

### Basic Coverage Mapping
To map coverage around a set of defined points:
```bash
transcov --bam input.bam --bed sites.bed --window 500 --output coverage_profile.txt
```
*   `--window`: Defines the base pair range upstream and downstream of the TSS to analyze.
*   `--bam`: The indexed alignment file.
*   `--bed`: The genomic locations of interest (TSS).

### Normalization and Scaling
For comparing multiple samples, ensure you use normalization flags if available (e.g., RPM/BPM) to account for differences in sequencing depth:
```bash
transcov --bam input.bam --bed sites.bed --normalize --output normalized_profile.txt
```

## Expert Tips
- **Indexing**: Always ensure your BAM files are indexed (`samtools index file.bam`) before running `transcov`, as the tool requires random access to genomic regions to calculate coverage efficiently.
- **Strand Specificity**: When working with TSS data, strand orientation is critical. Ensure your BED file has the correct strand information in column 6 so `transcov` can orient the upstream/downstream windows correctly.
- **Memory Management**: For very large BAM files or thousands of BED entries, consider subsetting your BED file to specific chromosomes to test parameters before running a genome-wide analysis.

## Reference documentation
- [Bioconda transcov Overview](./references/anaconda_org_channels_bioconda_packages_transcov_overview.md)
- [transcov GitHub Repository](./references/github_com_Hogfeldt_transcov.md)