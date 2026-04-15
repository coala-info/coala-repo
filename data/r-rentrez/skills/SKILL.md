---
name: r-rentrez
description: This tool provides an R interface to the NCBI Entrez Utilities API for searching and retrieving data from biological databases like PubMed and GenBank. Use when user asks to search NCBI databases, fetch genetic or bibliographic records, find cross-references between databases, or manage large datasets via the NCBI Web History feature.
homepage: https://cloud.r-project.org/web/packages/rentrez/index.html
---

# r-rentrez

name: r-rentrez
description: Use this skill to interact with NCBI databases (PubMed, GenBank, etc.) using the 'rentrez' R package. It provides functions for searching databases, fetching records, finding cross-references, and managing large datasets via the NCBI Web History feature. Use this skill when you need to programmatically retrieve biological or medical data from Entrez.

# r-rentrez

## Overview
The `rentrez` package provides an R interface to the NCBI Entrez Utilities (Eutils) API. It allows users to search, link, and download data from over 30 NCBI databases, including PubMed, Nucleotide (GenBank), Protein, and Taxonomy.

## Installation
To install the package from CRAN:
```R
install.packages("rentrez")
library(rentrez)
```

## Core Workflow

### 1. Explore Databases
Use these functions to understand available databases and their search fields:
- `entrez_dbs()`: List all available NCBI databases.
- `entrez_db_summary(db)`: Get a brief description of a database.
- `entrez_db_searchable(db)`: List searchable fields (e.g., `[ORGN]`, `[PDAT]`).
- `entrez_db_links(db)`: Find databases that can be linked to the target database.

### 2. Search: `entrez_search()`
Find unique IDs (UIDs) for records matching a query.
```R
# Simple search
r_search <- entrez_search(db="pubmed", term="R Language")

# Advanced search with boolean operators and fields
# Find SRA records for a specific organism from 2013-2015
sra_search <- entrez_search(db="sra", 
                            term="Tetrahymena thermophila[ORGN] AND 2013:2015[PDAT]", 
                            retmax=50)
# Access IDs
ids <- sra_search$ids
```

### 3. Summarize: `entrez_summary()`
Get brief metadata for a set of IDs.
```R
summ <- entrez_summary(db="pubmed", id=24555091)
# Extract specific fields from a list of summaries
titles <- extract_from_esummary(multi_summs, "title")
```

### 4. Fetch: `entrez_fetch()`
Download full records in specific formats (fasta, xml, gbc, etc.).
```R
# Fetch DNA sequences in fasta format
sequences <- entrez_fetch(db="nuccore", id=ids, rettype="fasta")

# Fetch and parse XML
tax_rec <- entrez_fetch(db="taxonomy", id=tax_id, rettype="xml", parsed=TRUE)
# Use XML package to extract data
name <- XML::xpathSApply(tax_rec, "//ScientificName", XML::xmlValue)
```

### 5. Link: `entrez_link()`
Find records in other databases associated with your IDs.
```R
# Find protein IDs associated with a gene ID
links <- entrez_link(dbfrom="gene", id=351, db="protein")
linked_ids <- links$links$gene_protein
```

## Advanced Features

### Web History
For large queries (thousands of IDs), use `use_history=TRUE` to store results on the NCBI server.
```R
search_hist <- entrez_search(db="nuccore", term="COI[Gene]", use_history=TRUE)
# Use the web_history object in other functions
recs <- entrez_fetch(db="nuccore", web_history=search_hist$web_history, rettype="fasta")
```

### API Keys and Rate Limits
- **Default limit**: 3 requests per second.
- **With API Key**: 10 requests per second.
- **Setup**: Obtain a key from NCBI "My Account" settings and set it in R:
  ```R
  set_entrez_key("YOUR_API_KEY")
  # Or add ENTREZ_KEY=YOUR_API_KEY to your .Renviron file
  ```

## Tips
- Use `retmax` to control the number of IDs returned (default is 20).
- Use `retstart` for pagination when downloading large datasets in chunks.
- Always check `entrez_db_searchable()` to ensure your field tags (like `[AUTH]`) are correct for the specific database.

## Reference documentation
- [Rentrez Tutorial](./references/rentrez_tutorial.Rmd)