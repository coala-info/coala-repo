---
name: bioconductor-mygene
description: This tool accesses MyGene.info REST web services to query and retrieve comprehensive gene annotation data. Use when user asks to perform gene ID mapping, fetch gene metadata, search for genes by keywords or accessions, or create TxDb objects from gene lists.
homepage: https://bioconductor.org/packages/release/bioc/html/mygene.html
---


# bioconductor-mygene

name: bioconductor-mygene
description: Access MyGene.info REST web services to query and retrieve gene annotation data. Use this skill when you need to perform gene ID mapping (e.g., converting symbols to Entrez or Ensembl IDs), fetch comprehensive gene metadata, or create TxDb objects from MyGene.info data.

# bioconductor-mygene

## Overview
The `mygene` package is an R client for MyGene.info, providing high-performance access to gene-centric data. It excels at batch ID mapping and retrieving specific annotation fields (like UniProt, RefSeq, or GO terms) without needing to download large local databases.

## Core Functions

### Single Gene Retrieval
Use `getGene` to fetch data for a specific ID.
```r
library(mygene)
# Fetch all available fields for a specific Entrez ID
gene <- getGene("1017", fields="all")

# Access specific fields
gene$name
gene$taxid
```

### Batch Gene Retrieval
Use `getGenes` for multiple IDs. Returns a `DataFrame`.
```r
genes <- getGenes(c("1017", "1018", "ENSG00000148795"))
```

### Searching/Querying
Use `query` for keyword-based searches.
```r
# Search for a gene symbol
res <- query(q="cdk2", size=5)
# Access hits
hits <- res$hits

# Search by RefSeq accession
query(q="NM_013993")
```

## ID Mapping Workflow
The `queryMany` function is the primary tool for converting between different ID types (scopes).

### Mapping Symbols to Entrez/Ensembl
```r
xli <- c('DDX26B', 'CCDC83', 'MAST3')

# Map to Entrez IDs
map_entrez <- queryMany(xli, scopes="symbol", fields="entrezgene", species="human")

# Map to Ensembl IDs
map_ensembl <- queryMany(xli, scopes="symbol", fields="ensembl.gene", species="human")
```

### Handling Complex Inputs
You can provide multiple scopes if your input list is mixed (e.g., symbols and reporter IDs).
```r
mixed_ids <- c('CDK2', '1007_s_at', 'AK125780')
out <- queryMany(mixed_ids, 
                 scopes=c("symbol", "reporter", "accession"),
                 fields=c("entrezgene", "uniprot"), 
                 species="human")
```

## Advanced Usage

### Creating TxDb Objects
You can generate a `TxDb` object (from the `GenomicFeatures` package) directly from MyGene.info data for transcript-level analysis.
```r
xli <- c('CCDC83', 'MAST3', 'RPL11')
txdb <- makeTxDbFromMyGene(xli, scopes="symbol", species="human")
```

### Handling Large ID Lists
`mygene` automatically handles lists larger than 1000 IDs by batching requests (1000 at a time) and concatenating results. No manual splitting is required.

### Managing Missing or Duplicate Matches
Set `returnall=TRUE` to get a detailed report of IDs that were not found or had multiple matches.
```r
res <- queryMany(xli, scopes="symbol", fields="entrezgene", returnall=TRUE)
res$results    # The mapping table
res$missing    # IDs with no match
res$duplicates # IDs with multiple matches
```

## Tips
- **Fields**: Use `fields="all"` to see everything available, but specify exact fields (e.g., `fields="go"`) in production code for better performance.
- **Species**: Always specify the `species` (e.g., "human", "mouse", 9606) to narrow results and improve accuracy.
- **Scopes**: Common scopes include `symbol`, `entrezgene`, `ensemblgene`, `reporter`, `accession`, and `uniprot`.

## Reference documentation
- [MyGene.info R Client](./references/mygene.md)