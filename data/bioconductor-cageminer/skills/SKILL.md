---
name: bioconductor-cageminer
description: Bioconductor-cageminer integrates GWAS-derived SNPs with transcriptomic data and coexpression networks to prioritize high-confidence candidate genes. Use when user asks to mine candidate genes from GWAS results, identify genes near SNPs, filter genes by coexpression module enrichment, or rank candidates based on condition correlation and hub status.
homepage: https://bioconductor.org/packages/release/bioc/html/cageminer.html
---

# bioconductor-cageminer

name: bioconductor-cageminer
description: Integrate GWAS-derived SNPs with transcriptomic data to identify high-confidence candidate genes. Use this skill when you need to mine genes associated with specific traits by combining physical proximity to SNPs, coexpression network analysis (GCN), and differential expression correlation.

# bioconductor-cageminer

## Overview

The `cageminer` package implements a three-step algorithm to prioritize candidate genes from Genome-Wide Association Studies (GWAS). It moves beyond simple physical proximity by integrating gene coexpression networks (GCNs) and transcriptomic responses to specific conditions. This multi-evidence approach helps identify causative genes rather than just associated markers.

## Core Workflow

The mining process can be performed either step-by-step for granular control or using an automated wrapper.

### 1. Data Preparation
Data should be formatted as Bioconductor standard objects:
- **Gene/SNP Positions**: `GRanges` objects.
- **Expression Data**: `SummarizedExperiment` object.
- **Gene Coexpression Network (GCN)**: Typically generated using the `BioNERO` package.

### 2. The Three-Step Mining Process

#### Step 1: Physical Proximity
Identify genes within a sliding window (default 2 Mb) of SNPs.
```r
# Find genes near SNPs
candidates1 <- mine_step1(gene_ranges, snp_pos, window = "2Mb")

# Optional: Visualize window sizes to optimize selection
simulate_windows(gene_ranges, snp_pos)
```

#### Step 2: Coexpression Enrichment
Filter candidates from Step 1 by keeping only those in coexpression modules enriched with "guide genes" (known trait-related genes).
```r
# Requires a GCN object (from BioNERO::exp2gcn)
candidates2 <- mine_step2(pepper_se, gcn = gcn, guides = guide_vector, 
                          candidates = candidates1$ID)
```

#### Step 3: Condition Correlation
Filter candidates from Step 2 by keeping only those significantly correlated with a specific experimental condition (e.g., "stress").
```r
candidates3 <- mine_step3(pepper_se, candidates = candidates2$candidates, 
                          sample_group = "PRR_stress")
```

### 3. Automated Mining
Perform all three steps in a single call:
```r
candidates <- mine_candidates(gene_ranges = gene_ranges, 
                              marker_ranges = snp_pos, 
                              exp = pepper_se, 
                              gcn = gcn, 
                              guides = guide_vector, 
                              sample_group = "PRR_stress")
```

## Scoring and Prioritization

If the mining process returns too many candidates, use `score_genes()` to rank them based on biological importance (Hub status and Transcription Factor activity).

```r
# Identify hubs using BioNERO
hubs <- BioNERO::get_hubs_gcn(pepper_se, gcn)

# Score and rank top candidates
scored_genes <- score_genes(candidates, hubs$Gene, tfs_vector)
```
**Scoring Logic:**
- Base score = Correlation coefficient ($r_{pb}$).
- Multiplier ($\kappa$): 2x for TFs or Hubs; 3x for Hub TFs.

## Visualization

- **SNP Distribution**: `plot_snp_distribution(snp_pos)` shows SNP density across chromosomes.
- **Circos Plot**: `plot_snp_circos(chr_length, gene_ranges, snp_pos)` visualizes SNPs in the context of gene density.

## Tips for Success
- **Guide Genes**: Use well-annotated genes (e.g., from MapMan or GO) related to the phenotype.
- **Window Size**: If linkage disequilibrium (LD) blocks are known, set `expand_intervals = FALSE` in `mine_step1()` and provide the LD intervals as the `marker_ranges`.
- **BioNERO Integration**: `cageminer` relies heavily on `BioNERO` for network construction and hub identification. Ensure `BioNERO` is installed and the GCN is properly formatted.

## Reference documentation
- [Mining high-confidence candidate genes with cageminer](./references/cageminer.md)