---
name: bioconductor-gdcrnatools
description: GDCRNATools provides a comprehensive pipeline for the integrative analysis of lncRNA, mRNA, and miRNA data from the Genomic Data Commons. Use when user asks to download and organize GDC data, perform differential expression analysis, construct ceRNA regulatory networks, or conduct functional enrichment and survival analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/GDCRNATools.html
---


# bioconductor-gdcrnatools

name: bioconductor-gdcrnatools
description: Integrative analysis of lncRNA, mRNA, and miRNA data from GDC. Use for downloading and organizing GDC data, performing differential expression analysis (limma, edgeR, DESeq2), constructing ceRNA regulatory networks, functional enrichment (GO, KEGG, DO), and survival analysis.

# bioconductor-gdcrnatools

## Overview
GDCRNATools is an R/Bioconductor package providing a comprehensive pipeline for the integrative analysis of RNA expression data from the Genomic Data Commons (GDC). It is specifically designed to decipher lncRNA-mRNA related competing endogenous RNA (ceRNA) regulatory networks in cancer.

## Core Workflow

### 1. Data Acquisition and Organization
Download and merge data from GDC using manifest files or project IDs.

```r
# Download RNA-seq data
gdcRNADownload(project.id = 'TCGA-CHOL', data.type = 'RNAseq', directory = 'Data')

# Parse metadata
metaMatrix <- gdcParseMetadata(project.id = 'TCGA-CHOL', data.type = 'RNAseq')

# Filter samples (e.g., keep only Primary Tumor and Solid Tissue Normal)
metaMatrix <- gdcFilterSampleType(metaMatrix)
metaMatrix <- gdcFilterDuplicate(metaMatrix)

# Merge raw counts
rnaCounts <- gdcRNAMerge(metadata = metaMatrix, path = 'Data/', data.type = 'RNAseq')
```

### 2. Preprocessing and Normalization
Normalize raw counts using TMM and voom transformation.

```r
# TMM normalization and voom transformation
rnaExpr <- gdcVoomNormalization(counts = rnaCounts, filter = TRUE)
```

### 3. Differential Expression Analysis
Identify differentially expressed genes (DEGs) or miRNAs using `limma`, `edgeR`, or `DESeq2`.

```r
# Perform DE analysis
DEGAll <- gdcDEAnalysis(counts = rnaCounts, 
                        group = metaMatrix$sample_type, 
                        comparison = 'PrimaryTumor-SolidTissueNormal', 
                        method = 'limma')

# Report DEGs based on thresholds
dePC <- gdcDEReport(deg = DEGAll, gene.type = 'protein_coding', fc = 2, pval = 0.01)
deLNC <- gdcDEReport(deg = DEGAll, gene.type = 'long_non_coding', fc = 2, pval = 0.01)
```

### 4. ceRNA Network Construction
Identify ceRNA pairs based on shared miRNAs, expression correlation, and regulation similarity.

```r
ceOutput <- gdcCEAnalysis(lnc = rownames(deLNC), 
                          pc = rownames(dePC), 
                          deMIR = NULL, 
                          lnc.targets = 'starBase', 
                          pc.targets = 'starBase', 
                          rna.expr = rnaExpr, 
                          mir.expr = mirExpr)
```

### 5. Functional Enrichment and Survival Analysis
Perform GO, KEGG, and DO enrichment, and evaluate clinical significance.

```r
# Enrichment analysis
enrichOutput <- gdcEnrichAnalysis(gene = rownames(dePC), simplify = TRUE)

# Survival analysis (CoxPH or KM)
survOutput <- gdcSurvivalAnalysis(gene = rownames(dePC), 
                                  rna.expr = rnaExpr, 
                                  metadata = metaMatrix, 
                                  method = 'coxph')
```

## Visualization
The package provides several functions for routine and interactive visualization.

- **Static Plots**: `gdcVolcanoPlot()`, `gdcBarPlot()`, `gdcHeatmap()`, `gdcKMPlot()`, `gdcCorPlot()`, `gdcEnrichPlot()`.
- **Interactive Shiny Apps**: `shinyCorPlot()`, `shinyKMPlot()`, `shinyPathview()`.
- **Network Export**: Use `gdcExportNetwork()` to generate node and edge files for Cytoscape.

## Tips for Success
- **Sample Matching**: Use `gdcMatchSamples()` to ensure your metadata and expression matrix align before analysis.
- **Gene IDs**: The package primarily uses Ensembl IDs. Ensure your input vectors are correctly formatted.
- **DESeq2 Performance**: When using `method='DESeq2'` in `gdcDEAnalysis()`, specify `n.cores` to accelerate the process, as it is computationally intensive.
- **Database Selection**: For `gdcCEAnalysis()`, you can choose between 'starBase', 'spongeScan', and 'miRcode' for miRNA-target interactions.

## Reference documentation
- [GDCRNATools Reference Manual](./references/reference_manual.md)