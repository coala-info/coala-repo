name: alignstats
description: Use when needing to generate comprehensive alignment, whole-genome coverage, or capture coverage statistics from SAM, BAM, or CRAM files. This skill is essential for quality control (QC) reporting in sequencing analysis pipelines.

# alignstats

`alignstats` produces metrics for sequence alignment files. It is specifically designed for reporting and QC in high-throughput sequencing workflows.

## Core Requirements

- **Input Format**: SAM, BAM, or CRAM.
- **Sorting**: Input files **must** be coordinate-sorted for accurate results.
- **Indexing**: Required if using the `-r` (regions) option.
- **CRAM Support**: Requires the reference FASTA file via the `-T` option.

## Common CLI Patterns

### Basic Alignment & WGS Statistics
Generate standard alignment and whole-genome coverage metrics:
```bash
alignstats -i sample.bam -o report.txt
```

### Targeted/Exome Capture Statistics
Use a target BED file to calculate capture-specific metrics (e.g., on-target percentage, fold enrichment):
```bash
alignstats -i sample.bam -t targets.bed -o report.txt
```

### High-Performance Execution
Enable multithreading for faster processing of large files:
```bash
alignstats -p -P 4 -i sample.bam -o report.txt
```
- `-p`: Enables separate threads for reading and processing.
- `-P [INT]`: Sets the number of HTSlib decompression threads.

### Filtered Analysis
Process only high-quality, non-duplicate reads:
```bash
alignstats -q 20 -F 1024 -i sample.bam -o report.txt
```
- `-q 20`: Minimum mapping quality of 20.
- `-F 1024`: Exclude reads with the "duplicate" bit set in the FLAG.

## Expert Tips

- **Masking N-Regions**: Use `-m mask.bed` to provide a BED file of reference regions containing N bases. This prevents these regions from artificially depressing coverage statistics.
- **Processing Specific Regions**: Use `-r regions.bed` to limit analysis to specific genomic intervals. This requires the input file to be indexed (`.bai` or `.crai`).
- **Disabling Metrics**: To reduce runtime or output clutter, disable unwanted reporting modules:
  - `-A`: Disable alignment statistics.
  - `-C`: Disable capture coverage statistics.
  - `-W`: Disable whole genome coverage statistics.
- **Duplicate Handling**: By default, `alignstats` excludes duplicate reads from coverage statistics. Use `-D` to include them if needed for specific library complexity analyses.
- **Memory Management**: If working with extremely dense alignments, use `-n [INT]` to adjust the maximum number of records kept in memory (default is usually sufficient for standard pipelines).