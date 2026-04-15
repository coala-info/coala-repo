---
name: bioconductor-keggrest
description: This tool provides a client interface to the KEGG REST API for retrieving and searching biological pathways, genes, compounds, and organisms. Use when user asks to retrieve KEGG database entries, convert identifiers between KEGG and external databases, search for chemical compounds by mass or formula, or link genes to metabolic pathways.
homepage: https://bioconductor.org/packages/release/bioc/html/KEGGREST.html
---

# bioconductor-keggrest

name: bioconductor-keggrest
description: Access the KEGG REST API for biological pathways, genes, compounds, and organisms. Use this skill when you need to retrieve KEGG data, convert identifiers (e.g., NCBI to KEGG), search for chemical compounds by mass or formula, or link genes to metabolic pathways within R.

## Overview

The `KEGGREST` package provides a client interface to the KEGG REST API. It allows for programmatic searching, listing, and retrieval of KEGG database entries. It is the modern replacement for the deprecated `KEGGSOAP` package.

## Core Functions

The package is built around six primary operations:

- `keggList()`: Browse databases or list organisms.
- `keggGet()`: Retrieve detailed records (including sequences and images).
- `keggFind()`: Search for entries by keyword, formula, or mass.
- `keggConv()`: Convert between KEGG IDs and outside IDs (NCBI, UniProt).
- `keggLink()`: Find relationships between different KEGG databases (e.g., genes to pathways).
- `keggInfo()`: Get statistics and version information for a specific database.

## Common Workflows

### 1. Exploring Databases and Organisms
To see available databases or find a specific organism code (e.g., "hsa" for human):

```r
library(KEGGREST)

# List all available KEGG databases
listDatabases()

# Find the organism code for a species
orgs <- keggList("organism")
# Search for 'human' in the organism list
orgs[grep("human", orgs[,3]), ]
```

### 2. Searching and Retrieving Data
Search for genes or compounds and then fetch the full record.

```r
# Search for genes related to "shiga toxin"
genes <- keggFind("genes", "shiga toxin")

# Get detailed information for specific IDs (Max 10 IDs per call)
query <- keggGet(c("hsa:10458", "ece:Z5100"))

# Access specific fields in the result list
query[[1]]$PATHWAY
query[[1]]$DBLINKS
```

### 3. Working with Sequences and Images
`keggGet` can return specialized Bioconductor objects or raw image data.

```r
# Get Amino Acid sequences as AAStringSet
aa_seqs <- keggGet(c("hsa:10458"), "aaseq")

# Get Nucleotide sequences as DNAStringSet
nt_seqs <- keggGet(c("hsa:10458"), "ntseq")

# Download a pathway map image
img <- keggGet("hsa05130", "image")
writePNG(img, "pathway.png")
```

### 4. ID Conversion and Cross-Linking
Map external identifiers to KEGG or link genes to their respective pathways.

```r
# Convert NCBI Gene IDs to KEGG IDs for E. coli
conv <- keggConv("eco", "ncbi-geneid")

# Find all pathways associated with specific genes
pathways <- keggLink("pathway", c("hsa:10458", "ece:Z5100"))
```

### 5. Chemical Property Searches
Search the `compound` database using molecular weight or formulas.

```r
# Search by exact mass (with tolerance based on decimals)
keggFind("compound", 174.05, "exact_mass")

# Search by chemical formula
keggFind("compound", "C7H10O5", "formula")
```

## Tips and Limitations
- **API Limits**: `keggGet()` is restricted to a maximum of 10 identifiers per request by the KEGG server. For larger lists, use a loop or `lapply` with `split()`.
- **Academic Use**: The KEGG API is intended for academic use.
- **Identifier Format**: KEGG identifiers usually follow the `prefix:ID` format (e.g., `hsa:10458` or `cpd:C00493`).

## Reference documentation

- [Accessing the KEGG REST API](./references/KEGGREST-vignette.md)