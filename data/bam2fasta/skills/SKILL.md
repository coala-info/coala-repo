---
name: bam2fasta
description: The `bam2fasta` tool is a specialized utility designed to bridge the gap between alignment data (BAM) and sequence-based analysis (FASTA).
homepage: https://github.com/czbiohub/bam2fasta
---

# bam2fasta

## Overview
The `bam2fasta` tool is a specialized utility designed to bridge the gap between alignment data (BAM) and sequence-based analysis (FASTA). It is optimized for handling large-scale genomic data, particularly single-cell datasets where sequences need to be demultiplexed or extracted based on cellular barcodes. Use this skill to generate command-line strings for sequence extraction, handle barcode-specific filtering, and manage high-throughput conversion workflows.

## Usage Patterns

### Basic Conversion
To convert an entire BAM file to FASTA format:
```bash
bam2fasta info --filename input.bam --output_dir ./output_fastas
```

### Single-Cell Barcode Extraction
`bam2fasta` is frequently used to extract sequences associated with specific cell barcodes.
- **Using a barcode list**: Provide a text file containing the barcodes of interest.
- **Filtering by count**: Extract sequences only for barcodes that meet a specific read count threshold.

### Common CLI Arguments
- `--filename`: Path to the input BAM file.
- `--output_dir`: Directory where the resulting FASTA files will be saved.
- `--min_barcode_count`: Minimum number of reads required for a barcode to be processed.
- `--shard_size`: Useful for parallel processing; defines the number of reads per shard.

## Best Practices
- **Index your BAM**: Ensure your input BAM file is indexed (`.bai` file present) to allow the tool to navigate the genomic coordinates efficiently.
- **Memory Management**: When dealing with massive single-cell experiments, use the `--shard_size` parameter to prevent memory exhaustion by processing the file in chunks.
- **Output Organization**: The tool creates multiple files based on barcodes; always specify a dedicated `--output_dir` to avoid cluttering your working directory.

## Reference documentation
- [bam2fasta Overview](./references/anaconda_org_channels_bioconda_packages_bam2fasta_overview.md)