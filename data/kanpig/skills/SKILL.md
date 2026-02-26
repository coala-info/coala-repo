---
name: kanpig
description: kanpig genotypes structural variants from long-read sequencing data using k-mer analysis of local variant graphs. Use when user asks to genotype structural variants, create pileup files for efficient re-analysis, perform trio-based genotyping, or detect mosaic variants.
homepage: https://github.com/ACEnglish/kanpig
---


# kanpig

## Overview

kanpig (Kmer ANalysis of PIleups for Genotyping) is a specialized tool for determining the genotypes of structural variants from long-read sequencing. Unlike traditional aligners that may struggle with complex SV representations, kanpig builds local variant graphs and evaluates read support using k-mer similarities. It is designed to be extremely fast and I/O efficient, making it suitable for large cohorts and N+1 genotyping pipelines.

## Core Workflows

### Standard Genotyping
The primary command for germline genotyping requires a candidate VCF, aligned reads, and a reference genome.

```bash
kanpig gt \
  --input variants.vcf.gz \
  --reads alignments.bam \
  --reference genome.fa \
  --out output.vcf
```

### Optimized Re-analysis (PLUP Workflow)
For samples that will be genotyped multiple times or for very high-coverage data, convert the BAM to a "plup" (pileup) file. This file is significantly smaller (~2000x) and faster to parse.

1. **Create the pileup:**
```bash
kanpig plup --bam alignments.bam | bedtools sort -header | bgzip > alignments.plup.gz
tabix -p bed alignments.plup.gz
```

2. **Genotype using the pileup:**
```bash
kanpig gt --input variants.vcf.gz --reads alignments.plup.gz --reference genome.fa --out output.vcf
```

### Specialized Modes
- **Trio Genotyping:** Use `kanpig trio` for family-based genotyping to improve accuracy using Mendelian constraints.
- **Mosaic Detection:** Use `kanpig mosaic` for detecting non-germline haplotype clustering.

## Expert Parameters & Tuning

### Neighborhood Management
- `--neighdist`: Controls the size of local variant graphs. If variants are dense, increasing this helps recruit distant reads that span the entire complex region. If too large, it may include too many SVs for efficient graph traversal.
- `--maxnodes`: If a neighborhood exceeds this limit, kanpig switches to a faster `--one-to-one` comparison mode to prevent memory exhaustion.

### Sensitivity vs. Precision
- `--sizesim` and `--seqsim`: Default is `0.90`. 
    - **Increase (e.g., 0.95)**: Higher precision, lower recall.
    - **Decrease (e.g., 0.85)**: Higher recall, lower precision (useful for noisy reads or poorly defined SV boundaries).
- `--maxpaths`: Limits the search space in the variant graph. Increase this if you suspect complex nested variants are being missed.

### Resource Optimization
- **Threads**: kanpig is highly parallelized but I/O bound. Using more than 8 physical cores rarely provides significant speedups. Avoid hyperthreading; map threads to physical processors.
- **Memory**: Allocate approximately 2GB of RAM per core.

## Interpreting Results (FORMAT Fields)

| Field | Description |
|-------|-------------|
| **FT** | Filter flag (0x0 is pass). Check for 0x2 (Low GQ) or 0x4 (Low Depth). |
| **SQ** | Phred-scaled likelihood that the alternate allele is present. |
| **GQ** | Genotype Quality; difference between the most and second-most likely genotypes. |
| **PS** | Phase Set ID. Used for long-range phasing or grouping variants evaluated together. |
| **KS** | Kanpig Score; the internal similarity score used for the genotype call. |

## Reference documentation
- [kanpig Main Repository](./references/github_com_ACEnglish_kanpig.md)
- [kanpig Wiki and Documentation](./references/github_com_ACEnglish_kanpig_wiki.md)