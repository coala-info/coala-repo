---
name: snp-pileup
description: The snp-pileup tool extracts nucleotide counts from BAM files at specific genomic coordinates to generate input for FACETS copy number analysis. Use when user asks to extract allele counts from BAM files, prepare data for FACETS, or summarize SNP pileups from tumor and normal sequencing samples.
homepage: https://github.com/mskcc/facets
metadata:
  docker_image: "quay.io/biocontainers/snp-pileup:0.6.2--h503566f_8"
---

# snp-pileup

## Overview
The `snp-pileup` tool is a C++ utility designed to efficiently extract nucleotide counts from one or more BAM files at specific genomic coordinates provided in a VCF file. Its primary purpose is to generate the input matrix required by the FACETS (Fraction and Allele-specific Copy number Estimate from Tumor/normal Sequencing) R package. It handles the heavy lifting of parsing alignment files and summarizing allele counts, which is a prerequisite for downstream copy number variation (CNV) analysis.

## Usage Instructions

### Basic Command Syntax
The standard usage requires a VCF file of known SNP positions, an output filename, and one or more BAM files (typically a matched normal and tumor pair).

```bash
snp-pileup [options] <vcf_file> <output_file> <bam_file1> <bam_file2> ...
```

### Common CLI Patterns
*   **Standard FACETS Pre-processing**: Use a matched normal and tumor BAM.
    ```bash
    snp-pileup -g -q15 -Q20 -P100 -r25,0 common_snps.vcf output.gz normal.bam tumor.bam
    ```
*   **Multi-region/Multi-sample**: You can include multiple tumor samples against a single normal.
    ```bash
    snp-pileup [options] snps.vcf output.gz normal.bam tumor1.bam tumor2.bam
    ```

### Key Parameter Best Practices
*   **Filtering Quality (`-q`, `-Q`)**: 
    *   Use `-q` (minimum mapping quality) to ignore poorly mapped reads (standard: 15-20).
    *   Use `-Q` (minimum base quality) to ignore low-quality sequencing calls (standard: 20).
*   **Read Depth Control (`-r`)**: 
    *   The `-r <min_reads>,<max_reads>` flag is critical. Setting a minimum (e.g., 25) ensures enough power for allele-specific analysis, while a maximum (or 0 for no limit) prevents artifacts in ultra-high depth regions.
*   **Output Compression (`-g`)**: Always use the `-g` flag to produce a gzipped CSV, as the raw pileup files can be very large.
*   **Pseudo-autosomal Regions (`-p`)**: Use this flag if you need to handle the X chromosome specifically for sex-matched analysis.

### Expert Tips
*   **VCF Selection**: For human data, use a VCF of common SNPs (e.g., from dbSNP or 1000 Genomes) with a high Minor Allele Frequency (MAF > 0.05). This increases the likelihood of finding heterozygous SNPs in the normal sample, which are essential for allele-specific copy number estimation.
*   **Memory Management**: `snp-pileup` is generally memory-efficient as it streams through the BAM files, but ensure your BAM files are indexed (`.bai` files must exist in the same directory).
*   **FACETS Compatibility**: The output of `snp-pileup` is a comma-separated file. In R, this is loaded using `facets::readSnpMatrix()`. Ensure the order of BAM files in the command line matches your expectations in the R script (usually Normal followed by Tumor).

## Reference documentation
- [snp-pileup - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_snp-pileup_overview.md)
- [GitHub - mskcc/facets: Algorithm to implement Fraction and Copy number Estimate from Tumor/normal Sequencing](./references/github_com_mskcc_facets.md)