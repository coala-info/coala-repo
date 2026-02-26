---
name: bioconductor-granie
description: The GRaNIE package reconstructs enhancer-mediated gene regulatory networks by integrating ATAC-seq and RNA-seq data to link transcription factors, regulatory elements, and target genes. Use when user asks to infer tripartite gene regulatory networks, identify TF-peak or peak-gene connections, integrate multi-modal genomic data, or visualize enhancer-mediated networks.
homepage: https://bioconductor.org/packages/release/bioc/html/GRaNIE.html
---


# bioconductor-granie

name: bioconductor-granie
description: Expert guidance for the GRaNIE Bioconductor package to reconstruct enhancer-mediated Gene Regulatory Networks (eGRNs). Use this skill when analyzing multi-modal genomic data (ATAC-seq/open chromatin and RNA-seq) to identify TF-peak and peak-gene links. It supports data normalization, TF activity calculation, TAD/Hi-C integration, and network visualization.

# bioconductor-granie

## Overview
The `GRaNIE` (Gene Regulatory Network Inference including Enhancers) package allows for the reconstruction of tripartite gene regulatory networks consisting of Transcription Factors (TFs), Regulatory Elements (REs/peaks), and target genes. It uses a statistical framework to infer links by correlating chromatin accessibility and gene expression across multiple samples, providing empirical FDRs for all connections.

## Core Workflow

### 1. Initialization and Data Input
Start by creating a GRN object and adding your multi-omic data.
```R
library(GRaNIE)

# Initialize object
grn <- initializeGRN(objectMetadata = list(genomeAssembly = "hg38"))

# Add ATAC-seq (peaks) and RNA-seq (counts)
# Data should have samples as columns and features as rows
grn <- addData(grn, 
               counts_peaks = peaks_df, 
               counts_rna = rna_df, 
               sampleMetadata = metadata_df,
               normalization_peaks = "DESeq2_sizeFactors",
               normalization_rna = "limma_quantile")
```

### 2. TF Binding Site (TFBS) Integration
Overlap peaks with TFBS. You can use JASPAR directly or provide custom BED files (e.g., HOCOMOCO).
```R
# Using JASPAR (requires JASPAR2024 and motifmatchr)
grn <- addTFBS(grn, source = "JASPAR", JASPAR_useSpecificTaxGroup = "homo sapiens")

# Overlap TFBS with peaks in the object
grn <- overlapPeaksAndTFBS(grn, nCores = 4)
```

### 3. Inferring Connections
The workflow identifies TF-peak links and peak-gene links independently before combining them.

```R
# TF-Peak connections (based on TF expression or TF activity)
grn <- addConnections_TF_peak(grn, connectionType = "expression", useGCCorrection = FALSE)

# Peak-Gene connections (neighborhood-based or TAD-based)
# promoterRange defines the window around the peak to look for genes
grn <- addConnections_peak_gene(grn, promoterRange = 250000)
```

### 4. Filtering and Network Construction
Combine the links into a filtered eGRN. This step performs multiple testing correction.
```R
# Filter and connect
grn <- filterGRNAndConnectGenes(grn, 
                                 TF_peak.fdr.threshold = 0.1, 
                                 peak_gene.fdr.threshold = 0.1)

# Build the graph structure for visualization/enrichment
grn <- build_eGRN_graph(grn)
```

## Visualization and Analysis
- **Network Plotting**: Use `visualizeGRN(grn)` to generate network graphs.
- **Enrichment**: Run `calculateGeneralEnrichment(grn)` for GO/KEGG/Reactome analysis on the network.
- **Connection Table**: Retrieve the final network using `getGRNConnections(grn)`.

## Key Tips
- **Sample Size**: At least 10-15 shared samples between ATAC and RNA are recommended for robust correlations.
- **Background**: GRaNIE automatically generates a background (shuffled) network (index "1") to compare against the real network (index "0").
- **TF Activity**: If TF expression is not representative, use `connectionType = "TFActivity"` in `addConnections_TF_peak` to estimate TF influence from chromatin accessibility.
- **Single-Cell**: For 10x Multiome data, aggregate cells into "pseudo-bulks" or "metacells" before running GRaNIE to overcome sparsity.

## Reference documentation
- [Package Details](./references/GRaNIE_packageDetails.md)
- [Single-cell eGRNs](./references/GRaNIE_singleCell_eGRNs.md)
- [Workflow Vignette](./references/GRaNIE_workflow.md)