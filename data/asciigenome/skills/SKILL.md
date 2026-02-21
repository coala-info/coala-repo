---
name: asciigenome
description: ASCIIGenome is a command-line genome browser that renders genomic tracks using ASCII characters.
homepage: https://github.com/dariober/ASCIIGenome
---

# asciigenome

## Overview
ASCIIGenome is a command-line genome browser that renders genomic tracks using ASCII characters. It provides a functional alternative to GUI-based browsers, allowing users to navigate chromosomes, search for motifs, and inspect read alignments without leaving the console. It is particularly effective for quick data verification on high-performance computing (HPC) clusters and remote environments.

## Installation and Setup
Install via Bioconda for the most stable environment:
```bash
conda install -c bioconda asciigenome
```

## Core CLI Usage
Launch the browser by passing one or more genomic files. You can mix local files and remote URLs.

```bash
# Open a BAM and a VCF file
ASCIIGenome sample.bam variants.vcf

# Open remote files
ASCIIGenome https://data.server.org/path/to/sample.bam
```

### Navigation Commands
Once inside the interactive session, use the following commands to move across the genome:
- `goto [region]`: Jump to a specific location (e.g., `goto chr1:1000-2000` or `goto gene_symbol`).
- `f` and `b`: Scroll forward and backward by the current window size.
- `zi` and `zo`: Zoom in and zoom out.
- `find [regex]`: Search for a sequence motif or feature attribute in the current track.

### Track Manipulation
- `rpm`: Toggle between raw read counts and Reads Per Million (normalization).
- `showSoftClip`: Toggle the visibility of soft-clipped bases in BAM/CRAM tracks.
- `trackHeight [int]`: Adjust the vertical space allocated to a specific track.
- `filter [expression]`: Apply filters to features (e.g., filter reads by mapping quality or specific flags).

## Expert Tips
- **Remote Efficiency**: Since it renders in ASCII, it is significantly faster than X11 forwarding for viewing large BAM files over slow connections.
- **Batch Processing**: Use the `-b` or `--batchFile` flag to pass a script of commands to ASCIIGenome for automated plotting or data extraction without user interaction.
- **Configuration**: Use `setConfig [key] [value]` to persist display preferences like colors or track defaults during a session.
- **BS-Seq Support**: The tool has native support for visualizing bisulfite sequencing alignments, showing methylation states in the context of the reference.

## Reference documentation
- [github_com_dariober_ASCIIGenome.md](./references/github_com_dariober_ASCIIGenome.md)
- [anaconda_org_channels_bioconda_packages_asciigenome_overview.md](./references/anaconda_org_channels_bioconda_packages_asciigenome_overview.md)
- [github_com_dariober_ASCIIGenome_issues.md](./references/github_com_dariober_ASCIIGenome_issues.md)