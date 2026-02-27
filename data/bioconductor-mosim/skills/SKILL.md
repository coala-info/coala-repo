---
name: bioconductor-mosim
description: This tool simulates multi-omics datasets for bulk and single-cell experiments while incorporating biological regulatory mechanisms. Use when user asks to generate synthetic multi-omic data, simulate regulatory interactions between genes and regulators, or create experimental designs for time-series and multi-group studies.
homepage: https://bioconductor.org/packages/release/bioc/html/MOSim.html
---


# bioconductor-mosim

name: bioconductor-mosim
description: Simulates multi-omics data (bulk and single-cell) with regulatory mechanisms. Use this skill to generate synthetic datasets for RNA-seq, DNase-seq, ChIP-seq, Methyl-seq, and miRNA-seq, including regulatory interactions (TFs, methylation, etc.) and experimental designs (time-series, multiple groups).

# bioconductor-mosim

## Overview
MOSim (Multi-Omics Simulator) is an R package designed to simulate multi-omic experiments that mimic biological regulatory mechanisms. It uses RNA-seq as the central data type, with other omics (ATAC-seq, ChIP-seq, etc.) acting as regulators. It supports both bulk and single-cell (scRNA-seq, scATAC-seq) simulation, allowing for complex experimental designs including multiple groups, replicates, and time-course profiles.

## Bulk Simulation Workflow

### 1. Prepare Input Data
MOSim provides default mouse data (`sampleData`), but you can provide custom seed counts and association lists.
```r
library(MOSim)
data("sampleData")

# For custom data, use omicData helper
# data: data frame with 1 column "Counts" and feature IDs as row names
# associationList: 2 columns "ID" (regulator) and "Gene" (target)
custom_rnaseq <- omicData("RNA-seq", data = my_counts)
custom_dnase <- omicData("DNase-seq", data = my_dnase_counts, associationList = my_assocs)
```

### 2. Configure Omic Options
Use `omicSim` to define specific parameters like sequencing depth or feature counts.
```r
# Define specific options for omics
omics_options <- c(
  omicSim("RNA-seq", totalFeatures = 2000, depth = 50),
  omicSim("DNase-seq", regulatorEffect = list('activator' = 0.7, 'repressor' = 0.2, 'NE' = 0.1))
)
```

### 3. Run Simulation
The `mosim` function executes the simulation based on the experimental design.
```r
sim_result <- mosim(
  omics = c("RNA-seq", "DNase-seq"),
  times = c(0, 2, 4, 12, 24), # Time points for time-series
  numberGroups = 2,
  numberReps = 3,
  diffGenes = 0.15,           # 15% DEGs
  omicsOptions = omics_options,
  TFtoGene = TRUE             # Include Transcription Factor regulation
)
```

## Single-Cell Simulation Workflow

### 1. Setup Single-Cell Data
Use `sc_omicData` to initialize the omics types.
```r
# data = NULL uses default internal data
sc_omics <- sc_omicData(list("scRNA-seq", "scATAC-seq"), data = NULL)

# Define cell types by column indices
cell_types <- list('Treg' = c(1:10), 'cDC' = c(11:20))
```

### 2. Run Single-Cell Simulation
Use `sc_mosim` for single-cell specific parameters like clusters and fold-change thresholds.
```r
sc_sim <- sc_mosim(
  sc_omics,
  cell_types,
  numberReps = 2,
  numberGroups = 2,
  diffGenes = list(c(0.2, 0.2)), # % DEGs per omic
  clusters = 3,                  # Co-expression patterns
  TF = TRUE
)
```

## Accessing Results

### Extracting Counts and Settings
MOSim provides helper functions to retrieve data from the S4 simulation object.
```r
# Get count matrices (Bulk)
counts <- omicResults(sim_result)
rnaseq_counts <- omicResults(sim_result, "RNA-seq")

# Get simulation settings/metadata
settings <- omicSettings(sim_result)
# Get only linked regulator-gene interactions
links <- omicSettings(sim_result, "DNase-seq", only.linked = TRUE)

# Get Single-Cell results (returns Seurat objects)
sc_results <- sc_omicResults(sc_sim)
```

### Visualization and Design
```r
# Generate experimental design matrix for downstream tools (e.g., DESeq2/limma)
design <- experimentalDesign(sim_result)

# Plot expression profiles for a gene and its regulator
plotProfile(sim_result, 
            omics = c("RNA-seq", "DNase-seq"), 
            featureIDS = list("RNA-seq" = "GeneID", "DNase-seq" = "PeakID"))
```

## Tips for Success
- **RNA-seq is Mandatory**: MOSim always simulates RNA-seq as the base layer, even if not explicitly requested.
- **Identifier Matching**: When providing custom data, ensure the gene identifiers in your `associationList` match the row names of your RNA-seq seed data.
- **Transcription Factors**: TFs are treated as a subset of RNA-seq. To simulate them, provide a `TFtoGene` association table or set `TFtoGene = TRUE` to use defaults.
- **Methylation**: Unlike other omics, Methyl-seq does not require a seed count matrix; it is generated based on CpG site locations provided in the association list (`chr_start_end`).

## Reference documentation
- [Simulating bulk Multi-Omics Data with MOSim](./references/MOSim.md)
- [Simulating Single-Cell Multi-Omics Data with MOSim](./references/scMOSim.md)