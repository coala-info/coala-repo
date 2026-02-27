---
name: bioconductor-pwomics
description: bioconductor-pwomics performs pathway-based integration of matching transcriptomic and proteomic data sets to identify regulatory signaling networks. Use when user asks to perform upstream or downstream omics analysis, identify transcription factors and proteomic regulators, or infer static and dynamic consensus networks from time-series data.
homepage: https://bioconductor.org/packages/3.6/bioc/html/pwOmics.html
---


# bioconductor-pwomics

name: bioconductor-pwomics
description: Pathway-based data integration of matching omics data sets (transcriptomics and proteomics/phosphoproteomics). Use this skill for: (1) Upstream analysis to identify transcription factors and proteomic regulators from gene/transcript lists, (2) Downstream analysis to identify pathways and target genes from protein/phosphoprotein data, (3) Static and dynamic consensus network integration for single time point or time-series experiments, and (4) Identifying individual signaling axes.

# bioconductor-pwomics

## Overview

The `pwOmics` package facilitates the integration of proteomic and transcriptomic data by mapping them to biological pathways, transcription factors (TFs), and target genes. It supports both "Upstream" analysis (starting from differential gene expression to find regulators) and "Downstream" analysis (starting from differential protein abundance to find target genes). It is particularly powerful for time-series data, allowing for the inference of dynamic consensus networks.

## Data Preparation

The package requires a specific list structure for input data.

```R
# Structure for 'omics' argument in readOmics
# P = Proteomics, G = Genomics/Transcriptomics
omics_data <- list(
  P = list(
    all_ids = c("ID1", "ID2", ...), # All measured IDs
    tps = list(
      tp1 = data.frame(ID = c(...), logFC = c(...)),
      tp2 = data.frame(ID = c(...), logFC = c(...))
    )
  ),
  G = list(
    all_ids = c("ID1", "ID2", ...),
    tps = list(
      tp1 = data.frame(ID = c(...), logFC = c(...)),
      tp2 = data.frame(ID = c(...), logFC = c(...))
    )
  )
)

# Initialize OmicsData object
data_omics <- readOmics(
  tp_prots = c(0, 1, 4, 8), 
  tp_genes = c(1, 4, 8), 
  omics = omics_data,
  PWdatabase = c("kegg", "reactome"),
  TFtargetdatabase = c("chea")
)
```

## Core Workflows

### 1. Downstream Analysis (Proteins -> Target Genes)
Identifies pathways affected by proteins, the TFs within those pathways, and their regulated target genes.

```R
# 1. Identify phosphorylation influence (if phosphodata is loaded)
data_omics <- identifyPR(data_omics)

# 2. Identify pathways
data_omics <- identifyPWs(data_omics)

# 3. Identify TFs in those pathways and their target genes
data_omics <- identifyPWTFTGs(data_omics)

# Retrieve results
ds_pws <- getDS_PWs(data_omics)
ds_tgs <- getDS_TGs(data_omics)
```

### 2. Upstream Analysis (Genes -> Regulators)
Identifies TFs regulating the genes and the upstream proteomic regulators of those TFs.

```R
# 1. Identify TFs for the gene lists
data_omics <- identifyTFs(data_omics)

# 2. Identify upstream regulators of those TFs
# noTFs_inPW: min TFs in pathway to consider; order_neighbors: PPI distance
data_omics <- identifyRsofTFs(data_omics, noTFs_inPW = 1, order_neighbors = 1)

# Retrieve results
us_tfs <- getUS_TFs(data_omics)
us_regulators <- getUS_regulators(data_omics)
```

### 3. Consensus Analysis (Integration)
Combines upstream and downstream results to find overlapping signaling components.

```R
# Static Integration (Single time points)
# Uses Steiner Tree algorithm on STRING PPI to link proteins and TFs
statConsNet <- staticConsensusNet(data_omics)
plotConsensusGraph(statConsNet, data_omics)

# Dynamic Integration (Time-series)
# Uses smoothing splines and empirical Bayesian network inference (ebdbNet)
dynConsNet <- consDynamicNet(data_omics, statConsNet)
plotConsDynNet(dynConsNet, sig.level = 0.8)

# Clustering time profiles
clusters <- clusterTimeProfiles(dynConsNet)
plotTimeProfileClusters(clusters)
```

## Signaling Axis Identification
To trace the influence of a specific phosphoprotein at a specific time point:

```R
# Find axis for protein "SYK" at the second protein time point
syk_axis <- findSignalingAxes(data_omics, phosphoprot = "SYK", tpDS = 2)

# Get matching transcripts for this axis
matching_transcripts <- get_matching_transcripts(data_omics, syk_axis)
```

## Tips for Success
- **Database Loading**: `readPWdata` and `readTFdata` can be slow as they fetch data from Bioconductor's AnnotationHub. Use `loadgenelists` to point to previously saved `.RData` files to speed up subsequent runs.
- **ID Mapping**: Ensure IDs (Gene Symbols, UniProt, etc.) are consistent across your input lists and the chosen databases.
- **Steiner Tree**: The `staticConsensusNet` function uses a heuristic. Running it with `run_times > 1` (default is 3) helps find a more stable minimal graph.
- **Visualization**: Most plotting functions (`plotConsensusGraph`, `plotConsDynNet`) automatically generate PDF files in the current working directory.

## Reference documentation
- [Package ‘pwOmics’](./references/reference_manual.md)