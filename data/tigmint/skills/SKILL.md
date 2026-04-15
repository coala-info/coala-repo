---
name: tigmint
description: Tigmint improves genome assembly structural accuracy by identifying and cutting misassemblies based on read coverage drops. Use when user asks to correct genome assembly misassemblies, correct assembly with linked reads, correct assembly with long reads, or scaffold corrected assembly.
homepage: https://bcgsc.github.io/tigmint/
metadata:
  docker_image: "quay.io/biocontainers/tigmint:1.2.10--py39h475c85d_4"
---

# tigmint

## Overview
Tigmint is a tool designed to improve the structural accuracy of genome assemblies. It works by aligning sequencing reads that represent long DNA molecules to a draft assembly and identifying regions where the physical coverage of these molecules drops significantly. These drops often indicate misassemblies (e.g., chimeric joins). Tigmint cuts the assembly at these low-support positions, producing a more fragmented but more accurate set of sequences. This skill provides the necessary command patterns for running the `tigmint-make` pipeline, which automates the alignment, molecule inference, and cutting steps.

## Core CLI Usage
The primary interface is `tigmint-make`, a wrapper around a Makefile pipeline.

### Correcting with Linked Reads
Use this for 10x Genomics or similar barcoded short-read data.
```bash
tigmint-make tigmint draft=[prefix] reads=[prefix]
```
*   **Requirement**: The draft file must be `[prefix].fa` and reads must be `[prefix].fq.gz`.
*   **Note**: Do not include the file extensions in the command parameters.

### Correcting with Long Reads (ONT/PacBio)
Use this for Oxford Nanopore or PacBio reads.
```bash
tigmint-make tigmint-long draft=[prefix] reads=[prefix] G=[genome_size] span=auto dist=auto
```
*   **G**: Haploid genome size (e.g., `3e9` for human). Required for `span=auto`.
*   **longmap**: Specify platform if not ONT. Options: `ont` (default), `pb` (PacBio CLR), `hifi` (PacBio HiFi).
    *   Example: `tigmint-make tigmint-long ... longmap=hifi`

### Integrated Scaffolding
To run Tigmint and then immediately scaffold the corrected assembly using ARCS:
```bash
tigmint-make arcs draft=[prefix] reads=[prefix]
```

## Parameter Tuning and Best Practices
*   **Genome Size (G)**: Always provide the genome size when using long reads to allow Tigmint to calculate the optimal `span` (minimum spanning molecules) automatically.
*   **Spanning Molecules (span)**: If not using `auto`, the default is 20. This is highly coverage-dependent. For long reads, `span` should generally not exceed 1/4 of the total sequence coverage.
*   **Distance (dist)**: For `tigmint-long`, set `dist=auto` to calculate the maximum distance between reads based on the read length distribution.
*   **Thread Management**: Use the `t` parameter to specify CPU threads (default is 8).
    *   Example: `tigmint-make tigmint draft=my_asm reads=my_reads t=16`
*   **Dry Runs**: Since `tigmint-make` is Make-based, use `-n` to preview the commands without executing them.

## Data Preparation Tips
*   **stLFR Reads**: These must be reformatted so the barcode is in the `BX:Z:` tag of the FASTQ header.
*   **Linked Read Alignment**: If aligning manually before running Tigmint, ensure BWA-MEM is used with the `-C` flag to carry the barcode into the SAM tags, and sort the BAM file by barcode using `samtools sort -tBX`.
*   **File Extensions**: Tigmint is strict about extensions due to its Makefile backend. Ensure draft assemblies end in `.fa` (not `.fasta`).

## Reference documentation
- [Tigmint GitHub Documentation](./references/bcgsc_github_io_tigmint.md)
- [Tigmint Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tigmint_overview.md)