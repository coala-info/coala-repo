---
name: bioconductor-netdx
description: netDx is a machine learning framework that builds patient classifier models by integrating heterogeneous biological data through Patient Similarity Networks. Use when user asks to perform multi-omic data integration, build binary or multi-class predictors, or conduct feature selection based on biological pathways.
homepage: https://bioconductor.org/packages/3.11/bioc/html/netDx.html
---


# bioconductor-netdx

name: bioconductor-netdx
description: Expert guidance for using the netDx Bioconductor package to build patient classifier models using Patient Similarity Networks (PSN). Use this skill when performing multi-omic data integration, feature selection based on biological pathways, and building binary or multi-class predictors from clinical, genomic, or sparse genetic data (like CNVs).

# bioconductor-netdx

## Overview
netDx is a machine learning framework that utilizes Patient Similarity Networks (PSN) to integrate heterogeneous biological data. Instead of treating features as individual variables, netDx converts data layers into networks where nodes are patients and edges represent similarity. It performs feature selection to identify networks (e.g., pathways) that consistently distinguish patient classes and integrates these into a final predictor.

## Core Workflow

### 1. Data Preparation
Data must be organized into a `MultiAssayExperiment` object. The `colData` slot must contain two specific columns:
- `ID`: Unique patient identifiers.
- `STATUS`: Patient labels/classes (e.g., "LumA", "notLumA").

### 2. Defining Grouping Rules (`groupList`)
The `groupList` defines how variables are grouped into features (networks).
- **Pathways:** Use `readPathways()` and `fetchPathwayDefinitions()` to group gene-level data into pathway-level features.
- **Clinical:** Usually defined as single-variable features.
- **Whole Layer:** Group all probes/proteins into a single feature for that assay.

```r
groupList <- list()
pathList <- readPathways(fetchPathwayDefinitions("January", 2018))
groupList[["mRNA_Assay"]] <- pathList[1:100] 
groupList[["clinical"]] <- list(age="age_column", stage="stage_column")
```

### 3. Custom Similarity Function (`makeNetFunc`)
You must define a function that tells netDx how to compute similarity for different data types.
- **Continuous Data:** Typically uses Pearson correlation via `makePSN_NamedMatrix(..., writeProfiles=TRUE)`.
- **Clinical/Categorical:** Often uses normalized difference (`simMetric="custom"`, `customFunc=normDiff`).

```r
makeNets <- function(dataList, groupList, netDir, ...) {
    netList <- c()
    # mRNA similarity (Pearson)
    if (!is.null(groupList[["mRNA"]])) {
        netList <- makePSN_NamedMatrix(dataList[["mRNA"]], rownames(dataList[["mRNA"]]),
                                     groupList[["mRNA"]], netDir, ...)
    }
    # Clinical similarity (Normalized Difference)
    if (!is.null(groupList[["clinical"]])) {
        netList2 <- makePSN_NamedMatrix(dataList$clinical, rownames(dataList$clinical),
                                      groupList[["clinical"]], netDir,
                                      simMetric="custom", customFunc=normDiff, ...)
    }
    return(c(unlist(netList), unlist(netList2)))
}
```

### 4. Building the Predictor
Use `buildPredictor()` for standard data or `buildPredictor_sparseGenetic()` for sparse data like CNVs.
- `numSplits`: Number of train/test iterations (e.g., 100 for production, 2-10 for testing).
- `featScoreMax`: Max score a feature can get in one split (usually 10).
- `featSelCutoff`: Threshold for a feature to be used in prediction (e.g., 9).

```r
out <- buildPredictor(
    dataList=brca, groupList=groupList, makeNetFunc=makeNets,
    outDir=tempdir(), numSplits=10L, featScoreMax=10L, featSelCutoff=9L
)
```

## Sparse Genetic Data (CNVs/Mutations)
For sparse data, similarity is binary (1 if patients share a mutation in a pathway, 0 otherwise).
- Use `buildPredictor_sparseGenetic()`.
- Enable `enrichLabels=TRUE` to perform permutation testing, which reduces false positives by ensuring selected pathways are statistically enriched for the target label.

## Interpreting Results
- **Performance:** Use `plotPerf(predList)` to generate ROC and Precision-Recall curves.
- **Feature Selection:** Use `getNetConsensus()` and `callFeatSel()` to identify pathways that consistently scored high across splits.
- **Visualization:** 
    - `getEMapInput_many()`: Prepares data for EnrichmentMap (Cytoscape).
    - `plotIntegratedPatientNetwork()`: Creates a master PSN of top features.
    - `plot_tSNE()`: Visualizes patient clustering based on the integrated network.

## Reference documentation
- [BuildPredictor](./references/BuildPredictor.md)
- [Predict_CaseControl_from_CNV](./references/Predict_CaseControl_from_CNV.md)
- [ThreeWayClassifier](./references/ThreeWayClassifier.md)