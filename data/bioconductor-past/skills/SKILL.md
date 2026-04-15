---
name: bioconductor-past
description: The PAST package performs metabolic pathway enrichment analysis using GWAS results by mapping SNPs to genes and calculating weighted Kolmogorov-Smirnov statistics. Use when user asks to load GWAS and LD data, map SNPs to genes, calculate pathway significance, or visualize pathway enrichment results.
homepage: https://bioconductor.org/packages/release/bioc/html/PAST.html
---

# bioconductor-past

## Overview

The `PAST` package implements a workflow for metabolic pathway analysis using Genome-Wide Association Study (GWAS) results. Unlike traditional GWAS that focuses only on SNPs exceeding a strict significance threshold, PAST considers all marker-trait associations. It groups SNPs into linkage disequilibrium (LD) blocks, identifies tagSNPs, maps these to nearby genes (typically within 1kb), and then uses a weighted Kolmogorov-Smirnov statistic to determine if genes within specific pathways are enriched for high effect sizes.

## Typical Workflow

### 1. Loading Input Data
PAST requires several specific data formats, typically exported from tools like TASSEL.

```r
library(PAST)

# Load GWAS statistics and allele effects
# association_file: SNP, Chromosome, Position, P-value, R2
# effects_file: SNP, Allele, Effect estimate
gwas_data <- load_GWAS_data("association.txt", "effects.txt")

# Load Linkage Disequilibrium (LD) data
# LD_file: Dist_bp, R2, pDiseq, etc.
LD <- load_LD("LD.txt")
```

### 2. Mapping SNPs to Genes
This step identifies tagSNPs and transfers their attributes (p-value, R2, effect) to genes within a specified genomic window.

```r
# genes_file: GFF annotation file
genes <- assign_SNPs_to_genes(
  gwas_data = gwas_data,
  LD = LD,
  genes_file = "genes.gff",
  filters = c("gene"),      # GFF feature types to include
  window = 1000,            # bp distance from tagSNP to gene
  r2_threshold = 0.8,       # LD threshold for linkage
  num_unlinked = 2          # Number of unlinked SNPs to check
)
```

### 3. Pathway Enrichment Analysis
Calculate enrichment scores (ES) and significance for pathways based on the ranked effects of associated genes.

```r
# pathways_file: Tab-delimited (PWY-ID, Description, Gene)
# genes: Output from assign_SNPs_to_genes
results <- find_pathway_significance(
  genes = genes,
  pathways_file = "pathways.txt",
  min_genes = 5,            # Minimum genes per pathway to be included
  order = "increasing",     # "increasing" or "decreasing" based on trait benefit
  num_permutations = 1000,  # For null distribution/p-value calculation
  num_cores = 2             # Parallel processing
)
```

### 4. Visualization
Generate rug plots to visualize the running sum statistic and the distribution of pathway genes across the ranked gene list.

```r
# Generates PDF plots in the specified directory
plot_pathways(
  results,
  column = "pvalue",        # Filter criteria
  threshold = 0.05,         # Significance threshold for plotting
  order = "increasing",
  directory = tempdir()
)
```

## Key Considerations
- **Chromosome Naming**: Ensure chromosome identifiers are consistent across the GWAS files, LD file, and GFF annotation.
- **Gene IDs**: Gene names in the `pathways_file` must exactly match the IDs used in the GFF file.
- **Effect Direction**: The `order` parameter ("increasing" vs "decreasing") should be chosen based on whether a higher or lower phenotypic value is considered "beneficial" or of interest for the specific trait.
- **LD Thresholds**: The default `r2_threshold` of 0.8 is standard, but can be adjusted based on the decay of linkage disequilibrium in your specific population.

## Reference documentation
- [PAST](./references/past.md)