---
name: bioconductor-biomartgogenesets
description: This tool provides pre-compiled Gene Ontology gene sets and genomic coordinates for over 700 organisms supported by BioMart. Use when user asks to retrieve GO gene sets, fetch gene annotations as GRanges, identify supported organisms, or map between different sequence naming styles.
homepage: https://bioconductor.org/packages/release/data/annotation/html/BioMartGOGeneSets.html
---


# bioconductor-biomartgogenesets

name: bioconductor-biomartgogenesets
description: Provides pre-compiled Gene Ontology (GO) gene sets and gene coordinates for over 700 organisms supported by BioMart (Ensembl). Use this skill to retrieve GO gene sets (BP, CC, MF), fetch gene annotations as GRanges, and map between different sequence naming styles (e.g., GenBank to UCSC) for various species including vertebrates, plants, fungi, metazoa, and protists.

# bioconductor-biomartgogenesets

## Overview
The `BioMartGOGeneSets` package simplifies the acquisition of Gene Ontology (GO) gene sets and gene annotations by providing pre-compiled data from BioMart. It eliminates the need for manual BioMart queries and complex GO tree merging (parent-child term relationships) for hundreds of organisms.

## Core Workflows

### 1. Identifying Supported Organisms
Before retrieving data, identify the correct "dataset" name for your organism.
```r
library(BioMartGOGeneSets)

# List all supported organisms
orgs <- supportedOrganisms()

# Search for a specific organism (e.g., human)
# You can use common names, scientific names, or taxon IDs
getBioMartGenes("human") # Partial matching works
getBioMartGenes(9606)    # Taxon ID for human
```

### 2. Retrieving Gene Sets
Use `getBioMartGOGeneSets()` to fetch GO terms and their associated genes.
```r
# Get Biological Process (BP) gene sets for Mouse (Ensembl IDs)
gs_list <- getBioMartGOGeneSets("mmusculus_gene_ensembl", ontology = "BP")

# Return as a data frame instead of a list
gs_table <- getBioMartGOGeneSets("mmusculus_gene_ensembl", as_table = TRUE)

# Specify gene ID type (if supported by the organism)
gs_symbols <- getBioMartGOGeneSets("hsapiens", gene_id_type = "gene_symbol")
gs_entrez  <- getBioMartGOGeneSets("hsapiens", gene_id_type = "entrez_gene")
```
*Note: Available ontologies are "BP", "CC", and "MF".*

### 3. Retrieving Gene Annotations (GRanges)
Use `getBioMartGenes()` to get genomic coordinates and metadata.
```r
# Fetch human genes
genes <- getBioMartGenes("hsapiens_gene_ensembl")

# Add 'chr' prefix for UCSC compatibility
genes_ucsc <- getBioMartGenes("hsapiens", add_chr_prefix = TRUE)
```

### 4. Handling Sequence Name Styles
For non-model organisms with non-standard chromosome names (e.g., GenBank accessions), use `changeSeqnameStyle()`.
```r
# Check available styles for a dataset
info <- getBioMartGenomeInfo("cporcellus_gene_ensembl")
print(info$seqname_style)

# Convert from GenBank-Accn to Sequence-Name
gr_new <- changeSeqnameStyle(gr, "cporcellus_gene_ensembl",
    seqname_style_from = "GenBank-Accn",
    seqname_style_to = "Sequence-Name")
```

## Manual Retrieval (Advanced)
If you need the most recent data not yet in the pre-compiled package, the package provides a script template for manual retrieval using `biomaRt` and `GO.db`.
```r
# Locate the manual retrieval script
script_path <- system.file("scripts", "biomart_genesets.R", package = "BioMartGOGeneSets")
```

## Tips and Troubleshooting
- **Timeout Errors**: If performing manual queries via `biomaRt` and encountering timeouts, try switching mirrors: `useEnsembl(biomart = "genes", mirror = "uswest")`.
- **Empty Gene Sets**: The package automatically removes empty GO gene sets after merging offspring terms into parent terms.
- **Dataset Names**: Always verify the dataset string (e.g., `hsapiens_gene_ensembl`) using `supportedOrganisms()` if partial matching fails.

## Reference documentation
- [Retrieve GO Gene Sets from BioMart](./references/biomart.md)
- [Pre-compiled GO Gene Sets](./references/genesets.md)
- [BioMart Gene Ontology Gene Sets Collections](./references/supported_organisms.md)
- [Versions](./references/version.md)