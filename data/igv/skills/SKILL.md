---
name: igv
description: IGV is a high-performance visualization tool for the interactive exploration and automated snapshot generation of large genomic datasets. Use when user asks to visualize sequencing alignments, inspect variants, navigate genomic loci, or generate automated image snapshots of specific regions.
homepage: http://www.broadinstitute.org/software/igv/home
---


# igv

## Overview
IGV is a high-performance visualization tool designed for the interactive exploration of large, integrated genomic datasets. It supports a wide range of data types and provides a fluid navigation experience across different scales, from whole-genome views to individual base pairs. This skill facilitates the setup and execution of IGV, particularly for researchers needing to validate variants, inspect sequencing alignments, or generate automated snapshots of specific genomic regions.

## Command Line Usage
IGV is typically launched as a desktop application, but it can be controlled via command-line arguments and batch scripts for automated visualization tasks.

### Launching IGV
To start IGV from the command line (assuming installation via bioconda):
```bash
igv
```

### Batch Mode
IGV can execute a series of commands automatically using a batch file. This is highly efficient for generating image snapshots of many genomic loci.
```bash
igv -b <script_file.txt>
```

### Common Batch Commands
Create a text file (e.g., `snapshots.txt`) with commands like these:
- `new`: Clear all data.
- `genome <genome_id_or_path>`: Load a specific genome (e.g., hg38).
- `load <file_path>`: Load a data track (BAM, VCF, etc.).
- `goto <locus>`: Navigate to a region (e.g., `chr1:10,000-11,000`).
- `snapshotDirectory <path>`: Set where images are saved.
- `snapshot <filename.png>`: Save the current view as an image.
- `exit`: Close IGV.

## Best Practices
- **Indexing**: Ensure all large genomic files (BAM, VCF, BCFTools-compressed files) are indexed (e.g., `.bai`, `.tbi`) and located in the same directory as the data file.
- **Memory Management**: For very large datasets, ensure the Java heap size is sufficient. If running manually via `java`, use the `-Xmx` flag (e.g., `java -Xmx4g -jar igv.jar`).
- **Remote Files**: IGV can load files via URL (HTTP/S3/GS), which is preferred for large datasets to avoid massive local downloads.
- **Genome Versions**: Always verify that the genome assembly loaded in IGV matches the assembly used to generate your data files to avoid coordinate mismatches.

## Reference documentation
- [IGV Overview](./references/anaconda_org_channels_bioconda_packages_igv_overview.md)