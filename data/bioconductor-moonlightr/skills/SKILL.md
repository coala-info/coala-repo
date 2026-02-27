---
name: bioconductor-moonlightr
description: MoonlightR identifies oncogenes and tumor suppressor genes by integrating differential expression, functional enrichment, and gene regulatory network analysis. Use when user asks to identify cancer driver genes, perform upstream regulator analysis, or predict gene roles in cancer progression using TCGA or GEO data.
homepage: https://bioconductor.org/packages/release/bioc/html/MoonlightR.html
---


# bioconductor-moonlightr

name: bioconductor-moonlightr
description: Expert guidance for using the MoonlightR Bioconductor package to identify oncogenes (OCG) and tumor suppressor genes (TSG) through functional enrichment, gene regulatory networks, and upstream regulator analysis. Use this skill when analyzing TCGA or GEO cancer genomics data to predict gene roles and biological drivers of cancer progression.

# bioconductor-moonlightr

## Overview
MoonlightR is an R package designed to identify the dual roles of genes as either oncogenes (OCG) or tumor suppressor genes (TSG) across different cancer types. It integrates differential expression analysis, functional enrichment, gene regulatory network (GRN) inference, and upstream regulator analysis (URA) to score biological processes and predict gene functions.

## Core Workflow

The standard MoonlightR pipeline follows these steps:

1.  **Data Acquisition**: Use `getDataTCGA` or `getDataGEO` to retrieve expression or methylation data.
2.  **Differential Phenotype Analysis (DPA)**: Identify differentially expressed genes (DEGs) or methylated regions.
3.  **Functional Enrichment Analysis (FEA)**: Identify enriched biological processes (BPs) linked to cancer.
4.  **Gene Regulatory Network (GRN)**: Infer relationships between DEGs and other genes using mutual information.
5.  **Upstream Regulator Analysis (URA)**: Calculate z-scores for DEGs within enriched gene sets to determine their impact on biological functions.
6.  **Pattern Recognition Analysis (PRA)**: Classify genes as OCG or TSG based on URA scores and biological process patterns (e.g., apoptosis vs. proliferation).

## Key Functions

### Data Collection
```r
# TCGA Data
dataFilt <- getDataTCGA(cancerType = "LUAD", 
                        dataType = "Gene expression", 
                        nSample = 50)

# GEO Data
dataFilt <- getDataGEO(TCGAtumor = "ESCA")
```

### Analysis Pipeline
```r
# 1. Differential Expression
dataDEGs <- DPA(dataFilt = dataFilt, dataType = "Gene expression")

# 2. Functional Enrichment
dataFEA <- FEA(DEGsmatrix = dataDEGs)

# 3. Gene Regulatory Network
dataGRN <- GRN(TFs = rownames(dataDEGs)[1:100], 
               normCounts = dataFilt,
               DEGsmatrix = dataDEGs)

# 4. Upstream Regulator Analysis
# Focus on specific biological processes like apoptosis or proliferation
dataURA <- URA(dataGRN = dataGRN, 
               DEGsmatrix = dataDEGs, 
               BPname = c("apoptosis", "proliferation of cells"))

# 5. Identify OCG/TSG Candidates
dataDual <- PRA(dataURA = dataURA, 
                BPname = c("apoptosis", "proliferation of cells"))
```

### Visualization
*   `plotFEA(dataFEA)`: Visualizes enriched biological functions and their z-scores.
*   `plotURA(dataURA)`: Displays the results of the upstream regulator analysis.
*   `plotNetworkHive(dataGRN, knownDriverGenes)`: Visualizes the GRN using a hive plot, highlighting known COSMIC drivers.
*   `plotCircos(listMoonlight)`: Creates a circos plot showing OCGs/TSGs across multiple cancer types or stages.

## Integrated Wrapper
For a streamlined analysis, use the `moonlight` function which encapsulates the entire pipeline:
```r
results <- moonlight(cancerType = "LUAD", 
                     dataType = "Gene expression",
                     nSample = 20, 
                     nTF = 100,
                     BPname = c("apoptosis", "proliferation of cells"))
```

## Tips for Success
*   **Sample Size**: When testing, use the `nSample` parameter in `getDataTCGA` to limit download times.
*   **Biological Processes**: The `BPname` argument is critical. Common choices for cancer analysis are "apoptosis" and "proliferation of cells".
*   **Dual Roles**: Use `plotCircos` to identify genes that act as an OCG in one context and a TSG in another (dual-role biomarkers).
*   **External Validation**: The package includes `knownDriverGenes` (from COSMIC) to help validate your predictions.

## Reference documentation
- [Moonlight: an approach to identify multiple role of biomarkers as oncogene or tumorsuppressor in different tumor types and stages.](./references/Moonlight.Rmd)
- [Moonlight: an approach to identify multiple role of biomarkers as oncogene or tumorsuppressor in different tumor types and stages.](./references/Moonlight.md)