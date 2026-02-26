---
name: bxtools
description: bxtools is a suite of command-line utilities for barcode-aware processing and analysis of 10X Genomics data. Use when user asks to generate barcode statistics, split BAM files by barcode, calculate molecular footprints, or tile read counts across genomic windows.
homepage: https://github.com/walaj/bxtools
---


# bxtools

## Overview

bxtools is a specialized suite of command-line utilities designed for "barcode-aware" processing of 10X Genomics data. While standard bioinformatics tools typically operate on genomic coordinates, bxtools focuses on the BX (barcode) and MI (molecular identifier) tags. It is essential for workflows requiring barcode-level quality control, splitting BAM files by individual barcodes, or calculating the physical genomic footprint of linked reads.

## Core CLI Operations

### Barcode Statistics and Filtering
Use `stats` to generate a summary of read metrics grouped by barcode.
- **Basic stats**: `bxtools stats input.bam > stats.tsv`
- **Custom tags**: To summarize by a different tag (e.g., MI), use `bxtools stats -t MI input.bam`.
- **Output columns**: The resulting TSV includes BX, read count, median insert size, median MAPQ, and median Alignment Score (AS).

### Splitting BAM Files
The `split` command separates a single BAM into multiple files based on the BX tag.
- **Standard split**: `bxtools split input.bam -a output_prefix -m 10` (The `-m` flag ignores barcodes with fewer than 10 reads to prevent file bloat).
- **Count only**: Use `-x` to output a list of BX tags and their frequencies without creating new BAM files: `bxtools split input.bam -x | sort -n -k 2,2`.

### Molecular Footprinting
The `mol` command calculates the genomic span (minimum start to maximum end) for all reads sharing an `MI` tag.
- **Usage**: `bxtools mol input.bam > footprint.bed`
- **Output**: A BED file containing `chr, start, end, MI, BX, read_count`. This is useful for visualizing the physical extent of linked-read molecules.

### Tiling and Coverage
Use `tile` to calculate barcode-level read counts across genomic windows.
- **Default (1kb bins)**: `bxtools tile input.bam > coverage.bed`
- **Custom bins**: Use `-w` to specify window size (e.g., `-w 2000` for 2kb).
- **Targeted regions**: Pipe a specific region from samtools: `samtools view -h input.bam chr1:1-1000000 | bxtools tile - > region.bed`.

## Expert Workflows

### Rapid Barcode Lookup (The "Convert" Hack)
Standard BAMs are indexed by coordinate, making it slow to retrieve all reads for a specific barcode. bxtools can "swap" the chromosome ID with the BX tag to allow indexing by barcode.
1. **Convert**: `bxtools convert input.bam > bx_swapped.bam`
2. **Sort**: `samtools sort bx_swapped.bam -o bx_sorted.bam`
3. **Index**: `samtools index bx_sorted.bam`
4. **Query**: `samtools view bx_sorted.bam [BARCODE_STRING]`

### Filtering Low-Frequency Barcodes
To improve signal-to-noise ratios, filter out barcodes with low read counts before downstream analysis:
```bash
# 1. Identify "bad" tags with < 100 reads
bxtools split input.bam -x | awk '$2 < 100' | cut -f1 > excluded_tags.txt

# 2. Filter the BAM using grep on the header-less stream
samtools view -h input.bam | grep -v -F -f excluded_tags.txt | bxtools tile - > filtered_coverage.bed
```

## Best Practices
- **Piping**: Most bxtools commands accept `-` as input to read from stdin, allowing integration with `samtools view`.
- **Memory Management**: When using `split`, always use the `-m` threshold to avoid creating thousands of tiny BAM files for sequencing artifacts or low-quality barcodes.
- **Read Names**: If you need to use tools that aren't BX-tag aware, use `bxtools relabel` to move the barcode string into the read name (QNAME).

## Reference documentation
- [bxtools GitHub Repository](./references/github_com_walaj_bxtools.md)
- [Bioconda bxtools Overview](./references/anaconda_org_channels_bioconda_packages_bxtools_overview.md)