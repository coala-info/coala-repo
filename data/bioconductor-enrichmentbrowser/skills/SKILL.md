---
name: bioconductor-enrichmentbrowser
description: the package facilitates the visualization and exploration of such sets and pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/EnrichmentBrowser.html
---

# bioconductor-enrichmentbrowser

## Overview
The `EnrichmentBrowser` package provides a unified pipeline for enrichment analysis. It integrates established Bioconductor tools to combine "set-based" (functional class scoring) and "network-based" (topology-aware) methods. The package is designed to handle both microarray and RNA-seq data, facilitating the discovery of differentially regulated pathways and the visualization of results through interactive HTML reports.

## Typical Workflow

1. **Data Preparation**: Load expression data into a `SummarizedExperiment` object.
2. **Preprocessing**: Normalize data and perform differential expression (DE) analysis.
3. **ID Mapping**: Ensure gene identifiers are mapped to NCBI Entrez IDs (required for downstream enrichment).
4. **Gene Set Retrieval**: Download or parse gene sets (KEGG, GO, MSigDB).
5. **Enrichment Analysis**: Run set-based (SBEA) and/or network-based (NBEA) methods.
6. **Combination & Visualization**: Combine results from multiple methods and generate an interactive report.

## Core Functions and Usage

### 1. Data Input and Preparation
The package uses `SummarizedExperiment` as the primary data structure.
```r
library(EnrichmentBrowser)

# Read from tab-separated files
se <- readSE(exprs.file, cdat.file, rdat.file)

# Convert from ExpressionSet if necessary
se <- as(myExpressionSet, "SummarizedExperiment")

# Map probes to genes (for microarrays)
se <- probe2gene(se)
```

### 2. Normalization and DE Analysis
Define groups in `colData(se)$GROUP` (0 for control, 1 for treatment).
```r
# Normalization
# For RNA-seq raw counts, use "vst" or "quantile"
se <- normalize(se, norm.method = "quantile")

# Differential Expression
# Methods: "limma" (default), "edgeR", "DESeq2"
se <- deAna(se, de.method = "limma", padj.method = "BH")
```

### 3. ID Mapping
Downstream functions require Entrez IDs.
```r
# Check available types
idTypes("hsa")

# Map ENSEMBL to ENTREZ
se <- idMap(se, org = "hsa", from = "ENSEMBL", to = "ENTREZID")
```

### 4. Enrichment Analysis (SBEA & NBEA)
Retrieve gene sets and execute analysis.
```r
# Get Gene Sets (KEGG or GO)
gs <- getGenesets(org = "hsa", db = "kegg")

# Set-Based Enrichment Analysis (SBEA)
# Methods: "ora", "gsea", "padog", "roast", "camera", "gsva"
sbea.res <- sbea(method = "ora", se = se, gs = gs, perm = 0)

# Network-Based Enrichment Analysis (NBEA)
# Requires a Gene Regulatory Network (GRN)
grn <- compileGRN(org = "hsa", db = "kegg")
# Methods: "ggea", "spia", "pathnet", "degraph"
nbea.res <- nbea(method = "ggea", se = se, gs = gs, grn = grn)
```

### 5. Results and Visualization
```r
# View top ranking sets
gsRanking(sbea.res)

# Combine results from different methods
comb.res <- combResults(list(sbea.res, nbea.res))

# Generate interactive HTML report
eaBrowse(comb.res)
```

## Method Selection Tips
*   **Simple Gene Lists**: Use `ora` (Overrepresentation Analysis).
*   **Full Expression Matrix (Competitive)**: Use `padog` or `camera`.
*   **Full Expression Matrix (Self-contained)**: Use `roast` or `gsva`.
*   **RNA-seq**: Apply `voom` transformation (via `normalize(se, norm.method = "vst")`) before using legacy methods like GSEA.
*   **Network Consistency**: Use `ggea` to see if expression changes align with known activation/inhibition directions in a GRN.

## Reference documentation
- [EnrichmentBrowser](./references/EnrichmentBrowser.md)