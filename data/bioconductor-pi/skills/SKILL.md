---
name: bioconductor-pi
description: This tool prioritizes drug targets by integrating GWAS data with functional genomic annotations and protein interaction networks. Use when user asks to map SNPs to genes, perform Random Walk with Restart on gene networks, or conduct pathway enrichment analysis for prioritized targets.
homepage: https://bioconductor.org/packages/3.8/bioc/html/Pi.html
---

# bioconductor-pi

name: bioconductor-pi
description: Genetics-led target prioritisation system for leveraging human genetic data (GWAS) to prioritise drug targets at the gene and pathway level. Use this skill when you need to map SNPs to genes (nGene, eGene, cGene), perform Random Walk with Restart (RWR) on gene networks, or conduct pathway enrichment analysis for prioritised targets.

# bioconductor-pi

## Overview
The `Pi` package is a prioritisation system designed to identify potential drug targets by integrating GWAS summary data with functional genomic annotations and protein interaction networks. It maps SNPs to "seed genes" based on genomic proximity, eQTL mapping, and promoter capture Hi-C data. It then uses a Random Walk with Restart (RWR) algorithm to propagate these scores across a network, allowing for the prioritisation of both seed and non-seed genes.

## Core Workflow

### 1. Gene-level Prioritisation
The primary entry point for GWAS data is `xPierSNPs`. This function integrates SNP significance, LD information, and functional mapping to score genes.

```r
library(Pi)

# Example: Prioritise genes from GWAS summary data
# data: data frame with 'SNP' and 'Pval' columns
pNode <- xPierSNPs(
  data = my_gwas_df,
  include.LD = 'EUR',          # Population for LD calculation
  LD.r2 = 0.8,
  significance.threshold = 5e-8,
  include.eQTL = c("JKscience_TS2A", "GTEx_V4_Whole_Blood"),
  include.HiC = c("Monocytes", "Total_B_cells"),
  network = "STRING_high",     # Interaction network to use
  restart = 0.75               # RWR restart probability
)

# Access priority scores
priority_scores <- pNode$priority
```

### 2. Pathway-level Prioritisation
Once genes are prioritised, use `xPierPathways` to identify enriched biological processes or pathways.

```r
# Prioritise pathways based on top 100 genes
eTerm <- xPierPathways(pNode, priority.top=100, ontology="MsigdbC2CPall")

# Remove redundant terms for a cleaner result
eTerm_nonred <- xEnrichConciser(eTerm)

# View results
xEnrichViewer(eTerm_nonred)
```

### 3. Network-level Subnet Identification
To find a functional module of highly prioritised genes, use `xPierSubnet`.

```r
# Identify a subnetwork of ~50 nodes
g <- xPierSubnet(pNode, priority.quantite=0.1, subnet.size=50)

# Visualize the network
pattern <- as.numeric(V(g)$priority)
xVisNet(g, pattern=pattern, colormap="yr", vertex.shape="sphere")
```

## Key Functions and Parameters

### Data Mapping & Scoring
- `xPierSNPs`: The master function for SNP-to-gene prioritisation.
- `xPierGenes`: Prioritises genes when you already have gene-level scores (skipping the SNP mapping step).
- `xRWR`: The underlying Random Walk with Restart algorithm.

### Visualization
- `xPierManhattan`: Generates a Manhattan plot where the Y-axis represents the gene priority score.
- `xPierTrack`: Visualises priority scores in a genomic context (track plot) for a specific gene.
- `xVisEvidence`: Visualises the evidence (eQTL, Hi-C, proximity) supporting a prioritised gene.

### Network Options
The package supports several built-in networks via the `network` parameter:
- `STRING_high` / `STRING_medium`: Functional interactions.
- `PCommonsUN_high` / `PCommonsDN_high`: Pathway Commons (Undirected/Directed).

## Tips for Success
- **RData Location**: Many functions require `RData.location`. By default, this points to a remote server. If working offline, ensure the necessary `.RData` files are downloaded locally.
- **LD Population**: Ensure the `include.LD` parameter matches the ancestry of your GWAS study (e.g., 'EUR', 'EAS', 'AFR').
- **Redundancy**: Use `xEnrichConciser` after pathway enrichment to merge similar terms and improve interpretability.

## Reference documentation
- [Pi User Manual (R/Bioconductor package)](./references/Pi_vignettes.md)