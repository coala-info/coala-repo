---
name: bioconductor-egsea
description: This tool performs Ensemble of Gene Set Enrichment Analysis by integrating results from multiple base algorithms to identify significant biological pathways in RNA-seq or microarray data. Use when user asks to perform ensemble gene set enrichment analysis, identify significant pathways across multiple experimental contrasts, or integrate results from multiple GSE algorithms like camera, safe, and gage.
homepage: https://bioconductor.org/packages/release/bioc/html/EGSEA.html
---


# bioconductor-egsea

name: bioconductor-egsea
description: Perform Ensemble of Gene Set Enrichment Analysis (EGSEA) using multiple base methods (camera, safe, gage, etc.). Use when analyzing RNA-seq or microarray data to identify significant gene sets, pathways, or biological processes across single or multiple experimental contrasts.

# bioconductor-egsea

## Overview
EGSEA (Ensemble of Gene Set Enrichment Analysis) integrates results from twelve prominent GSE algorithms (including camera, safe, gage, padog, and gsva) to calculate collective significance scores. It is designed to work seamlessly with the limma-voom pipeline for RNA-seq data but also supports microarray data and simple over-representation analysis (ORA).

## Installation
```R
if (!requireNamespace("BiocManager", quietly = TRUE)) install.packages("BiocManager")
BiocManager::install(c("EGSEA", "EGSEAdata"))
```

## Core Workflow

### 1. Build Gene Set Indexes
Before running the analysis, you must index the gene sets for your specific species (human, mouse, or rat).
```R
library(EGSEA)
# entrezIDs should match the rownames of your expression matrix
gs.annots = buildIdx(entrezIDs = rownames(voom.results), 
                     species = "human", 
                     msigdb.gsets = c("h", "c2", "c5"), 
                     kegg.exclude = c("Metabolism"))
```

### 2. Run EGSEA Analysis
EGSEA can be run on a `voom` object (from limma) or directly on a count matrix.

**Using a voom object:**
```R
# baseMethods: camera, safe, gage, padog, plage, zscore, gsva, ssgsea, globaltest, ora, fry, roast
baseMethods = egsea.base() 

gsa = egsea(voom.results = v, 
            contrasts = contrasts, 
            gs.annots = gs.annots,
            symbolsMap = v$genes, 
            baseGSEAs = baseMethods, 
            sort.by = "avg.rank", 
            report = TRUE, 
            report.dir = "./egsea-report")
```

**Using a count matrix:**
```R
gsa = egsea.cnt(counts = cnt, 
                group = group, 
                design = design, 
                contrasts = contrasts, 
                gs.annots = gs.annots, 
                symbolsMap = genes, 
                report = TRUE)
```

### 3. Explore Results
Use S4 methods to query the `EGSEAResults` object.
```R
# Summary of top sets across collections
summary(gsa)

# Extract top sets for a specific contrast and collection
top_kegg = topSets(gsa, contrast = 1, gs.label = "kegg", number = 10)

# Get detailed info for a specific gene set
showSetByName(gsa, "kegg", "Asthma")
```

## Visualization
EGSEA provides extensive visualization tools for both individual contrasts and comparative analysis.

```R
# MDS plot of base method rankings
plotMethods(gsa, gs.label = "kegg", contrast = 1)

# Summary plot (Significance vs. LogFC)
plotSummary(gsa, gs.label = "kegg", contrast = 1)

# Heatmap for a specific gene set
plotHeatmap(gsa, "Asthma", gs.label = "kegg", contrast = 1)

# KEGG pathway map with fold changes
plotPathway(gsa, "Asthma", gs.label = "kegg", contrast = 1)

# Comparative summary plot (Contrast A vs Contrast B)
plotSummary(gsa, gs.label = "kegg", contrast = c(1, 2))
```

## Custom Gene Sets
You can use your own gene sets by creating a custom index.
```R
# gsets is a list of Entrez ID vectors
custom.idx = buildCustomIdx(geneIDs = rownames(v$E), 
                            gsets = my_list, 
                            species = "human", 
                            name = "MyCustomSets")
```

## Tips for Success
- **Gene IDs**: EGSEA primarily uses Entrez Gene IDs. Ensure your input data and index building use the same ID type.
- **Parallelization**: Use `num.threads` in `egsea()` to speed up calculations.
- **Sorting**: The `sort.by` parameter is critical. Common choices include `avg.rank`, `p.adj`, or `significance`.
- **Comparative Analysis**: If you provide multiple contrasts, EGSEA automatically performs a comparative analysis to find pathways perturbed across all conditions.

## Reference documentation
- [Ensemble of Gene Set Enrichment Analyses](./references/EGSEA.md)