---
name: bioconductor-desubs
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/DEsubs.html
---

# bioconductor-desubs

## Overview
DEsubs is a Bioconductor package designed for the extraction and analysis of disease-perturbed subpathways within a pathway network. It integrates RNA-seq expression profiles with KEGG signaling pathway maps to identify functional modules. The package supports five main subpathway extraction categories: components, communities, streams, neighborhoods, and cascades. It also provides extensive visualization tools and enrichment analysis against various biological features (GO, KEGG, Diseases, Drugs, miRNAs, and TFs).

## Package Setup
Before loading the package, configure the cache directory to ensure proper data handling:

```r
# For Unix/Linux/macOS
options('DEsubs_CACHE' = file.path(path.expand("~"), 'DEsubs'))

# For Windows
# options('DEsubs_CACHE' = file.path(gsub("\\\\", "/", Sys.getenv("USERPROFILE")), "AppData/DEsubs"))

library(DEsubs)
# Load toy data for testing
load(system.file('extdata', 'data.RData', package='DEsubs'))
```

## Typical Workflow

### 1. Data Preparation
Input data should be an RNA-seq expression matrix with genes as rows and samples as columns (Case vs. Control). DEsubs primarily uses Entrez IDs.

### 2. Subpathway Extraction
The main function `DEsubs()` handles network construction, DEG identification, and subpathway extraction.

```r
DEsubs.out <- DEsubs(
  org = 'hsa',                        # Organism (e.g., 'hsa', 'mmu', 'rno')
  mRNAexpr = mRNAexpr,                # Expression matrix
  mRNAnomenclature = 'entrezgene',    # Input label type
  pathways = 'All',                   # KEGG pathways to include
  DEtool = 'DESeq2',                  # Options: 'edgeR', 'DESeq2', 'EBSeq', etc.
  DEpar = 0.05,                       # Q-value threshold for DEGs
  CORtool = 'pearson',                # Edge correlation: 'pearson', 'spearman', 'kendall'
  CORpar = 0.7,                       # Correlation threshold
  subpathwayType = 'community.walktrap', # Extraction method
  rankedList = NULL,                  # Optional custom ranked gene list
  verbose = FALSE
)
```

### 3. Subpathway Extraction Options
DEsubs supports 124 subpathway types categorized by:
*   **Components/Communities:** Densely linked groups (e.g., `community.louvain`, `component.max_cliques`).
*   **Streams/Neighborhoods/Cascades:** Propagation-based subpathways starting from a Gene of Interest (GOI).
    *   **Topological GOIs:** Based on `degree`, `betweenness`, `page_rank`, etc.
    *   **Functional GOIs:** Based on `KEGG`, `GO_bp`, `Disease_OMIM`, `Drug_DrugBank`, etc.
    *   **Direction:** `fwd` (forward) or `bwd` (backward).

### 4. Visualization

#### Gene Level
Visualize top DEGs and genes with high topological/functional scores:
```r
geneVisualization(DEsubs.out, top=10, export='plot')
```

#### Subpathway Level
Visualize a specific subpathway as a directed graph or circular diagram:
```r
# Graph representation
subpathwayToGraph(DEsubs.out, submethod='community.walktrap', subname='sub1', export='plot')

# Circular diagram for enrichment
subpathwayVisualization(DEsubs.out, references=c('GO', 'TF'), submethod='community.walktrap', subname='sub1', export='plot')
```

#### Organism Level
Dot plots showing the relationship between all extracted subpathways and enriched terms:
```r
organismVisualization(DEsubs.out, references='KEGG', topSubs=10, topTerms=20, export='plot')
```

## Key Parameters and Options
*   **Organisms:** 'hsa' (Human), 'mmu' (Mouse), 'dme' (Fly), 'sce' (Yeast), 'ath' (Arabidopsis), 'rno' (Rat), 'dre' (Zebrafish).
*   **Gene Labels:** Supports 'entrezgene', 'ensembl_gene_id', 'hgnc_symbol', 'refseq_mrna', etc.
*   **Enrichment References:** 'KEGG', 'GO_bp', 'GO_cc', 'GO_mf', 'Disease_OMIM', 'Disease_GAD', 'Drug_DrugBank', 'TF'.

## Reference documentation
- [DEsubs](./references/DEsubs.md)