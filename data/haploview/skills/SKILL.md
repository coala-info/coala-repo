---
name: haploview
description: Haploview is a bioinformatics tool used for the analysis and visualization of linkage disequilibrium and haplotype maps. Use when user asks to calculate LD statistics, perform haplotype block partitioning, select tag SNPs, or conduct genetic association testing and Hardy-Weinberg equilibrium filtering.
homepage: https://www.broadinstitute.org/haploview/haploview
---


# haploview

## Overview
Haploview is a specialized bioinformatics tool for the analysis and visualization of LD and haplotype maps. It bridges the gap between raw genotype data and statistical association by providing robust methods for block partitioning and SNP tagging. Use this skill to streamline the transition from whole-genome association results (PLINK) to fine-mapped haplotype analysis, or when you need to calculate Hardy-Weinberg equilibrium (HWE) and permutation-based significance for genetic variants.

## Command Line Usage and Best Practices

### Core Execution
Haploview is a Java-based application. For large-scale datasets (tens of thousands of SNPs), always use the command line mode to bypass GUI memory overhead.

```bash
# Basic execution
java -jar Haploview.jar -n -pedfile [data.ped] -info [data.info] [options]
```

### Common CLI Patterns
- **LD Analysis**: Generate LD statistics without the GUI using the `-n` (nogui) flag.
  - `-dprime`: Outputs D' and r^2 values to a file.
  - `-png`: Generates an LD plot image directly.
- **Haplotype Block Partitioning**: Specify the algorithm for block definition.
  - `-blockoutput [GAB|GAM|SPI|ALL]`: Choose between Gabriel (GAB), 4-gamete (GAM), or Solid Spine (SPI) methods.
- **Tagger (Tag SNP Selection)**:
  - `-tagger`: Runs the Tagger algorithm to find a minimal set of SNPs.
  - `-tagrsqcutoff [0.8]`: Sets the r^2 threshold for tagging.
- **Association Testing**:
  - `-assoc`: Performs single SNP and haplotype association tests.
  - `-permtest [number]`: Runs permutation tests (e.g., 1000) to determine empirical significance.

### Data Input Requirements
- **Standard Format**: Requires a `.ped` file (Linkage format) and a `.info` file (Marker names and positions).
- **HapMap Data**: Use `-hapmap [file]` for phased data or `-phased` for pre-phased inputs.
- **PLINK Integration**: Use `-plink [file]` to load whole-genome results for visualization and filtering.

### Expert Tips
- **Memory Management**: For large datasets, increase the Java heap size using `-Xmx` (e.g., `java -Xmx2G -jar Haploview.jar ...`).
- **HWE Filtering**: Use `-hwcutoff [p-value]` to automatically exclude markers failing Hardy-Weinberg equilibrium during analysis.
- **Batch Processing**: When analyzing multiple regions, use the `-batch [file]` option to process a list of files sequentially.
- **Missing Data**: Use `-maxmissing [fraction]` to filter out SNPs with high rates of missing genotypes (e.g., 0.2 for 20% missing).

## Reference documentation
- [Haploview Overview](./references/www_broadinstitute_org_haploview_haploview.md)
- [Bioconda Package Info](./references/anaconda_org_channels_bioconda_packages_haploview_overview.md)