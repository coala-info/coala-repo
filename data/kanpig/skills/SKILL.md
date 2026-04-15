---
name: kanpig
description: kanpig genotypes structural variants by building local variant graphs and finding the best-supported paths using long-read alignments. Use when user asks to genotype structural variants, create project-level VCFs, perform trio analysis, or detect mosaic variants.
homepage: https://github.com/ACEnglish/kanpig
metadata:
  docker_image: "quay.io/biocontainers/kanpig:2.0.2--ha6fb395_0"
---

# kanpig

## Overview
kanpig (Kmer Analysis of Pileups for Genotyping) is a high-performance tool designed to genotype structural variants by building local variant graphs and finding the best-supported paths using long-read alignments. It transforms the general problem of SV genotyping into a path-finding task through these graphs, allowing for high accuracy even in complex genomic regions. It is particularly useful for creating project-level VCFs (pVCFs), analyzing trios, or detecting mosaic variants.

## Core Workflows

### Standard Genotyping
To genotype a set of variants against a long-read sample:
```bash
kanpig gt --input variants.vcf.gz \
    --reads alignments.bam \
    --reference genome.fa \
    --out output.vcf
```

### Optimized Re-analysis (BAM to PLUP)
For high-coverage samples or datasets that will be genotyped multiple times (e.g., N+1 cohorts), convert the BAM to a "pileup" (plup) file. This file is ~2,000x smaller and significantly faster to parse.
```bash
# 1. Create and index the plup file
kanpig plup --bam alignments.bam | bedtools sort -header | bgzip > alignments.plup.gz
tabix -p bed alignments.plup.gz

# 2. Genotype using the plup file instead of the BAM
kanpig gt --input variants.vcf.gz \
    --reads alignments.plup.gz \
    --reference genome.fa \
    --out output.vcf
```

### Project-Level VCF (pVCF) Pipeline
1. **Discovery**: Call SVs per sample (e.g., using Sniffles).
2. **Merge**: Consolidate variants using `bcftools merge -m none`.
3. **Collapse**: Remove redundant representations using `truvari collapse`.
4. **Genotype**: Run `kanpig gt` on each sample using the collapsed VCF as input.
5. **Combine**: Merge the per-sample kanpig outputs back into a single pVCF.

## Parameter Tuning & Best Practices

### Computational Resources
- **Threads**: Kanpig is I/O limited. Use 4–8 physical cores; hyperthreading generally does not improve performance.
- **Memory**: Allocate approximately 2GB of RAM per core.

### Sensitivity vs. Precision
- **Similarity Thresholds**: `--sizesim` and `--seqsim` (default 0.90) control how closely a read must match a graph path. Lowering these (e.g., 0.85) increases recall but may reduce precision.
- **Scoring Penalties**: 
    - `--gpenalty`: Penalizes paths with split variant representations (default 0.04).
    - `--fpenalty`: Penalizes putative false-negatives in the graph.
- **Neighborhoods**: `--neighdist` (default 1000bp) defines the local graph size. If variants are missing support, increasing this may recruit more distant informative pileups.

### Specialized Modes
- **Trio Genotyping**: Use `kanpig trio` for family-based analysis to improve Mendelian consistency.
- **Mosaicism**: Use `kanpig mosaic` to detect non-germline haplotype clustering.
- **Sex Chromosomes**: Always provide a `--ploidy-bed` to ensure correct genotyping on sex chromosomes or for organisms with non-diploid genomes.

## Interpreting Results (FT Bit Flags)
The `FT` field in the output VCF provides quality metadata. Common flags include:
- `0x2`: Genotype Quality (GQ) < 5.
- `0x4`: Depth (DP) < 5.
- `0x32`: The best path only used part of the haplotype (potential false-negative).



## Subcommands

| Command | Description |
|---------|-------------|
| kanpig gt | Germline SV Genotyping |
| kanpig mosaic | Mosaic SV Genotyping |
| kanpig plup | BAM/CRAM to Pileup Index |
| kanpig trio | Trio SV Genotyping |

## Reference documentation
- [kanpig Main Documentation](./references/github_com_ACEnglish_kanpig.md)
- [Project-Level VCF Pipeline](./references/github_com_ACEnglish_kanpig_wiki_Project_E2_80_90Level-VCF-Pipeline.md)
- [Genotype Filtering Tips](./references/github_com_ACEnglish_kanpig_wiki_Filtering-Genotypes.md)
- [Scoring Function Details](./references/github_com_ACEnglish_kanpig_wiki_Scoring-Function.md)