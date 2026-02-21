---
name: bioconductor-genomicinteractionnodes
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/GenomicInteractionNodes.html
---

# bioconductor-genomicinteractionnodes

name: bioconductor-genomicinteractionnodes
description: Expert guidance for identifying and analyzing genomic interaction nodes (interaction hot spots) from chromatin interaction data (e.g., Hi-C, ChIA-PET) using the GenomicInteractionNodes R package. Use this skill when a user needs to define binding platforms/nodes that contain multiple interaction loops, annotate these nodes with gene promoters, or perform Gene Ontology (GO) enrichment analysis on the resulting interaction networks.

## Overview

The `GenomicInteractionNodes` package identifies "genomic interaction nodes"—binding platforms or interaction hot spots that are higher in organization than individual loops but smaller than Topologically Associating Domains (TADs). These nodes typically represent tethering elements or super-enhancer regions where multiple loops converge to regulate one or more target genes.

The core workflow involves:
1.  **Detection**: Identifying connected components and testing loop density via Poisson distribution.
2.  **Annotation**: Mapping node regions to genomic features (promoters/genes).
3.  **Enrichment**: Performing functional analysis to understand the biological role of the interaction nodes.

## Core Workflow

### 1. Data Import
The package expects interaction data, typically from BEDPE files, imported as a `Pairs` or `GRanges` object using `rtracklayer`.

```r
library(GenomicInteractionNodes)
library(rtracklayer)

# Import BEDPE file
interactions <- import(con = "path/to/your_data.bedpe", format = "bedpe")
```

### 2. Detecting Interaction Nodes
The `detectNodes` function identifies clusters of interactions that form a node.

```r
nodes <- detectNodes(interactions)

# The output is a list containing:
# nodes$node_connection: Pairs object of interactions within nodes
# nodes$nodes: GRanges of the specific node centers
# nodes$node_regions: GRanges of the regions involved in the nodes
```

### 3. Annotating Nodes
To link nodes to biological function, annotate `node_regions` with gene information using a `TxDb` and an `OrgDb` object.

```r
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)

annotated_regions <- annotateNodes(nodes$node_regions,
                                   txdb = TxDb.Hsapiens.UCSC.hg19.knownGene,
                                   orgDb = org.Hs.eg.db,
                                   upstream = 2000, 
                                   downstream = 500)
```

### 4. Enrichment Analysis
Perform GO enrichment analysis on the genes associated with the interaction nodes.

```r
library(GO.db)

enrich_results <- enrichmentAnalysis(annotated_regions, orgDb = org.Hs.eg.db)

# Access Biological Process (BP) results
bp_res <- enrich_results$enriched$BP
# Access results specific to compounds/clusters
comp_res <- enrich_results$enriched_in_compound$BP
```

## Usage Tips
- **Node Definition**: A genomic interaction node must contain multiple interaction loops and regulate at least one target gene.
- **Coordinate Systems**: Ensure your `TxDb` object matches the genome build of your input interactions (e.g., hg19 vs hg38).
- **Output Interpretation**: The `enrichmentAnalysis` function provides results for three categories: BP (Biological Process), CC (Cellular Component), and MF (Molecular Function). Use the `fdr` column to filter for significant terms.

## Reference documentation
- [GenomicInteractionNodes Guide](./references/GenomicInteractionNodes_vignettes.md)