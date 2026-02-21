---
name: vcftools
description: VCFtools is a specialized suite designed for the analysis and manipulation of VCF and BCF files, commonly used in large-scale genomic projects like the 1000 Genomes Project.
homepage: https://github.com/vcftools/vcftools
---

# vcftools

## Overview
VCFtools is a specialized suite designed for the analysis and manipulation of VCF and BCF files, commonly used in large-scale genomic projects like the 1000 Genomes Project. It provides a high-performance C++ core for statistical calculations and a collection of Perl-based utilities for format management. Use this skill to streamline bioinformatic workflows involving variant call data, ensuring efficient data subsetting and rigorous quality control.

## Core CLI Usage Patterns

### Input and Output
VCFtools requires an explicit input type and an output prefix.
- **Uncompressed VCF**: `vcftools --vcf input.vcf --out output_prefix`
- **Compressed VCF**: `vcftools --gzvcf input.vcf.gz --out output_prefix`
- **Note**: Most commands generate an output file with a specific extension (e.g., `.frq`, `.log`, `.weir.fst`) based on the analysis requested.

### Common Filtering Operations
- **By Quality**: `--minQ 30` (Filters sites with a quality score below 30)
- **By Allele Frequency**: `--maf 0.05` (Includes only sites with a Minor Allele Frequency >= 0.05)
- **By Missing Data**: `--max-missing 0.95` (Excludes sites with more than 5% missing data)
- **By Genomic Region**: `--chr 1 --from-bp 1000000 --to-bp 2000000`
- **Using BED files**: `--bed coordinates.bed` (Includes only sites within the specified regions)

### Statistical Calculations
- **Nucleotide Diversity (Pi)**: 
  - Per-site: `vcftools --gzvcf input.vcf.gz --site-pi`
  - Sliding window: `vcftools --gzvcf input.vcf.gz --window-pi 10000 --window-pi-step 5000`
- **Population Differentiation (Fst)**:
  - `vcftools --gzvcf input.vcf.gz --weir-fst-pop pop1_inds.txt --weir-fst-pop pop2_inds.txt`
- **Allele Frequency**: `vcftools --gzvcf input.vcf.gz --freq`

## Perl Utility Scripts
VCFtools includes several "vcf-" prefixed scripts for specific tasks:
- **vcf-merge**: Combine multiple VCF files into one.
- **vcf-validator**: Check if a VCF file adheres to the official format specifications.
- **vcf-compare**: Compare two or more VCF files to find intersections and differences.
- **vcf-stats**: Generate general statistics about a VCF file.

## Expert Tips & Best Practices
1. **Always Check the Log**: VCFtools writes a `.log` file for every execution. This file contains critical information about how many individuals and sites were filtered out.
2. **Piping Data**: Use `--stdout` to pipe results to other tools (like `bgzip` or `bcftools`) to avoid creating large intermediate files.
3. **Memory Management**: For extremely large datasets, prefer using the C++ binary (`vcftools`) over the Perl scripts where possible, as it is generally more memory-efficient.
4. **Individual Filtering**: Use `--keep <file>` or `--remove <file>` with a list of sample IDs (one per line) to subset your data by individuals.

## Reference documentation
- [VCFtools GitHub Repository](./references/github_com_vcftools_vcftools.md)
- [Bioconda VCFtools Overview](./references/anaconda_org_channels_bioconda_packages_vcftools_overview.md)
- [VCFtools Issues and Flags](./references/github_com_vcftools_vcftools_issues.md)