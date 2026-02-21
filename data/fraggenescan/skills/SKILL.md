---
name: fraggenescan
description: FragGeneScan is a specialized gene prediction tool designed to identify protein-coding genes in prokaryotic genomes.
homepage: https://sourceforge.net/projects/fraggenescan/
---

# fraggenescan

## Overview
FragGeneScan is a specialized gene prediction tool designed to identify protein-coding genes in prokaryotic genomes. Unlike traditional gene finders that require complete, high-quality sequences, FragGeneScan utilizes a Hidden Markov Model (HMM) that incorporates sequencing error models. This allows it to accurately predict genes in short, fragmented reads (e.g., Illumina or 454 reads) and handle frame shifts caused by insertions or deletions, making it a standard tool for metagenomic analysis and preliminary assembly annotation.

## Installation
The most reliable way to install FragGeneScan is via Bioconda:
```bash
conda install bioconda::fraggenescan
```

## Core Usage Patterns

### Basic Command Structure
As of version 1.32, the core logic is integrated into the main binary, and the previous Perl wrapper (`run_FragGeneScan.pl`) is no longer strictly required for standard operations.

```bash
FragGeneScan -s [input_file] -o [output_prefix] -w [is_complete] -t [train_model]
```

### Parameter Selection
*   **`-s`**: Input DNA sequence file in FASTA format.
*   **`-o`**: Prefix for the output files.
*   **`-w`**: Use `1` if the input is a complete genome or high-quality assembly contigs. Use `0` if the input consists of short sequencing reads.
*   **`-t`**: Specifies the training model. Common options include:
    *   `complete`: For whole genomes or long contigs.
    *   `illumina_10`: For Illumina reads with ~0.5% error rate.
    *   `illumina_5`: For Illumina reads with ~0.1% error rate.
    *   `454_10` or `454_30`: For 454 pyrosequencing reads.

### Output Files
FragGeneScan generates several files based on the provided prefix:
*   `.faa`: Predicted protein sequences in FASTA format.
*   `.ffn`: Predicted nucleotide sequences of the genes.
*   `.gff`: Gene coordinates and orientations.
*   `.out`: Standard output format containing gene predictions.

## Expert Tips and Best Practices
*   **Handling Assemblies**: For large assembly contigs, always use `-complete=1` and `-train=complete`. Version 1.30+ significantly optimized this mode, reducing processing time for large genomes from days to minutes.
*   **Short Read Performance**: When processing short reads (`-complete=0`), the tool is optimized for speed and can handle millions of fragments efficiently.
*   **Sequence Case**: Modern versions (1.15+) handle lowercase sequence input automatically, but it is best practice to ensure sequences are in standard IUPAC format.
*   **Memory Management**: For extremely long genes (up to 300,000 bp), ensure you are using version 1.03 or later, as earlier versions had lower memory allocation limits for reporting.
*   **Thread Support**: Version 1.19 added thread support. If available in your build, use multi-threading to speed up the processing of large metagenomic datasets.

## Reference documentation
- [FragGeneScan Overview](./references/sourceforge_net_projects_fraggenescan.md)
- [FragGeneScan Files and Version History](./references/sourceforge_net_projects_fraggenescan_files.md)
- [Bioconda FragGeneScan Package](./references/anaconda_org_channels_bioconda_packages_fraggenescan_overview.md)