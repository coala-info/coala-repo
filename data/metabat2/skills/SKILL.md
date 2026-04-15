---
name: metabat2
description: MetaBAT2 reconstructs individual microbial genomes from metagenomic assemblies by clustering contigs based on sequence composition and abundance profiles. Use when user asks to bin metagenomic contigs, generate metagenome-assembled genomes, or calculate contig depth profiles for binning.
homepage: https://bitbucket.org/berkeleylab/metabat
metadata:
  docker_image: "quay.io/biocontainers/metabat2:2.18--h6f16272_0"
---

# metabat2

## Overview
MetaBAT2 (Metagenomic Binning At Scale) is an automated tool designed to reconstruct individual microbial genomes from complex metagenomic assemblies. It integrates sequence composition (tetranucleotide frequencies) and multi-sample abundance (coverage) to cluster contigs into Metagenome-Assembled Genomes (MAGs). This skill provides the necessary command-line patterns to execute the binning workflow efficiently, from depth calculation to final bin generation.

## Core Workflow

### 1. Generate Abundance Profiles
Before binning, you must calculate the depth of coverage for your contigs across all samples. Use the `jgi_summarize_bam_contig_depths` tool included with the MetaBAT2 package.

```bash
jgi_summarize_bam_contig_depths --outputDepth depth.txt *.bam
```

### 2. Execute Binning
Run the main `metabat2` executable using the assembly FASTA and the depth file generated in the previous step.

```bash
metabat2 -i assembly.fasta -a depth.txt -o bins/bin
```

## Expert Tips and CLI Patterns

### Optimization Parameters
- **Contig Length**: By default, MetaBAT2 ignores contigs shorter than 2500bp. For highly fragmented assemblies, you can lower this using `-m` (e.g., `-m 1500`), though shorter contigs may decrease bin purity.
- **Sensitivity**: Use the `--presets` flag to quickly adjust the trade-off between sensitivity and specificity:
  - `--sensitive`: Increases the number of contigs binned at the cost of potential contamination.
  - `--verySensitive`: Maximum recovery of genomic material.
  - `--specific` / `--verySpecific`: Focuses on high-purity bins.

### Resource Management
- **Threading**: Use `-t` to specify the number of CPU threads. MetaBAT2 is highly parallelizable.
- **Memory**: For very large metagenomes, ensure the system has sufficient RAM to hold the distance matrix in memory.

### Common File Handling
- Ensure your BAM files are sorted and indexed before calculating depth.
- The output prefix (e.g., `-o bins/bin`) will create files named `bin.1.fa`, `bin.2.fa`, etc., inside the specified directory.



## Subcommands

| Command | Description |
|---------|-------------|
| jgi_summarize_bam_contig_depths | Summarize BAM contig depths for MetaBAT2 binning. |
| metabat2 | MetaBAT: Metagenome Binning based on Abundance and Tetranucleotide frequency. |

## Reference documentation
- [MetaBAT Bitbucket Repository](./references/bitbucket_org_berkeleylab_metabat.md)
- [Bioconda MetaBAT2 Package](./references/anaconda_org_channels_bioconda_packages_metabat2_overview.md)