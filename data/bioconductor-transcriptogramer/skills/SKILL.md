---
name: bioconductor-transcriptogramer
description: This tool performs transcriptional analysis by projecting gene expression data onto ordered protein-protein interaction networks to create genome-wide expression profiles. Use when user asks to analyze gene expression using transcriptograms, identify differentially expressed gene clusters, analyze protein-protein interaction network topology, or perform functional enrichment analysis on gene clusters.
homepage: https://bioconductor.org/packages/release/bioc/html/transcriptogramer.html
---


# bioconductor-transcriptogramer

name: bioconductor-transcriptogramer
description: Perform transcriptional analysis using transcriptograms. Use this skill when analyzing gene expression data by projecting it onto ordered protein-protein interaction networks to identify differentially expressed gene clusters, analyze network topology, and perform functional enrichment.

# bioconductor-transcriptogramer

## Overview
The `transcriptogramer` package implements transcriptograms—genome-wide gene expression profiles that project expression values onto a set of ordered proteins. This ordering is based on the probability of gene products participating in the same metabolic pathway. The package allows users to analyze the topological properties of Protein-Protein Interaction (PPI) networks, detect differentially expressed gene clusters, and perform Gene Ontology (GO) enrichment analysis on those clusters.

## Core Workflow

### 1. Preprocessing
The first step is creating a `Transcriptogram` object. You need an association matrix (PPI network) and an ordering of proteins.

```r
library(transcriptogramer)
# Using built-in Homo sapiens data (combined score >= 900)
t <- transcriptogramPreprocess(association = association, ordering = Hs900, radius = 50)
```

### 2. Setting the Radius
The `radius` defines the window size (radius * 2 + 1) for smoothing expression values. It significantly impacts the detection of gene clusters.

```r
# Get or set the radius
current_r <- radius(t)
radius(t) <- 80
```

### 3. Generating the Transcriptogram
This is a two-step process requiring expression data (log2-CPM for RNA-Seq or normalized microarray) and a dictionary mapping IDs to ENSEMBL Peptide IDs.

```r
# Step 1: Map expression values to proteins
t <- transcriptogramStep1(object = t, expression = GSE9988, dictionary = GPL570)

# Step 2: Apply sliding window smoothing
t <- transcriptogramStep2(object = t)
```

### 4. Differential Expression Analysis
Identify clusters of genes whose expression is altered between conditions. This uses the `limma` package internally.

```r
# levels: logical vector (TRUE for control, FALSE for case)
levels <- c(rep(FALSE, 3), rep(TRUE, 3))

# species: can be a string for biomaRt or a data.frame for mapping
t <- differentiallyExpressed(object = t, levels = levels, pValue = 0.01, species = "Homo sapiens")

# Retrieve results
de_results <- DE(t)
```

### 5. Visualization and Enrichment
Visualize the clusters as graphs and perform GO enrichment.

```r
# Graph visualization (requires Java and RedeR)
rdp <- clusterVisualization(t)

# GO Enrichment
t <- clusterEnrichment(t, species = "Homo sapiens", pValue = 0.005)

# Plot enrichment results
enrichmentPlot(t)
```

## Topological Analysis
You can analyze the underlying network properties before or after processing expression data.

*   `connectivityProperties(t)`: Calculates average graph properties based on node connectivity.
*   `orderingProperties(t)`: Calculates graph properties (like window modularity) projected on the ordered proteins.

## Key Tips
*   **ID Mapping:** The package primarily works with ENSEMBL Peptide IDs. If using other IDs, ensure your dictionary correctly maps them to ENSEMBL.
*   **Missing Values:** If a protein in the ordering lacks expression data, `transcriptogramStep2` ignores it during the sliding window calculation rather than treating it as zero.
*   **Species Data:** Built-in datasets (Hs, Mm, Sc, Rn) are available for STRINGdb versions with different confidence thresholds (700, 800, 900).

## Reference documentation
- [The transcriptogramer user's guide](./references/transcriptogramer.md)
- [The transcriptogramer user's guide (Rmd)](./references/transcriptogramer.Rmd)