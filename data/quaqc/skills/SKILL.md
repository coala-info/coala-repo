---
name: quaqc
description: quaqc is a high-performance utility for processing ATAC-seq data to generate quality control metrics, filter reads, and prepare data for downstream analysis. Use when user asks to generate QC reports, create Tn5-adjusted BED or bedGraph files, quantify reads in peaks, or filter single-cell BAM files by barcode.
homepage: https://github.com/bjmt/quaqc
---


# quaqc

## Overview
The `quaqc` tool is a high-performance C-based utility designed for the rapid processing of ATAC-seq data. It serves as an all-in-one solution for generating quality control metrics, filtering reads based on mapping quality or genomic regions, and preparing data for downstream analysis (such as peak calling with MACS2/3). It is uniquely compatible with plant genomes and supports both bulk and single-cell ATAC-seq workflows.

## Common CLI Patterns

### Standard QC Report Generation
To generate a comprehensive QC report including TSS enrichment and peak overlap stats:
```bash
quaqc -v --output-dir ./qc_results \
  --peaks peaks.bed \
  --tss tss.bed \
  sample.bam
```

### Preparing Reads for MACS2/3 (Tn5 Insertion Sites)
To create a BED file containing only the 5-prime insertion sites (saving space while maintaining accuracy for peak calling):
```bash
quaqc -0 --bed --bed-ins sample.bam
```

### Quantification of Reads in Peaks
Count reads overlapping peaks while applying filters and adjusting for Tn5 transposition offset in a single step:
```bash
quaqc -0 --peaks peaks.bed \
  --quant counts.tsv \
  --quant-ins --quant-tn5 \
  sample.bam
```

### Generating Shifted bedGraph Files
Create a bedGraph file centered on transposition sites, adjusted for the +4/-5 bp Tn5 shift:
```bash
quaqc --bedGraph --bedGraph-tn5 --bedGraph-qlen 1 sample.bam
```

### Single-Cell BAM Subsetting
Filter a single-cell ATAC-seq BAM file to keep only specific barcodes (stored in the `CB` tag):
```bash
quaqc -0 -A --rg-list barcodes.txt --rg-tag CB --keep --keep-ext .filtered.bam sample.bam
```

## Expert Tips and Best Practices

- **Fast Iteration**: When testing different filtering parameters (like MAPQ thresholds), use `-n` or `--target-names` to restrict processing to a single small chromosome (e.g., `-n chr1`). This provides a representative sample of the data quality in seconds rather than minutes.
- **Filtering without QC**: Use the `-0` flag to suppress the generation of the text QC report when you only need the tool for its side effects, such as generating a filtered BAM (`--keep`) or a quantification table (`--quant`).
- **Memory Efficiency**: `quaqc` is designed to be faster than many Python or R-based alternatives. When working with very large datasets, prefer the `--bed-ins` flag over standard `--bed` to reduce the disk I/O and storage footprint of intermediate files.
- **Tn5 Adjustments**: Always use `--quant-tn5` or `--bedGraph-tn5` when your downstream analysis relies on exact transposition sites rather than whole fragment overlaps. You can customize these shifts using `--tn5-fwd` and `--tn5-rev` if using non-standard library preps.
- **Target Lists**: For experiments where only specific genomic regions were sequenced (e.g., targeted enrichment), provide a `--target-list` BED file. This ensures that QC statistics like "reads in peaks" are normalized correctly against the sequenced space rather than the whole genome.

## Reference documentation
- [quaqc GitHub Repository](./references/github_com_bjmt_quaqc.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_quaqc_overview.md)