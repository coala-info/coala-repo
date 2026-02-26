---
name: sibelia
description: Sibelia identifies synteny blocks and genomic variants by comparing closely related microbial sequences using de Bruijn graphs. Use when user asks to find conserved regions across multiple genomes, perform pairwise genome comparisons, or detect SNPs and indels in bacterial datasets.
homepage: https://github.com/bioinf/Sibelia
---


# sibelia

## Overview

Sibelia is a specialized genomic toolset designed for the comparison of closely related sequences, such as different strains of the same bacterial species. It utilizes de Bruijn graphs to identify synteny blocks—conserved regions across multiple genomes—and provides a way to view genomes as permutations of these blocks. The package also includes C-Sibelia, which focuses on pairwise genome comparison to detect variants like SNPs and indels. This skill is most effective for microbial researchers working with bacterial datasets under 1 GB in size.

## Installation and Environment

Sibelia is primarily distributed via Bioconda. Note that while the core Sibelia tool runs on Windows and Unix-like systems, the C-Sibelia variant calling tool and its annotation scripts have specific environment requirements.

- **Conda Installation**: `conda install bioconda::sibelia`
- **C-Sibelia Requirements**: Requires a Unix-like environment with Python 2.7 and Perl.
- **Annotation Requirements**: The variant annotation script requires a Java runtime and `snpEff`.

## Core Tool Usage

### Sibelia (Synteny Block Generation)
Use this tool to find coordinates of conserved blocks across multiple FASTA files.

- **Input**: A set of FASTA files containing the genomes to be compared.
- **Output**: 
  - Coordinates of synteny blocks within the input sequences.
  - Genomes represented as permutations of these blocks.
- **Key Options**:
  - `noblocks`: Use this flag if you wish to skip the generation of block files.
  - `nographics`: Use this flag to suppress graphical output generation.

### C-Sibelia (Pairwise Comparison & Variant Calling)
Use this tool for detailed comparison between two genomes, whether they are in finished form or provided as sets of contigs.

- **Workflow**: It identifies unique synteny blocks (one copy in reference, one in query) and aligns them to find differences.
- **Output**: Detects SNPs/SNVs and indels of various scales.
- **Annotation**: Use the provided annotation script to process C-Sibelia results through `snpEff`.

## Expert Tips and Best Practices

- **Input Size Limit**: Sibelia is optimized for microbial genomes. It does not support input datasets larger than 1 GB. For larger genomes (e.g., eukaryotes), use **SibeliaZ** and **maf2synteny** instead.
- **Handling Contigs**: C-Sibelia is specifically designed to handle fragmented assemblies (contigs) as well as finished genomes, making it useful for comparing draft assemblies to references.
- **Variant Filtering**: C-Sibelia focuses on unique blocks. If you need alignments of repeats or multi-copy blocks, ensure you specify the option to output all alignments, though this may increase noise in variant calling.
- **Character Support**: The tool supports standard IUPAC nucleotide codes, including 'V'.
- **VCF Troubleshooting**: If you encounter the error "Couldn't get database name from vcf," you must provide the database name manually to the annotation script.

## Reference documentation
- [Sibelia GitHub Repository](./references/github_com_bioinf_Sibelia.md)
- [Bioconda Sibelia Package](./references/anaconda_org_channels_bioconda_packages_sibelia_overview.md)