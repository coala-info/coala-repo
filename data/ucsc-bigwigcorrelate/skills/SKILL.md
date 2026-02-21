---
name: ucsc-bigwigcorrelate
description: `bigWigCorrelate` is a high-performance utility from the UCSC Genome Browser toolset used to determine how closely the signal levels in multiple bigWig files follow one another.
homepage: https://hgdownload.cse.ucsc.edu/admin/exe
---

# ucsc-bigwigcorrelate

## Overview
`bigWigCorrelate` is a high-performance utility from the UCSC Genome Browser toolset used to determine how closely the signal levels in multiple bigWig files follow one another. It computes a Pearson correlation coefficient, providing a numerical value between -1 and 1 to represent the linear relationship between data sets. This tool is essential for bioinformatics workflows requiring quality control of replicates or comparative analysis of different epigenetic marks.

## Usage Instructions

### Basic Correlation
To calculate the correlation between two bigWig files across the entire genome:
```bash
bigWigCorrelate file1.bw file2.bw
```
The output is a single floating-point number representing the Pearson correlation.

### Correlation Matrix
To compare multiple files simultaneously:
```bash
bigWigCorrelate file1.bw file2.bw file3.bw file4.bw
```
When three or more files are provided, the tool generates a correlation matrix.

### Restricting to Specific Regions
To calculate correlation only within specific genomic intervals (e.g., promoter regions or peak calls), use a BED file:
```bash
bigWigCorrelate -restrict=regions.bed file1.bw file2.bw
```
This is highly recommended for ChIP-seq data to avoid "diluting" the correlation score with background noise from non-peak regions.

## Expert Tips and Best Practices
- **Data Compatibility**: Ensure all input bigWig files are based on the same genome assembly (e.g., hg38 or mm10). The tool will fail or produce nonsensical results if chromosome names or lengths do not match.
- **Handling Zeros vs. Missing Data**: `bigWigCorrelate` typically processes only the regions where data exists. If one file has a value and the other is missing data for a specific coordinate, that coordinate is generally excluded from the calculation.
- **Performance**: Because bigWig files are indexed binary formats, this tool is extremely fast and memory-efficient, even for large mammalian genomes.
- **Permissions**: If running a freshly downloaded binary from the UCSC server, ensure it has execution permissions: `chmod +x bigWigCorrelate`.

## Reference documentation
- [Bioconda ucsc-bigwigcorrelate package overview](./references/anaconda_org_channels_bioconda_packages_ucsc-bigwigcorrelate_overview.md)
- [UCSC Admin Executables Directory](./references/hgdownload_cse_ucsc_edu_admin_exe.md)
- [UCSC Linux x86_64 Binary List](./references/hgdownload_cse_ucsc_edu_admin_exe_linux.x86_64.md)