---
name: bamsnap
description: Bamsnap is a specialized command-line utility designed to convert genomic data from BAM format into static PNG images.
homepage: https://github.com/danielmsk/bamsnap
---

# bamsnap

## Overview
Bamsnap is a specialized command-line utility designed to convert genomic data from BAM format into static PNG images. It is particularly useful for automated reporting, rapid visual verification of variants, and creating figures for presentations or papers. Unlike interactive browsers, bamsnap provides a programmatic way to capture specific genomic regions with customizable tracks.

## Usage Patterns

### Basic Snapshot Generation
To generate a basic image for a specific region, use the following pattern:
```bash
bamsnap -bam input.bam -pos chr1:1234567 -out output.png
```

### Common CLI Arguments
- `-bam`: Path to the BAM file (index .bai file must be in the same directory).
- `-pos`: Genomic coordinates (e.g., `chr:start-end` or `chr:pos`).
- `-out`: Output filename (typically .png).
- `-ref`: Path to the reference FASTA file (optional, but recommended for showing base mismatches).
- `-gtf`: Path to a GTF/GFF file to display gene models and annotations.

### Expert Tips for Visualization
- **Coordinate Formatting**: Ensure chromosome names match the BAM header (e.g., "chr1" vs "1").
- **Read Filtering**: Use standard samtools-style filtering before running bamsnap if you need to exclude specific flags (like duplicates or secondary alignments) to keep the visualization clean.
- **Batch Processing**: For visualizing multiple variants, wrap the command in a bash loop or provide a list of positions to avoid manual execution for every site.
- **Gene Tracks**: Always provide a GTF file when visualizing coding regions to provide context for exons, introns, and strand orientation.

## Reference documentation
- [bamsnap Overview](./references/anaconda_org_channels_bioconda_packages_bamsnap_overview.md)