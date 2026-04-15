---
name: bioconductor-htsanalyzer
description: This tool performs integrated gene set enrichment and network analysis for high-throughput screening data. Use when user asks to perform hypergeometric tests, conduct Gene Set Enrichment Analysis, identify enriched subnetworks from protein-protein interaction data, or generate comprehensive HTML reports for screen results.
homepage: https://bioconductor.org/packages/3.8/bioc/html/HTSanalyzeR.html
---

# bioconductor-htsanalyzer

name: bioconductor-htsanalyzer
description: Specialized analysis of high-throughput screens (HTS) using gene set enrichment and network analysis. Use this skill when performing functional annotation of HTS data, including hypergeometric tests, Gene Set Enrichment Analysis (GSEA), and identifying enriched subnetworks from protein-protein interaction data.

## Overview

HTSanalyzeR is an S4-based R package designed for the integrated analysis of high-throughput screens. It bridges the gap between raw phenotypic readouts and biological insights by combining:
1. **Gene Set Analysis**: Hypergeometric tests (overrepresentation) and GSEA (enrichment).
2. **Network Analysis**: Identification of enriched subnetworks using the BioNet algorithm.
3. **Visualization**: Generation of enrichment maps, GSEA plots, and subnetwork diagrams.

## Core Workflows

### 1. Gene Set Collection Analysis (GSCA)

The GSCA workflow identifies biological pathways or categories enriched in your screen hits or showing concordant phenotypic trends.

```r
library(HTSanalyzeR)

# 1. Prepare Inputs
# data4enrich: named numeric vector (phenotypes, e.g., z-scores)
# hits: character vector of gene IDs considered 'hits'
# ListGSC: named list of gene sets (e.g., from GOGeneSets or KeggGeneSets)

# 2. Initialize and Preprocess
gsca <- new("GSCA", listOfGeneSetCollections=ListGSC, geneList=data4enrich, hits=hits)
gsca <- preprocess(gsca, species="Dm", initialIDs="FlybaseCG", duplicateRemoverMethod="max")

# 3. Analyze
# nPermutations should be higher (e.g., 1000) for publication-quality results
gsca <- analyze(gsca, para=list(pValueCutoff=0.05, pAdjustMethod="BH", 
                                nPermutations=100, minGeneSetSize=15, exponent=1))

# 4. Summarize and Visualize
summarize(gsca)
viewGSEA(gsca, gscName="PW_KEGG", gsName="dme03010")
viewEnrichMap(gsca, resultName="GSEA.results", gscs="PW_KEGG")
```

### 2. Network Analysis (NWA)

The NWA workflow maps phenotypes/p-values onto an interactome to find functional modules.

```r
# 1. Initialize with p-values and interactome
# pvalues: named numeric vector of p-values from statistical tests
# phenotypes: named numeric vector of phenotypes (optional, for coloring)
nwa <- new("NWA", pvalues=pvalues, phenotypes=data4enrich)

# 2. Preprocess and Load Interactome
nwa <- preprocess(nwa, species="Dm", initialIDs="FlybaseCG", duplicateRemoverMethod="max")
nwa <- interactome(nwa, species="Dm", genetic=FALSE)

# 3. Analyze (fits BUM model and finds optimal subnetwork)
nwa <- analyze(nwa, fdr=0.001)

# 4. Visualize
viewSubNet(nwa)
```

### 3. Integrated Reporting

Generate comprehensive HTML reports containing all tables and figures.

```r
reportAll(gsca=gsca, nwa=nwa, experimentName="MyScreen", 
          species="Dm", allSig=TRUE, reportDir="HTS_Report")
```

## Key Functions and Parameters

- **`GOGeneSets` / `KeggGeneSets`**: Helpers to create gene set collections for supported species ("Hs", "Mm", "Rn", "Dm").
- **`preprocess`**: Essential step for both GSCA and NWA. Handles ID conversion (via `initialIDs`) and duplicate resolution.
- **`analyze(GSCA, ...)`**:
    - `minGeneSetSize`: Filters out very small/uninformative sets.
    - `exponent`: 0 for unweighted GSEA (Kolmogorov-Smirnov), 1 for weighted GSEA.
- **`analyze(NWA, ...)`**:
    - `fdr`: The False Discovery Rate used to fit the Beta-Uniform Mixture (BUM) model to p-values.

## Tips for Success

- **ID Mapping**: HTSanalyzeR primarily uses Entrez IDs internally. Ensure your `initialIDs` argument matches your input data (e.g., "SYMBOL", "FlybaseCG", "ENSEMBL").
- **Parallel Computing**: For GSEA permutations, use the `snow` package to speed up `analyze`. Set `options(cluster=makeCluster(n, "SOCK"))` before running.
- **Phenotype Direction**: In GSEA, the `geneList` should be ranked. By default, `preprocess` ranks decreasingly. If your "strongest" phenotypes are negative (e.g., growth inhibition), ensure your ranking logic reflects this.
- **cellHTS2 Integration**: If using `cellHTS2`, use `HTSanalyzeR4cellHTS2` for a streamlined wrapper that handles the transition from screen objects to analysis.

## Reference documentation

- [HTSanalyzeR-Vignette](./references/HTSanalyzeR-Vignette.md)