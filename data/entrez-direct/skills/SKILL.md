---
name: entrez-direct
description: Entrez Direct provides a suite of Unix terminal tools for programmatically searching, retrieving, and parsing data from NCBI's Entrez databases. Use when user asks to search biological databases, link related records across databases, download sequences or abstracts, and extract specific XML fields into structured tables.
homepage: https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/versions/24.0.20250527/README
metadata:
  docker_image: "quay.io/biocontainers/entrez-direct:24.0--he881be0_0"
---

# entrez-direct

## Overview
Entrez Direct (EDirect) is a powerful suite of Unix terminal tools designed for programmatic interaction with NCBI's Entrez databases. It allows for sophisticated data mining by piping the output of one command (like a search) into another (like a filter or data fetcher). This skill provides the syntax and logic required to navigate these databases, handle XML record hierarchies, and transform raw biological data into clean, structured reports without writing complex custom scripts.

## Core Navigation Commands
EDirect operations typically follow a pipeline pattern: `esearch` (find) -> `elink` (relate) -> `efilter` (refine) -> `efetch` (download) -> `xtract` (parse).

- **esearch**: Initiates a search.
  - `esearch -db pubmed -query "long covid AND brain fog"`
  - Use bracketed fields for precision: `esearch -db nuccore -query "human [ORGN] AND insulin [PROT]"`
- **elink**: Finds related records in the same or different databases.
  - Find related articles: `elink -related`
  - Find protein sequences for a gene: `esearch -db gene -query "BRCA1" | elink -target protein`
- **efilter**: Limits existing results by date, organism, or molecule type.
  - `efilter -organism mouse -mindate 2020 -maxdate 2023`
- **efetch**: Retrieves the actual data in specific formats (abstract, fasta, xml, gbc, etc.).
  - `efetch -format fasta` or `efetch -format abstract`

## Data Extraction with xtract
The `xtract` tool is the primary method for converting NCBI's complex XML into tab-delimited tables.

### Basic Extraction
- **-pattern**: Defines the record boundary (the "row").
- **-element**: Selects the specific data field (the "column").
- **Example**: `efetch -db pubmed -id 12345 -format xml | xtract -pattern PubmedArticle -element PMID ArticleTitle`

### Handling Hierarchies (Exploration)
XML often has nested structures (e.g., multiple authors per paper). Use exploration commands to maintain data associations:
- **-block**: Creates a sub-loop within a pattern.
  - `xtract -pattern PubmedArticle -block Author -element LastName Initials` (Prints each author on a new line associated with the paper).
- **-group / -subset**: Used for deeper nesting, such as Features and Qualifiers in GenBank records.
  - Hierarchy: `-pattern` > `-group` > `-block` > `-subset` > `-element`.

### Formatting and Transformation
- **-sep**: Changes the separator for multiple instances of the same element (default is tab).
- **-tab**: Changes the column separator.
- **-first / -last**: Grabs specific instances (e.g., `-first Author`).
- **-wrp**: Wraps the output in a specific XML tag.
- **Variables**: Store a value from a higher level to use in a lower block.
  - `xtract -pattern INSDSeq -ACC INSDSeq_accession -group INSDFeature -element "&ACC" INSDFeature_key`

## Expert Tips
- **API Keys**: Always set `export NCBI_API_KEY=your_key` in the environment to allow higher request rates (up to 10 per second).
- **Piping Logic**: EDirect commands pass a "WebEnv" cookie through the pipe, meaning you only need to specify the `-db` in the initial `esearch`.
- **No Loops Needed**: EDirect is designed to handle thousands of IDs at once. Avoid writing Bash `for` loops; instead, pipe a list of IDs or a search result directly into `efetch`.
- **Complex Parsing**: Use `transmute -j2x` if you encounter JSON data that needs to be converted to XML for `xtract` processing.



## Subcommands

| Command | Description |
|---------|-------------|
| efetch | Fetch records from NCBI databases. |
| efilter | Filters search results based on various criteria. |
| elink | Finds links between records in different databases or within the same database. |
| esearch | Query Specification |
| nquire | Query Commands |
| xtract | Xtract uses command-line arguments to convert XML data into a tab-delimited table. |

## Reference documentation
- [ENTREZ DIRECT: COMMAND LINE ACCESS TO NCBI ENTREZ DATABASES](./references/anaconda_org_channels_bioconda_packages_entrez-direct_overview.md)
- [Entrez Direct README](./references/ftp_ncbi_nlm_nih_gov_entrez_entrezdirect_versions_24.0.20250527_README.md)