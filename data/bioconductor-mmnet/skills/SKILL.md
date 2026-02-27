---
name: bioconductor-mmnet
description: This tool performs metagenomic analysis of microbiome metabolic networks by integrating sequence annotation with network modeling. Use when user asks to annotate metagenomic reads via MG-RAST, estimate enzymatic gene abundances, construct state-specific metabolic networks, or perform differential network analysis.
homepage: https://bioconductor.org/packages/3.5/bioc/html/mmnet.html
---


# bioconductor-mmnet

name: bioconductor-mmnet
description: Metagenomic analysis of microbiome metabolic networks. Use this skill to annotate metagenomic reads via MG-RAST, estimate enzymatic gene abundances, construct State Specific Networks (SSN), and perform topological or differential network analysis between different biological states (e.g., disease vs. healthy).

## Overview

The `mmnet` package provides a computational framework for metagenomic systems biology. It allows users to transition from raw metagenomic sequence data to functional metabolic networks. Key capabilities include MG-RAST integration for annotation, abundance estimation of KEGG Orthology (KO) groups, and comparative network analysis to identify metabolic shifts associated with specific physiological states.

## Installation and Setup

Install the package via BiocManager:

```R
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("mmnet")
library(mmnet)
```

## Core Workflow

### 1. Functional Annotation (MG-RAST Integration)
`mmnet` interfaces with MG-RAST for sequence annotation. This requires a registered account.

```R
# Login and upload
login.info <- loginMgrast(user = "username", userpwd = "password")
metagenome.id <- uploadMgrast("sample.fna.gz", login.info = login.info)

# Submit and check status
job.id <- submitMgrastJob("sample.fna.gz", login.info = login.info)
status <- checkMgrastMetagenome(metagenome.id = job.id)

# Retrieve results
anno_data <- getMgrastAnnotation(job.id, login.info = login.info)
```

### 2. Estimating Gene Abundance
Convert annotation profiles into enzymatic gene abundance matrices in BIOM format.

```R
# Using internal normalization and calibration
mmnet.abund <- estimateAbundance(anno_data)

# Accessing the data
library(biomformat)
matrix_data <- biom_data(mmnet.abund)
```

### 3. Constructing State Specific Networks (SSN)
Map abundances onto the KEGG reference metabolic network.

```R
# Load reference data first
loadMetabolicData() 

# Construct SSN from abundance data
ssn <- constructSSN(mmnet.abund)
# ssn is a list of igraph objects
g <- ssn[[1]]
```

### 4. Network Analysis
Perform topological analysis or compare networks across different states (e.g., "obese" vs "lean").

```R
# Topological analysis (Betweenness, Degree, PageRank)
topo.results <- topologicalAnalyzeNet(g)

# Differential analysis
# method: "OR" (Odds Ratio), "DR" (Difference Rank), or "JSD" (Jensen-Shannon Divergence)
diff.net <- differentialAnalyzeNet(ssn, 
                                   sample.state = c("state1", "state2"), 
                                   method = "OR", 
                                   cutoff = c(0.5, 2))
```

### 5. Visualization
Visualize networks directly in R or prepare them for Cytoscape.

```R
# R Visualization
showMetagenomicNet(g, mode = "ssn", vertex.label = NA)

# For Cytoscape (requires RCytoscape and running Cytoscape instance)
# Convert igraph to graphNEL
library(RCytoscape)
net_nel <- igraph.to.graphNEL(g)
# Follow RCytoscape workflow to displayGraph()
```

## Tips and Best Practices
- **Reference Data**: Always run `loadMetabolicData()` before constructing networks. You can update the local KEGG cache using `updateMetabolicNetwork()`.
- **Custom Data**: If you have local BLAST/KEGG annotations, format them into a 13-column data frame (matching MG-RAST output) to use `estimateAbundance()`.
- **Abundance Calibration**: `mmnet` applies a threshold (default 2 reads) to reduce error rates in low-abundance gene identification.

## Reference documentation
- [mmnet: Metagenomic analysis of microbiome metabolic network](./references/mmnet.md)