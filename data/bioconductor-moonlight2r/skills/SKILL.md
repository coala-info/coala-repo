---
name: bioconductor-moonlight2r
description: Moonlight2R identifies cancer driver genes by integrating gene expression, mutation, and methylation data through multi-omics analysis. Use when user asks to predict oncogenes and tumor suppressors, perform functional enrichment analysis, infer gene regulatory networks, or integrate secondary layers like driver mutation and gene methylation analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/Moonlight2R.html
---


# bioconductor-moonlight2r

name: bioconductor-moonlight2r
description: Expert guidance for using the Moonlight2R R package to predict cancer driver genes (oncogenes and tumor suppressors) through multi-omics data integration. Use this skill when performing functional enrichment analysis (FEA), gene regulatory network (GRN) inference, upstream regulator analysis (URA), and integrating secondary layers like mutation (DMA), methylation (GMA), or transcription factor influence (TFinfluence).

## Overview
Moonlight2R is a framework for identifying cancer driver genes by integrating gene expression, mutation, and methylation data. It operates on a "primary layer" (expression-based) to identify oncogenic mediators and "secondary layers" to provide additional evidence for driver status. It is particularly useful for identifying genes with dual roles (TSG in one cancer, OCG in another) and elucidating the biological processes driving cancer phenotypes.

## Core Workflow

### 1. Primary Layer: Predicting Oncogenic Mediators
The primary layer uses differentially expressed genes (DEGs) to identify putative Tumor Suppressor Genes (TSGs) and Oncogenes (OCGs).

```r
library(Moonlight2R)

# 1. Functional Enrichment Analysis (FEA)
# Identifies biological functions enriched by regulated genes
dataFEA <- FEA(DEGsmatrix = DEGsmatrix)

# 2. Gene Regulatory Network (GRN)
# Infers relationships between DEGs and TFs
dataGRN <- GRN(TFs = rownames(DEGsmatrix), 
               DEGsmatrix = DEGsmatrix, 
               normCounts = dataFilt,
               nGenesPerm = 2000, nBoot = 400)

# 3. Upstream Regulator Analysis (URA)
# Calculates z-scores for biological processes (e.g., apoptosis, proliferation)
dataURA <- URA(dataGRN = dataGRN, 
               DEGsmatrix = DEGsmatrix, 
               BPname = c("apoptosis", "proliferation of cells"))

# 4. Pattern Recognition Analysis (PRA)
# Classifies genes as putative TSGs or OCGs
dataPRA <- PRA(dataURA = dataURA, 
               BPname = c("apoptosis", "proliferation of cells"), 
               thres.role = 0)
```

### 2. Secondary Layers: Driver Evidence
Once mediators are identified, use secondary layers to confirm driver status.

*   **Driver Mutation Analysis (DMA):** Uses CScape-somatic to identify driver mutations. Requires external VCF files (`css_coding.vcf.gz`).
*   **Gene Methylation Analysis (GMA):** Uses EpiMix to identify abnormal DNA methylation patterns (hypo/hypermethylation).
*   **Transcription Factor Influence (TFinfluence):** Assesses how mutations on TFs affect the transcription of target genes using the MAVISp database.

```r
# Example: Gene Methylation Analysis
dataGMA <- GMA(dataMET = dataMethyl, 
               dataEXP = dataFilt,
               dataPRA = dataPRA, 
               dataDEGs = DEGsmatrix,
               sample_info = LUAD_sample_anno, 
               met_platform = "HM450",
               output_dir = "./GMAresults")
```

### 3. Visualization
Moonlight2R provides specialized plotting functions for each stage:
*   `plotFEA(dataFEA)`: Visualize enriched biological processes.
*   `plotURA(dataURA)`: Visualize upstream regulator z-scores.
*   `plotNetworkHive(dataGRN, knownDriverGenes)`: GRN visualization highlighting COSMIC genes.
*   `plotCircos(listMoonlight)`: Multi-cancer comparison of OCGs and TSGs.
*   `plotMetExp()`: Correlation between methylation and expression.

## Key Functions and Tips
*   **`moonlight()`**: A wrapper function that runs the entire pipeline (FEA, GRN, URA, PRA, DMA) in one call.
*   **`getDataGEO()`**: Useful for fetching expression data directly from GEO for specific cancer types.
*   **`GLS()`**: Performs a PubMed literature search for specific genes to validate findings.
*   **Performance**: For `GRN`, use `nGenesPerm = 2000` and `nBoot = 400` for production; lower values (e.g., 5) are only for quick testing.
*   **Data Requirements**: Input typically requires a DEG matrix (logFC and p-values) and a normalized expression matrix.

## Reference documentation
- [Moonlight2R](./references/Moonlight2R.md)