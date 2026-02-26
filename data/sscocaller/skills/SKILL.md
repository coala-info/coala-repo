---
name: sscocaller
description: sscocaller performs haplotyping and identifies crossover locations in single-cell gamete sequencing data by analyzing allelic counts at known SNP positions. Use when user asks to call haplotypes from single-cell or bulk BAM files, identify crossover events in gametes, or filter SNP sites by depth.
homepage: https://gitlab.svi.edu.au/biocellgen-public/sscocaller
---


# sscocaller

## Overview
sscocaller is a specialized bioinformatics tool designed to handle the unique challenges of single-cell gamete sequencing. It performs haplotyping by analyzing allelic counts at known SNP positions across multiple single cells. The tool is particularly effective for identifying crossover locations and segregating maternal/paternal haplotypes in haploid cells. It supports both single-cell barcodes and bulk sample analysis, making it versatile for various gamete-based genomic studies.

## Installation and Setup
Install sscocaller via the bioconda channel:
```bash
conda install -c bioconda sscocaller
```

## Common CLI Patterns

### Single-Cell Haplotyping
To call haplotypes from a single-cell BAM file using a list of known SNPs:
```bash
sscocaller -b input.bam -v snps.vcf -o output_dir --cellbarcode CB
```
*   `-b`: Input BAM file (indexed).
*   `-v`: VCF file containing known heterozygous SNPs from the donor.
*   `--cellbarcode`: The BAM tag containing the cell barcode (e.g., `CB` or `CR`).

### Bulk Sample Support
For processing bulk DNA samples or non-barcoded data:
```bash
sscocaller -b bulk.bam -v snps.vcf -o output_dir --bulk
```

### Filtering and Quality Control
Refine results by setting depth thresholds to ignore low-confidence sites:
```bash
sscocaller -b input.bam -v snps.vcf -o output_dir --minTotalDP 2 --maxTotalDP 100
```
*   `--minTotalDP`: Minimum total depth required at a SNP position to be considered.
*   `--maxTotalDP`: Maximum depth allowed (useful for filtering repetitive regions or mapping artifacts).

## Best Practices
- **Input Preparation**: Ensure the input BAM file is sorted and indexed (`samtools index`).
- **SNP Selection**: Use a high-quality VCF of heterozygous SNPs derived from the same individual's diploid tissue (e.g., blood or skin) to serve as the scaffold for haplotyping.
- **Barcode Handling**: If working with 10x Genomics data, ensure the barcodes in the BAM file match the expected format (usually the `CB` tag).
- **Memory Management**: For large datasets with many cells, monitor memory usage as the tool builds a barcode table in memory.

## Reference documentation
- [sscocaller README](./references/gitlab_svi_edu_au_biocellgen-public_sscocaller_-_blob_master_README.md)
- [sscocaller Overview](./references/anaconda_org_channels_bioconda_packages_sscocaller_overview.md)