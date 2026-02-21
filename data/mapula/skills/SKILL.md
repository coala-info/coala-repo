---
name: mapula
description: Mapula is a specialized utility for extracting and summarizing performance metrics from sequence alignments.
homepage: https://github.com/epi2me-labs/mapula
---

# mapula

## Overview
Mapula is a specialized utility for extracting and summarizing performance metrics from sequence alignments. It transforms raw alignment data (BAM/SAM) into actionable statistics, allowing researchers to assess the quality of sequencing runs, verify mapping accuracy, and understand read characteristics. It is particularly effective for long-read sequencing analysis where detailed per-read statistics are required.

## Usage Guidelines

### Basic Command Structure
The primary interface for mapula is the command line. The most common workflow involves passing a sorted BAM file to the tool:

```bash
mapula [options] <input.bam>
```

### Common CLI Patterns
- **Generate Statistics**: To output a summary of alignment metrics to the console or a file.
- **Filtering**: Use flags to filter alignments based on quality scores or minimum read lengths to ensure statistics are not skewed by low-quality data.
- **Output Redirection**: Since mapula often produces tabular data, redirect output to a `.tsv` or `.csv` for downstream analysis:
  ```bash
  mapula input.bam > alignment_stats.tsv
  ```

### Expert Tips
- **Pre-sorting**: Ensure your BAM file is indexed and sorted by coordinate using `samtools sort` before running mapula to ensure optimal performance.
- **ONT Data**: When working with Oxford Nanopore data, mapula is often used to calculate "identity" or "accuracy" metrics which differ from standard short-read tools; pay close attention to how it handles insertions and deletions (indels) in the accuracy calculation.
- **Integration**: Mapula is frequently used as a precursor to visualization tools. Use the generated statistics to create histograms of read lengths or heatmaps of coverage.

## Reference documentation
- [mapula - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_mapula_overview.md)