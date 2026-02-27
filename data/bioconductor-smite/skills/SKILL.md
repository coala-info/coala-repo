---
name: bioconductor-smite
description: Bioconductor-smite integrates gene expression and epigenetic data to identify functional modules and subnetworks within gene interaction networks. Use when user asks to integrate multi-omics data, identify significance-based gene interaction networks, or perform pathway enrichment on identified modules.
homepage: https://bioconductor.org/packages/release/bioc/html/SMITE.html
---


# bioconductor-smite

name: bioconductor-smite
description: Integration of gene expression and epigenome-wide studies to identify functional modules and subnetworks. Use this skill when analyzing multi-omics data (RNA-seq, DNA methylation, ChIP-seq) to identify significance-based gene interaction networks and perform pathway enrichment on identified modules.

# bioconductor-smite

## Overview

SMITE (Significance-based Modules Integrating Two Ensembles) is an R package designed to integrate results from gene expression and epigenetic studies. It transforms p-values from various genomic features (promoters, gene bodies, enhancers) into a unified scoring system to identify functional modules within gene interaction networks (e.g., REACTOME). This approach allows for the discovery of coordinated molecular changes across different regulatory layers.

## Core Workflow

### 1. Data Preparation and Curation
Before integration, data must be formatted as data frames with genomic coordinates, effect sizes, and p-values.

```r
library(SMITE)

# Methylation data: Chr, Start, Stop, Effect, P-value
data(methylationdata)
# Replace p-values of 0 with the minimum non-zero p-value
methylation[,5] <- replace(methylation[,5], methylation[,5]==0, 
                           min(subset(methylation[,5], methylation[,5]!=0), na.rm=TRUE))
methylation <- methylation[!is.na(methylation[,5]), ]

# Expression data: Gene Symbol, Effect (logFC), P-value
data(curated_expressiondata)

# Convert Gene IDs if necessary
# genes[,1] <- convertGeneIds(gene_IDs=genes[,1], ID_type="refseq", ID_convert_to="symbol")
```

### 2. Creating Annotations
Define the genomic regions (promoters, bodies, enhancers) to be associated with each gene.

```r
# Load gene bed and other features (e.g., H3K4me1 peaks)
data(hg19_genes_bed)
data(histone_h3k4me1)

test_annotation <- makePvalueAnnotation(
    data=hg19_genes, 
    other_data=list(h3k4me1=h3k4me1), 
    gene_name_col=5, 
    promoter_upstream_distance=1000, 
    promoter_downstream_distance=1000
)
```

### 3. Integrating Multi-Omics Data
Load expression and epigenetic modifications into the annotation object.

```r
# Annotate Expression
test_annotation <- annotateExpression(test_annotation, expr_data=expression_curated, 
                                      effect_col=1, pval_col=2)

# Annotate Modifications (e.g., Methylation)
# mod_type can be any custom string (e.g., "methylation", "hydroxymethylation")
test_annotation <- annotateModification(test_annotation, methylation, 
                                      weight_by_method="Stouffer", 
                                      weight_by=c(promoter="distance", body="distance", h3k4me1="distance"),
                                      mod_type="methylation")
```

### 4. Scoring and Normalization
Combine p-values into a single score per gene, accounting for expected effect directions.

```r
# Define expected relationships (e.g., promoter methylation decreases expression)
test_annotation <- makePvalueObject(test_annotation, 
    effect_directions=c(methylation_promoter="decrease", 
                        methylation_body="increase", 
                        methylation_h3k4me1="bidirectional"))

# Normalize scores to the range of expression to prevent bias
test_annotation <- normalizePval(test_annotation, ref="expression", method="rescale")

# Calculate final weighted scores
test_annotation <- scorePval(test_annotation, 
                             weights=c(methylation_promoter=.3, 
                                       methylation_body=.1,
                                       expression=.3,
                                       methylation_h3k4me1=.3))
```

### 5. Network Analysis and Visualization
Identify modules using an interactome and annotate them with pathway analysis.

```r
# Load an igraph network (e.g., REACTOME)
load(system.file("data","Reactome.Symbol.Igraph.rda", package="SMITE"))

# Identify modules using Spinglass algorithm
test_annotation <- runSpinglass(test_annotation, network=REACTOME, maxsize=50)

# Annotate modules with GO/KEGG
test_annotation <- runGOseq(test_annotation, type="kegg")

# Search for specific pathways
searchGOseq(test_annotation, search_string="cell cycle")

# Plot a specific module
plotModule(test_annotation, which_network=1, goseq=TRUE)
```

## Tips for Success
- **Gene IDs**: Ensure a consistent Gene ID system (preferably Gene Symbols) is used across all input datasets.
- **P-value Zeros**: Always replace p-values of 0 with the minimum observed p-value to avoid infinite values during log transformation.
- **Weighting**: Use the `weights` argument in `scorePval` to prioritize specific biological contexts (e.g., focusing on enhancer methylation).
- **Visualization**: Use `plotDensityPval` before and after `normalizePval` to ensure scores are comparable across different data types.

## Reference documentation
- [SMITE Vignette](./references/SMITE.md)
- [SMITE RMarkdown](./references/SMITE.Rmd)