---
name: bioconductor-epimix.data
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/data/experiment/html/EpiMix.data.html
---

# bioconductor-epimix.data

name: bioconductor-epimix.data
description: Provides supporting data and workflows for the EpiMix R package to perform integrative analysis of DNA methylation and gene expression. Use this skill when analyzing methylation states (hypo/hypermethylation) across different genetic elements including protein-coding genes, distal enhancers, miRNAs, and lncRNAs. It supports automated TCGA data retrieval, preprocessing, mixture modeling, functional enrichment, and survival analysis.

## Overview
EpiMix.data is a supporting data package for EpiMix, a tool for population-level analysis of DNA methylation. It provides CpG annotations for miRNAs and lncRNAs, toy datasets for demonstration, and methods to retrieve lncRNA expression data from TCGA via ExperimentHub. The core EpiMix workflow uses beta mixture models to identify methylation states and correlates them with gene expression to identify functional epigenetic changes.

## Data Input Requirements
The primary `EpiMix` function requires three main inputs:
1. **DNA Methylation Data**: A matrix of beta values (CpG sites in rows, samples in columns).
2. **Gene Expression Data**: A matched matrix of expression values (TPM, RPKM, etc.).
3. **Sample Annotation**: A dataframe with columns `primary` (sample IDs) and `sample.type` (e.g., "Cancer" vs "Normal").

```r
library(EpiMix)
library(EpiMix.data)

# Load example data
data(MET.data)
data(mRNA.data)
data(LUAD.sample.annotation)
```

## Analytic Modes
EpiMix supports four distinct modes for modeling different genetic elements:

*   **Regular**: Focuses on cis-regulatory elements for protein-coding genes.
*   **Enhancer**: Targets distal enhancers (requires `roadmap.epigenome.ids`).
*   **miRNA**: Targets miRNA-coding genes (requires miRNA expression data).
*   **lncRNA**: Targets lncRNA-coding genes (requires specific lncRNA expression data).

### Running the Model
```r
# Regular Mode Example
results <- EpiMix(methylation.data = MET.data,
                  gene.expression.data = mRNA.data,
                  sample.info = LUAD.sample.annotation,
                  group.1 = "Cancer",
                  group.2 = "Normal",
                  met.platform = "HM450",
                  OutputRoot = tempdir())

# Access functional pairs (CpGs associated with gene expression)
head(results$FunctionalPairs)
```

## TCGA Workflows
For TCGA data, use the one-step automated function or step-by-step functions for more control.

### One-Step TCGA Analysis
```r
EpiMixResults <- TCGA_GetData(CancerSite = "OV", 
                              mode = "Regular", 
                              outputDirectory = tempdir(),
                              cores = 10)
```

### Step-by-Step TCGA Retrieval
1. **Download**: `TCGA_Download_DNAmethylation(CancerSite, TargetDirectory)`
2. **Preprocess**: `TCGA_Preprocess_DNAmethylation(CancerSite, METdirectories)`
3. **Sample Info**: `TCGA_GetSampleInfo(METProcessedData, CancerSite)`

## Visualization and Downstream Analysis

### Plotting Mixture Models
Visualize the distribution of methylation and its correlation with expression:
```r
plots <- EpiMix_PlotModel(EpiMixResults = results, 
                          Probe = "cg14029001", 
                          methylation.data = MET.data, 
                          gene.expression.data = mRNA.data,
                          GeneName = "CCND3")
# Access: plots$MixtureModelPlot, plots$ViolinPlot, plots$CorrelationPlot
```

### Functional Enrichment
Perform GO or KEGG analysis on differentially methylated genes:
```r
enrich.results <- functionEnrich(EpiMixResults = results,
                                 methylation.state = "all",
                                 enrich.method = "GO",
                                 ont = "BP")
```

### Survival Analysis
Identify methylation-based biomarkers associated with patient survival:
```r
# Identify survival-associated probes
survival.CpGs <- GetSurvivalProbe(EpiMixResults = results, 
                                  TCGA_CancerSite = "LUAD")

# Plot Kaplan-Meier curve
EpiMix_PlotSurvival(EpiMixResults = results, 
                    plot.probe = "cg00909706",
                    TCGA_CancerSite = "LUAD")
```

## Tips
*   **Enhancer Mode**: Use `list.epigenomes()` to find valid Roadmap Epigenome IDs for the `roadmap.epigenome.ids` parameter.
*   **Batch Correction**: When using TCGA data, consider setting `doBatchCorrection = TRUE` in preprocessing, choosing between "Seurat" (fast) or "Combat" (thorough).
*   **Parallel Computing**: For large datasets, always specify the `cores` parameter in `TCGA_GetData` or `EpiMix` to speed up the mixture modeling.

## Reference documentation
- [Methylation Modeling](./references/Methylation_Modeling.Rmd)
- [Retrieve Data](./references/RetrieveData.md)