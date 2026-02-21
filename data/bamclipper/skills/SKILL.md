---
name: bamclipper
description: bamclipper is a specialized utility designed to remove gene-specific primer sequences from SAM/BAM alignments of PCR amplicons.
homepage: https://github.com/tommyau/bamclipper
---

# bamclipper

## Overview

bamclipper is a specialized utility designed to remove gene-specific primer sequences from SAM/BAM alignments of PCR amplicons. It operates by soft-clipping the ends of reads that overlap with known primer locations. Unlike tools that require sequence matching, bamclipper uses genomic coordinates from a primer manifest (BEDPE format) to determine clipping boundaries. This approach is faster and more robust against sequencing errors within the primer regions themselves.

## Core Workflow

### Basic Execution
To clip primers from an indexed BAM file, provide the BAM path and the primer pair locations in BEDPE format.

```bash
./bamclipper.sh -b input.bam -p primers.bedpe
```

The tool generates a new file named `input.primerclipped.bam` and its associated index in the current working directory.

### Performance Optimization
Use the `-n` flag to specify the number of threads for the underlying Perl workhorse and SAMtools sort operations.

```bash
./bamclipper.sh -b input.bam -p primers.bedpe -n 8
```

### Handling Non-Standard Environments
If `samtools` or `parallel` are not in your PATH, specify their locations directly:

```bash
./bamclipper.sh -b input.bam -p primers.bedpe -s /path/to/samtools -g /path/to/parallel
```

## Advanced Configuration

### Tuning Primer Assignment
bamclipper assigns alignments to primers based on their starting positions. You can adjust the search window if your alignments don't perfectly align with the primer start:

- `-u INT`: Nucleotides upstream to the 5' most nucleotide of the primer (Default: 1).
- `-d INT`: Nucleotides downstream to the 5' most nucleotide of the primer (Default: 5).

```bash
# Increase downstream search window for less precise alignments
./bamclipper.sh -b input.bam -p primers.bedpe -d 10
```

## Best Practices and Requirements

- **Indexing**: The input BAM file must be indexed (`.bai` file present).
- **Coordinate Consistency**: Ensure that the BAM file and the BEDPE file use the same reference genome (e.g., both hg19 or both GRCh38).
- **BEDPE Format**: The primer file must be in a 6-column BEDPE format representing the primer pair locations.
  - Example line: `chr20 31022896 31022921 chr20 31023096 31023123`
- **Validation**: After clipping, you can verify the integrity of the output by comparing the MD5 checksum of the alignments (excluding headers) against known controls if available.

## Reference documentation
- [BAMClipper GitHub Repository](./references/github_com_tommyau_bamclipper.md)
- [Bioconda bamclipper Overview](./references/anaconda_org_channels_bioconda_packages_bamclipper_overview.md)