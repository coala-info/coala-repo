---
name: sspace_basic
description: SSPACE Basic is a Perl-based tool that uses paired-read information to link genomic contigs into larger scaffolds. Use when user asks to scaffold pre-assembled contigs, extend contig ends using unmapped reads, or refine genomic assemblies using paired-end or mate-pair libraries.
homepage: https://github.com/nsoranzo/sspace_basic
metadata:
  docker_image: "biocontainers/sspace:v2.1.1dfsg-4-deb_cv1"
---

# sspace_basic

## Overview
SSPACE Basic (Scaffolding Pre-Assemblies After Contig Extension) is a Perl-based tool used to refine genomic assemblies. It automates the process of using paired-read information to link existing contigs into larger scaffolds. The tool can operate in two primary modes: simple scaffolding of existing sequences or a combined approach that first attempts to extend contig ends using unmapped reads before performing the scaffolding step. It relies on Bowtie for read mapping and requires a specific library configuration file to define the relationships between read pairs.

## Library File Configuration
The library file (`-l`) is a mandatory text file where each line defines a read library. Each line must follow this format:
`library_name file1.fastq file2.fastq insert_size error_margin orientation`

*   **insert_size**: The expected distance between the outer ends of the pairs.
*   **error_margin**: The allowed variance in insert size (e.g., 0.25 for 25%).
*   **orientation**: Use `FR` (forward-reverse), `RF` (reverse-forward), or `FF` (forward-forward).

## Common CLI Patterns

### Basic Scaffolding
To scaffold contigs without attempting sequence extension:
`perl SSPACE_Basic.pl -l libraries.txt -s contigs.fasta -x 0 -b assembly_output`

### Scaffolding with Contig Extension
To attempt to close gaps by extending contigs using unmapped reads before scaffolding:
`perl SSPACE_Basic.pl -l libraries.txt -s contigs.fasta -x 1 -m 32 -o 20 -b extended_output`

### High-Stringency Scaffolding
To increase the reliability of scaffolds in complex genomes, increase the minimum number of links required:
`perl SSPACE_Basic.pl -l libraries.txt -s contigs.fasta -k 10 -a 0.5`

## Parameter Optimization
*   **-k (Minimum links)**: Default is 5. Increase this (e.g., 10-15) to reduce chimeric scaffolds at the cost of lower continuity.
*   **-a (Link ratio)**: Default is 0.7. Lower values (e.g., 0.5) make the tool more conservative when multiple contig pairing possibilities exist.
*   **-n (Overlap)**: Minimum overlap required to merge adjacent contigs. Default is 15bp.
*   **-x (Extension)**: Set to 1 to enable the SSAKE-based extension algorithm. This is memory-intensive.
*   **-g (Gaps)**: Maximum gaps allowed in Bowtie mapping. Increase for lower quality reads or non-model organisms.

## Expert Tips and Constraints
*   **Memory Management**: SSPACE tracks all contigs in memory. For large datasets or high numbers of contigs, ensure the machine has significant RAM to avoid disk swapping.
*   **Dependencies**: Ensure `bowtie` and `bowtie-build` are in the system PATH. SSPACE will fail if it cannot invoke these binaries.
*   **Input Formats**: While the tool supports FASTA and FASTQ, ensure read names in paired files are consistent for proper tracking.
*   **454 Reads**: Contig extension (`-x 1`) is generally not recommended for 454-style reads due to homopolymer-related indel errors which interfere with the extension algorithm.
*   **Visualization**: Use `-p 1` to generate a `.dot` file, which can be converted to an image (using Graphviz) to visualize the scaffold connections.

## Reference documentation
- [SSPACE Basic Overview](./references/anaconda_org_channels_bioconda_packages_sspace_basic_overview.md)
- [SSPACE Basic GitHub Repository](./references/github_com_nsoranzo_sspace_basic.md)