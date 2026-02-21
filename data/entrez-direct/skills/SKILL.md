---
name: entrez-direct
description: Entrez Direct (EDirect) is a powerful suite of command-line tools designed to interface with the National Center for Biotechnology Information (NCBI) Entrez system.
homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
---

# entrez-direct

## Overview
Entrez Direct (EDirect) is a powerful suite of command-line tools designed to interface with the National Center for Biotechnology Information (NCBI) Entrez system. It allows for the construction of sophisticated, multi-step biological queries by piping the output of one command into another. This skill enables the automated retrieval of publications, sequences, structures, and gene information directly from a UNIX terminal, bypassing the need for manual web-based searches.

## Core Commands and Usage Patterns

The EDirect workflow typically follows a sequence: **Search -> Filter/Link -> Fetch -> Extract**.

### 1. Searching (esearch)
Use `esearch` to initiate a query. It returns a "WebEnv" cookie that maintains the state of your search for subsequent commands.
- **Basic Search**: `esearch -db pubmed -query "CRISPR AND 2023[pdat]"`
- **Database Selection**: Common databases include `pubmed`, `nuccore` (sequences), `protein`, `gene`, and `taxonomy`.

### 2. Filtering and Linking (efilter, elink)
- **efilter**: Refine an existing search result (e.g., by date or organism).
  - `esearch -db nuccore -query "HSP70" | efilter -organism "Homo sapiens"`
- **elink**: Find related records in other NCBI databases.
  - `esearch -db gene -query "BRCA1" | elink -target protein` (Finds proteins associated with the BRCA1 gene).

### 3. Data Retrieval (efetch)
Use `efetch` to download the actual records in specific formats.
- **Common Formats**: `fasta`, `gb` (GenBank), `abstract`, `xml`, `json`.
- **Example**: `esearch -db nuccore -query "NM_000602" | efetch -format fasta`

### 4. Data Parsing (xtract)
`xtract` is the primary tool for converting NCBI's complex XML output into clean, tab-delimited text.
- **Pattern Matching**: Use `-pattern` to define the XML block and `-element` to pick specific fields.
- **Example**: Extracting PubMed titles and years:
  `esearch -db pubmed -query "biopython" | efetch -format xml | xtract -pattern PubmedArticle -element MedlineCitation/Article/ArticleTitle PubDate/Year`

## Expert Tips and Best Practices

- **Piping Efficiency**: Always pipe `esearch` to `efetch` or `elink` to avoid downloading large intermediate files. EDirect handles the "WebEnv" session automatically across pipes.
- **API Keys**: For high-volume queries (more than 3 requests per second), set the `NCBI_API_KEY` environment variable to increase the limit to 10 requests per second.
- **Complex Queries**: Use the `-query` argument with standard Entrez boolean logic (AND, OR, NOT) and field tags like `[ORGN]` for organism or `[AUTH]` for author.
- **Recursive Extraction**: In `xtract`, use `-block` and `-element` hierarchically to handle nested XML structures, such as multiple authors per paper.
- **Validation**: Use `nquire -url ...` to test raw E-utility URLs if a specific EDirect command is behaving unexpectedly.

## Reference documentation
- [Entrez Direct (EDirect) Overview](./references/anaconda_org_channels_bioconda_packages_entrez-direct_overview.md)