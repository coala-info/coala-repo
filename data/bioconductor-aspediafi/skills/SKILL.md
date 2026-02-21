---
name: bioconductor-aspediafi
description: The Bioconductor project aims to develop and share open source software for precise and repeatable analysis of biological data. We foster an inclusive and collaborative community of developers and data scientists.
homepage: https://bioconductor.org/packages/3.10/bioc/html/ASpediaFI.html
---

# bioconductor-aspediafi

name: bioconductor-aspediafi
description: Functional interaction analysis of alternative splicing (AS) events. Use this skill to detect, quantify, and analyze the functional impact of alternative splicing using RNA-Seq data. It integrates AS events, gene expression, and pathway information into a heterogeneous network to rank features using the DRaWR algorithm.

# bioconductor-aspediafi

## Overview
ASpediaFI is a specialized R package for the integrative analysis of alternative splicing. It moves beyond simple differential splicing detection by building a heterogeneous network of genes, AS events, and pathways. By applying a Discriminative Random Walk with Restart (DRaWR) algorithm, it identifies which AS events and biological pathways are most relevant to a specific gene set of interest (e.g., differentially expressed genes).

## Core Workflow

### 1. Initialization and Annotation
Create the `ASpediaFI` object and annotate AS events from a GTF file.
```R
library(ASpediaFI)

# Initialize with sample metadata
# Columns: name, BAM path, condition
samples <- data.frame(
  name = c("Sample1", "Sample2"),
  path = c("path/to/1.bam", "path/to/2.bam"),
  condition = c("MUT", "WT")
)
af_obj <- ASpediaFI(sample.names = samples$name, 
                    bam.files = samples$path, 
                    conditions = samples$condition)

# Detect AS events (A5SS, A3SS, SE, MXE, RI)
af_obj <- annotateASevents(af_obj, gtf.file = "reference.gtf", num.cores = 1)
```

### 2. Quantification
Compute Percent Spliced In (PSI) values from BAM files.
```R
af_obj <- quantifyPSI(af_obj, read.type = "paired", read.length = 100, 
                      insert.size = 300, min.reads = 3)
```

### 3. Functional Interaction Analysis
Construct the network and run DRaWR. This requires a "query" gene set (e.g., DEGs from `limma` or `DESeq2`).
```R
# query: character vector of gene symbols
af_obj <- analyzeFI(af_obj, query = query_genes, 
                    expr = gene_expression_matrix, 
                    restart = 0.9, 
                    num.feats = 200, 
                    cor.threshold = 0.3)
```

### 4. Results and Reporting
Extract ranked tables for AS events and pathways.
```R
# Get ranked AS events
as_results <- as.table(af_obj)

# Get ranked pathways (includes GSEA results if conditions were provided)
pathway_results <- pathway.table(af_obj)

# Export network for Cytoscape
exportNetwork(af_obj, node = "HALLMARK_HEME_METABOLISM", file = "output.gml")
```

### 5. Visualization
Visualize specific AS events (genomic structure + PSI boxplot) or pathway-specific subnetworks.
```R
# Visualize an AS event
visualize(af_obj, node = "GENE:SE:chr:start:end...", zoom = FALSE)

# Visualize a pathway subnetwork
visualize(af_obj, node = "HALLMARK_P53_PATHWAY", n = 10)
```

## Key Slots and Accessors
- `samples(af_obj)`: Access sample metadata.
- `events(af_obj)`: Access detected AS event annotations.
- `psi(af_obj)`: Access the SummarizedExperiment containing PSI values.
- `network(af_obj)`: Access the resulting igraph object.

## Tips for Success
- **Query Selection**: The quality of the DRaWR output depends heavily on the query gene set. Use robustly differentially expressed genes or genes known to be involved in the process under study.
- **Filtering**: `analyzeFI` has parameters like `low.expr`, `low.var`, and `prop.na` to filter out uninformative AS events before network construction.
- **Memory**: Quantification and network analysis can be memory-intensive; use `num.cores` to manage parallel processing.

## Reference documentation
- [ASpediaFI: Functional Interaction Analysis of AS Events](./references/ASpediaFI.md)