---
name: bioconductor-intramirexplorer
description: This tool predicts targets for Drosophila melanogaster intragenic miRNAs by integrating expression data and biophysical interactions. Use when user asks to predict miRNA targets, identify miRNAs targeting a specific gene, extract host gene relationships, or perform functional enrichment and network visualization for Drosophila.
homepage: https://bioconductor.org/packages/release/bioc/html/IntramiRExploreR.html
---


# bioconductor-intramirexplorer

name: bioconductor-intramirexplorer
description: Predicting targets for Drosophila intragenic miRNAs by integrating expression data (Pearson/Distance correlation) and biophysical interactions. Use this skill to identify miRNA-target pairs, extract host gene relationships, and perform functional enrichment or network visualization for Drosophila melanogaster.

# bioconductor-intramirexplorer

## Overview
IntramiRExploreR is a specialized tool for *Drosophila melanogaster* research that predicts targets for intragenic miRNAs. It leverages the high correlation between intragenic miRNAs and their host genes, using host gene expression as a proxy. The package integrates statistical anti-correlation (Pearson or Distance correlation) from Affymetrix microarray platforms with established biophysical target databases (TargetScan, PITA, Miranda) to provide ranked, biologically relevant target predictions.

## Core Workflows

### 1. Predicting Targets for a miRNA
Use `miRTargets_Stat` to find mRNA targets for a specific miRNA.
```r
library(IntramiRExploreR)

# Predict targets for dme-miR-12 using both correlation methods on Affy1 platform
targets <- miRTargets_Stat(miR = "dme-miR-12", 
                          method = "Both", 
                          Platform = "Affy1")
head(targets)
```

### 2. Finding miRNAs Targeting a Gene
Use `genes_Stat` to identify which miRNAs are predicted to regulate a specific gene of interest.
```r
# Find miRNAs targeting the 'Ank2' gene
mir_regulators <- genes_Stat(gene = "Ank2", 
                            geneIDType = "GeneSymbol", 
                            method = "Both", 
                            Platform = "Affy1")
```

### 3. Host Gene and miRNA Relationships
Extract the relationship between an intragenic miRNA and its host gene.
```r
# Get host gene for a miRNA
host <- extract_HostGene("dme-miR-12")

# Get intragenic miRNA for a host gene
mir <- extract_intragenic_miR("Gmap")
```

### 4. Visualization and Network Analysis
The `Visualisation` and `Gene_Visualisation` functions support network generation via `igraph` or export to Cytoscape.
```r
# Generate an igraph network for a miRNA and its top 50 targets
Visualisation(miRNA = "dme-miR-12", 
              mRNA_type = "GeneSymbol", 
              method = "Pearson", 
              platform = "Affy1", 
              thresh = 50, 
              visualisation = "igraph")
```

### 5. Gene Ontology (GO) Analysis
Perform functional enrichment on predicted target lists using `topGO` or `DAVID`.
```r
# Example using topGO for Biological Process
target_genes <- targets$Target_GeneSymbol
GetGOS_ALL(gene = target_genes, 
           GO = "topGO", 
           ontology = "GO_BP", 
           filename = "GO_results")
```

## Key Parameters
- **method**: `Pearson`, `Distance`, `Both` (union), or `BothIntersect` (intersection).
- **Platform**: `Affy1` or `Affy2` (referring to specific Drosophila Affymetrix microarray platforms).
- **geneIDType**: `GeneSymbol`, `FBGN` (FlyBase ID), or `CGID`.
- **visualisation**: `console` (returns dataframe), `igraph`, `Cytoscape`, or `text`.

## Data Resources
The package includes precomputed datasets for quick access:
- `Affy1_Pearson_Final` / `Affy1_Distance_Final`: Precomputed targets for Affy1.
- `Affy2_Pearson_Final` / `Affy2_Distance_Final`: Precomputed targets for Affy2.
- `miRNA_summary_DB`: Summary of intragenic vs intergenic status for Drosophila miRNAs.

## Reference documentation
- [IntramiRExploreR](./references/IntramiRExploreR.md)
- [IntramiRExploreR_vignettes.Rmd](./references/IntramiRExploreR_vignettes.Rmd)
- [IntramiRExploreR_vignettes.md](./references/IntramiRExploreR_vignettes.md)