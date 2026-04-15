---
name: bioconductor-ritandata
description: This package provides a curated collection of gene sets, pathway annotations, and protein-protein interaction networks for functional enrichment and network biology workflows. Use when user asks to access standardized gene sets, retrieve pathway annotations, or load protein-protein interaction networks for enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/RITANdata.html
---

# bioconductor-ritandata

## Overview

RITANdata is a specialized data-experiment package for R that serves as the data backbone for the RITAN package. It contains a comprehensive collection of curated gene sets, pathway annotations, and protein-protein interaction (PPI) networks. By providing these resources in a standardized format, it enables rapid functional enrichment and network biology workflows without requiring manual downloading and formatting of external databases.

## Loading Data Resources

To use the resources within RITANdata, first load the library:

```r
library(RITANdata)
```

### Genesets and Pathways
The primary container for annotation resources is the `geneset_list` object. It is a named list where each element contains gene symbols for a specific resource.

```r
# View available annotation resources
names(geneset_list)

# Access a specific resource (e.g., MSigDB Hallmarks)
hallmarks <- geneset_list$MSigDB_Hallmarks
```

Available resources include:
- **MSigDB**: Hallmarks, C2 (Curated), C3 (TF/miRNA), C5 (GO), C7 (Immunologic).
- **Gene Ontology (GO)**: Full GO and Slim versions (PIR, generic).
- **Pathways**: Reactome, Pathway Commons, KEGG (filtered canonical).
- **Specialized Modules**: Chaussabel Modules, Blood Translation Modules, DisGeNet.

### Network Resources
The `network_list` object contains 6 human network-biology resources used for interaction analysis.

```r
# View available networks
names(network_list)

# Check metadata and citations for networks
kable(attr(network_list, 'network_data_sources'))
```

Supported networks include PID, TFe, dPPI, HPRD, CCSB, STRING, HumanNet, BioGrid, and ChEA. Note that some data is retrieved via helper packages like `ProNet` or `STRINGdb`.

## Background Gene Lists

For accurate enrichment analysis, defining the "universe" of genes (background) is critical. RITANdata provides a cached list of human protein-coding genes to avoid unnecessary downloads.

```r
# Use the cached coding genes as a background for enrichment
data(cached_coding_genes)
# This object contains a character vector of gene symbols
head(cached_coding_genes)
```

## Typical Workflow with RITAN

RITANdata is almost always used in conjunction with the `RITAN` package functions.

1. **Identify Input**: Start with a list of differentially expressed genes (symbols).
2. **Select Resource**: Choose a geneset from `geneset_list`.
3. **Run Enrichment**: Use RITAN functions (like `enrichment_analysis`) passing the data from RITANdata.
4. **Network Overlay**: Use `network_list` to identify interactions between the input genes.

## Usage Tips
- **Citations**: Always cite the specific resource used (e.g., MSigDB, Reactome) as stored in the `network_data_sources` attribute.
- **Gene Symbols**: Ensure your input data uses Gene Symbols (e.g., "TP53"), as the resources in RITANdata are indexed by symbol.
- **MSigDB**: If using MSigDB resources, ensure you are registered at the Broad Institute MSigDB website.

## Reference documentation
- [Introduction to RITANdata](./references/RITANdata.md)