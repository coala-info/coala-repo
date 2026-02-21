---
name: primerclip
description: Primerclip is a high-performance tool designed to trim primer sequences from aligned sequencing reads.
homepage: https://github.com/swiftbiosciences/primerclip
---

# primerclip

## Overview

Primerclip is a high-performance tool designed to trim primer sequences from aligned sequencing reads. Unlike traditional trimmers that rely on sequence matching, primerclip uses genomic intervals (coordinates) to identify and remove primers. This alignment-based approach significantly reduces processing time, especially for large targeted panels. It is primarily used with Swift Biosciences Accel-Amplicon panels but supports any workflow where primer coordinates are known in "master file" or BEDPE formats.

## Usage Instructions

### Core Workflow
Primerclip fits into the bioinformatics pipeline after alignment but before downstream analysis like variant calling:
1. **Alignment**: Align trimmed FASTQ files to a reference genome (e.g., `bwa mem`).
2. **Format Conversion**: Ensure the input is in SAM format (primerclip does not natively read BAM).
3. **Trimming**: Run primerclip using the panel-specific master file.
4. **Post-processing**: Convert the resulting SAM back to a sorted, indexed BAM.

### Command Line Patterns

**Paired-End Trimming (Default)**
```bash
primerclip masterfile.txt input_alignments.sam output_trimmed.sam
```

**Single-End Trimming**
Use the `-s` switch for single-read datasets:
```bash
primerclip -s masterfile.txt input_alignments.sam output_trimmed.sam
```

**Using BEDPE Format**
If a Swift master file is unavailable, use the `-b` or `--bedpe` switch with a BEDPE file containing primer coordinates:
```bash
primerclip -b primer_coordinates.bed input_alignments.sam output_trimmed.sam
```

### Expert Tips and Best Practices

*   **Input Sorting**: For paired-end data, ensure the SAM file is sorted by **queryname** (read name) rather than genomic position. Primerclip requires paired reads to be adjacent in the file to process them correctly.
*   **BAM Handling**: Since primerclip requires SAM input, use samtools to pipe data if you want to save disk space, though the tool's native interface expects file paths. 
    *   Convert BAM to SAM: `samtools view -h input.bam > input.sam`
*   **Chromosome Naming**: Ensure the chromosome names in your master/BEDPE file exactly match the headers in your SAM file (e.g., "chr1" vs "1").
*   **Panel Files**: Always use the specific master file provided by the manufacturer for the exact Accel-Amplicon panel used in the wet-lab protocol.
*   **Glibc Requirement**: If running the pre-compiled binary on older Linux systems, ensure `glibc` version 2.19 or higher is installed.

## Reference documentation
- [github_com_swiftbiosciences_primerclip.md](./references/github_com_swiftbiosciences_primerclip.md)
- [anaconda_org_channels_bioconda_packages_primerclip_overview.md](./references/anaconda_org_channels_bioconda_packages_primerclip_overview.md)