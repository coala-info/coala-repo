---
name: pbmarkdup
description: `pbmarkdup` is a reference-free tool designed specifically for PacBio HiFi (CCS) reads.
homepage: https://github.com/PacificBiosciences/pbmarkdup
---

# pbmarkdup

## Overview

`pbmarkdup` is a reference-free tool designed specifically for PacBio HiFi (CCS) reads. It identifies reads that originate from the same DNA molecule—typically resulting from PCR amplification—using a hierarchical comparison workflow that involves minimizers and alignment of read ends. This tool is critical for amplicon sequencing or any workflow involving library amplification where duplicate reads can skew quantitative results or variant calling.

## CLI Usage and Patterns

### Basic Duplicate Marking
By default, `pbmarkdup` marks duplicates in the output file without removing them.
```bash
pbmarkdup input.ccs.bam output.marked.bam
```

### Removing Duplicates
To produce a "clean" file containing only unique representative reads, use the `--rmdup` flag.
```bash
pbmarkdup --rmdup input.ccs.bam output.unique.bam
```

### Handling Multiple Input Files
You can provide multiple input files (BAM, FASTQ, or FASTA) to a single output file.
```bash
pbmarkdup movie1.ccs.bam movie2.ccs.bam combined.marked.bam
```

### Separating Duplicates into a Different File
To keep unique reads in one file and duplicates in another for inspection:
```bash
pbmarkdup input.ccs.bam unique.bam --dup-file duplicates.bam
```

### Cross-Library Deduplication
By default, `pbmarkdup` respects library boundaries (the `@RG` LB tag in BAM). To mark duplicates across different libraries, use:
```bash
pbmarkdup --cross-library input1.bam input2.bam output.bam
```

## Expert Tips and Best Practices

- **HiFi Only**: Do not use `pbmarkdup` on CLR (Continuous Long Read) data. It is optimized specifically for the high accuracy of HiFi reads.
- **Memory Management**: The tool is designed for a low memory footprint by reading input files twice. This allows it to process large datasets (e.g., 20x human) on standard servers by only storing read ends and thinned minimizers in memory.
- **Summary Statistics**: Always use `--log-level INFO` to generate a summary table. This provides a breakdown of unique vs. duplicate reads per library, which is vital for QC.
- **Input/Output Compatibility**: 
    - If the input is FASTQ/FASTA, the output can be FASTQ/FASTA.
    - If the input is BAM/Dataset, the output can be BAM, Dataset, or FASTX.
    - Note: You cannot output a BAM file if the input is only FASTX, as metadata required for BAM (like Read Groups) will be missing.
- **Duplicate Identification**:
    - In **BAM**, duplicates are marked with the `ds:i` tag (number of reads for that molecule) and the `du:Z` tag (name of the representative read).
    - In **FASTX**, duplicates are identified in the header with `DUPLICATE=[representative_read_name]` and `DS=[count]`.

## Reference documentation
- [pbmarkdup README](./references/github_com_PacificBiosciences_pbmarkdup_blob_master_README.md)