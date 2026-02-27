---
name: bioconductor-compran
description: This tool analyzes SILAC-labeled complexome profiling data to compare protein migration profiles across biological states. Use when user asks to process mass spectrometry data from blue native electrophoresis, estimate protein intensities from peptides, normalize migration profiles, or perform hierarchical clustering to identify protein complexes.
homepage: https://bioconductor.org/packages/release/bioc/html/ComPrAn.html
---


# bioconductor-compran

name: bioconductor-compran
description: Analysis of SILAC-labeled complexome profiling data. Use this skill to process mass spectrometry data from blue native electrophoresis (BN-PAGE) or density gradients, estimate protein intensities from peptides, normalize migration profiles, and perform hierarchical clustering to identify protein complexes.

# bioconductor-compran

## Overview

The `ComPrAn` (Complexome Profiling Analysis) package is designed for the analysis of SILAC-labeled complexomics data. It facilitates the comparison of protein migration profiles across fractions between two biological states (Heavy and Light). The package supports two primary entry points: a full peptide-to-protein workflow and a protein-only workflow for pre-normalized data.

## Core Workflows

### 1. Peptide-to-Protein Workflow
Use this workflow when starting with peptide-level quantification (e.g., from Proteome Discoverer).

```r
library(ComPrAn)

# 1. Import and Clean
peptides <- peptideImport("path/to/data.txt")
peptides <- cleanData(peptides, fCol = "Search ID")
peptides <- toFilter(peptides, rank = 1)
peptides <- splitModLab(peptides)
peptides <- simplifyProteins(peptides)

# 2. Representative Peptide Selection
# Scenario A: For co-migration (different peptides allowed for H and L)
# Scenario B: For quantitative comparison (same peptide for H and L)
peptide_index <- pickPeptide(peptides)

# 3. Normalization
forAnalysis <- getNormTable(peptide_index, purpose = "analysis")
forExport <- getNormTable(peptide_index, purpose = "export")
```

### 2. Protein-Only Workflow
Use this workflow if you already have a table of normalized protein intensities.

```r
# Import pre-normalized data
forAnalysis <- protImportForAnalysis("path/to/dataNormProts.txt")
```

### 3. Clustering Analysis
Identify co-migrating proteins using hierarchical clustering based on Pearson correlation.

```r
# Create clustering components (Scenario A is typical for co-migration)
clusteringDF <- clusterComp(forAnalysis, scenar = "A", PearsCor = "centered")

# Assign clusters using a specific linkage method and correlation cutoff
labTab_clust <- assignClusters(clusteringDF, sample = "labeled", method = 'average', cutoff = 0.85)
unlabTab_clust <- assignClusters(clusteringDF, sample = "unlabeled", method = 'average', cutoff = 0.85)

# Export results
tableForClusterExport <- exportClusterAssignments(labTab_clust, unlabTab_clust)
```

## Visualization Functions

- `allPeptidesPlot(peptide_index, proteinID, max_frac)`: Scatter plot of all peptides for a specific protein.
- `proteinPlot(data, proteinID, max_frac)`: Line plot showing migration profiles for Heavy vs Light.
- `groupHeatMap(data, groupData, groupName)`: Heatmap for a specific set of proteins (e.g., a known complex).
- `oneGroupTwoLabelsCoMigration(data, max_frac, groupVector, groupName)`: Compare migration of one group across labels.
- `twoGroupsWithinLabelCoMigration(...)`: Compare two different protein groups within a single label state.
- `makeBarPlotClusterSummary(clusteredTable, name)`: Summary of protein counts per cluster.

## Key Scenarios
- **Scenario A**: Normalizes each label state to its own maximum (0 to 1). Best for comparing the *shape* of migration profiles (co-migration).
- **Scenario B**: Normalizes to the maximum across both label states. Best for *quantitative* comparison of protein abundance between samples.

## Reference documentation
- [SILAC complexomics](./references/SILACcomplexomics.md)
- [Input File Description](./references/fileFormats.md)
- [Protein workflow](./references/proteinWorkflow.md)