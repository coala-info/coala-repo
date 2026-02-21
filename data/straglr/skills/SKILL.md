---
name: straglr
description: Straglr is a bioinformatics tool designed to resolve tandem repeat (TR) expansions that are often too large or complex for short-read sequencing.
homepage: https://github.com/bcgsc/straglr
---

# straglr

## Overview
Straglr is a bioinformatics tool designed to resolve tandem repeat (TR) expansions that are often too large or complex for short-read sequencing. It utilizes long-read alignments to perform either a de novo genome-wide scan for expansions or targeted genotyping of specific loci. The tool is particularly effective at identifying alleles that are significantly longer than the reference genome by analyzing soft-clipped sequences and insertion signals within BAM files.

## Installation and Dependencies
Straglr requires Python 3.8+ and specific external binaries to be available in your `$PATH`:
- **Tandem Repeat Finder (TRF)**: For identifying repeat structures.
- **blastn**: For motif matching.

The recommended installation is via Bioconda:
```bash
conda install -c bioconda straglr
```

## Core Usage Patterns

### 1. Genome-wide Expansion Discovery
Use this mode to find novel expansions that exceed the reference length by a specific threshold (default is 100bp).

```bash
python straglr.py sample.bam reference.fa output_prefix \
    --min_ins_size 100 \
    --min_support 2 \
    --nprocs 16 \
    --exclude exclude_regions.bed
```

### 2. Targeted Genotyping
Use this mode when you have a specific list of STR loci (e.g., known disease genes like *HTT* or *C9orf72*) to evaluate.

```bash
python straglr.py sample.bam reference.fa output_prefix \
    --loci target_loci.bed \
    --genotype_in_size \
    --nprocs 8
```
*Note: The `--loci` BED file should be 4-column format: `chrom  start  end  repeat_motif`.*

## Expert Tips and Best Practices

### Alignment Requirements
- **Aligner**: Minimap2 is the recommended aligner.
- **Critical Flag**: Always use the `-Y` option in Minimap2 to enable soft-clipping. Straglr relies on these soft-clipped sequences to assess repeat lengths that extend beyond the mapped portion of the read.

### Filtering and Performance
- **Exclusion Regions**: For genome-wide scans, always provide an `--exclude` BED file containing centromeres, gaps, and segmental duplications. These regions often produce false positives due to mapping ambiguities.
- **Parallelization**: Use `--nprocs` to match your available CPU cores, as TRF and blastn operations are computationally intensive.
- **Memory Management**: For very large datasets, consider splitting your `--loci` BED file into smaller batches (e.g., 10,000 lines each) to manage resource consumption.

### Interpreting Genotypes
- **Size vs. Copy Number**: By default, Straglr reports copy numbers. Use `--genotype_in_size` to get the result in base pairs, which is often more intuitive for large expansions.
- **Allele Format**: In the output TSV, genotypes are reported as `size(support_reads)`. For example, `150.5(12);30.2(10)` indicates a heterozygous site with two alleles supported by 12 and 10 reads respectively.
- **Partial Alleles**: If an allele is preceded by `>`, it indicates a "partial" read where the full expansion was not captured within a single read, representing a minimum bound for the expansion size.

## Common Parameters Reference
- `--min_ins_size`: Minimum size increase relative to reference to report an expansion (Default: 100).
- `--min_support`: Minimum number of reads required to call an expansion (Default: 2).
- `--max_str_len`: Maximum length of the repeat motif to consider (Default: 50).
- `--min_cluster_size`: Minimum reads to constitute a distinct allele cluster (Default: 2).

## Reference documentation
- [Straglr GitHub Repository](./references/github_com_bcgsc_straglr.md)
- [Bioconda Straglr Package](./references/anaconda_org_channels_bioconda_packages_straglr_overview.md)