---
name: platypus-variant
description: "Platypus is a haplotype-based tool designed for efficient and accurate variant detection and joint-calling across multiple samples. Use when user asks to call variants from BAM files, perform joint-calling on multiple samples, or detect complex genomic variations using local assembly."
homepage: http://www.well.ox.ac.uk/platypus
---


# platypus-variant

## Overview
Platypus is a tool designed for efficient and accurate variant detection using a haplotype-based approach. Unlike position-by-position callers, it integrates mapping and assembly information to resolve complex variation in a local window. It is particularly effective for joint-calling multiple samples simultaneously, which improves the precision of shared variant detection and helps filter out low-quality candidates.

## Core Usage Patterns

### Basic Variant Calling
To call variants on a single or multiple BAM files using default parameters:
```bash
python Platypus.py callVariants --bamFiles=input.bam --refFile=ref.fa --output=out.vcf
```

### Joint Calling (Multi-sample)
Provide a comma-separated list of BAMs or a text file containing paths to BAMs (one per line). Joint calling is recommended for cohorts to improve power:
```bash
python Platypus.py callVariants --bamFiles=sample1.bam,sample2.bam,sample3.bam --refFile=ref.fa --output=cohort.vcf
```

### Calling in Specific Regions
Use the `--regions` flag to restrict calling to specific chromosomes or genomic coordinates (BED format or `chr:start-end`):
```bash
python Platypus.py callVariants --bamFiles=input.bam --refFile=ref.fa --output=out.vcf --regions=chr1:100000-200000
```

## Expert Tips and Best Practices

- **Haplotype Integration**: Platypus can integrate variants from other callers (e.g., GATK, Scalpel) to use as candidates for its haplotype model. Use `--source=other_variants.vcf` to provide these candidates.
- **Filtering**: By default, Platypus applies several filters (e.g., `QualDepth`, `REFCALL`). To see all variants including those that failed filters, check the VCF `FILTER` column. Use `--filterDuplicates=1` if your library prep didn't include UMI-based deduplication.
- **Large Cohorts**: For very large numbers of samples, use the `--bamIndex` option to speed up access, and consider parallelizing by chromosome using the `--regions` flag across multiple processes.
- **Indel Sensitivity**: If you are looking for larger indels, increase the `--maxHaplotypes` parameter, though this will increase computational cost.
- **Assembly Mode**: In regions of high complexity, Platypus can perform local assembly. Ensure `--assemble=1` is active (default) for best results in repetitive or highly polymorphic regions.

## Reference documentation
- [Platypus Variant Caller Overview](./references/anaconda_org_channels_bioconda_packages_platypus-variant_overview.md)