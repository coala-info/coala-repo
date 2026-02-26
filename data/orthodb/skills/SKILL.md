---
name: orthodb
description: The orthodb tool provides a programmatic interface to the OrthoDB REST API for mapping genes to orthologous groups and performing evolutionary analysis across taxonomic levels. Use when user asks to find orthologs, search for genes by sequence or keyword, retrieve protein sequences in FASTA format, or analyze gene conservation and functional annotations across species.
homepage: https://www.ezlab.org/orthodb_v12_userguide.html
---


# orthodb

## Overview
The `orthodb` skill provides a programmatic interface to the OrthoDB REST API, allowing for high-throughput evolutionary analysis. It enables the mapping of genes to orthologous groups at specific taxonomic radiations (levels of orthology). This tool is essential for determining gene conservation, copy-number variations (single-copy vs. multi-copy), and functional descriptions across thousands of species.

## API Usage and Patterns

The `orthodb` Python interface and REST API follow a specific command structure. Use the following patterns for common genomic queries:

### Core Search Commands
- **Text Search**: Find OGs using keywords, identifiers (UniProt, Ensembl, RefSeq), or functional terms.
  - Pattern: `/search?query=kinase&level=33208` (where level is an NCBI TaxID).
  - Logic: Use `!` for NOT, `|` for OR, and double quotes for exact phrases (e.g., `"Cytochrome P450"`).
- **Gene Search**: Retrieve a gene-centric view for a specific identifier.
  - Pattern: `/genesearch?query=P12345`
- **Sequence Search (BLAST)**: Find orthologs by protein sequence homology.
  - Pattern: `/blast` (requires POSTing the amino acid sequence without headers).

### Data Retrieval
- **Orthologs**: Get all member genes of a specific Orthologous Group.
  - Pattern: `/orthologs?id=12345at33208`
- **FASTA**: Download sequences for all genes in a group.
  - Pattern: `/fasta?id=12345at33208`
- **OG Details**: Get functional annotations, evolutionary rates, and gene architecture (exon counts/protein length).
  - Pattern: `/ogdetails?id=12345at33208`

### Navigation and Phylogeny
- **Levels of Orthology**: OrthoDB is hierarchical. To get more specific (fine-grained) groups, use a lower taxonomic level (e.g., *Mammalia*). To get more inclusive groups, use a higher level (e.g., *Metazoa*).
- **Species Tree**: Use `/tree` to understand the available radiation points for filtering.

## Expert Tips
- **Level Selection**: Always specify a `level` (NCBI TaxID) to ensure results are relevant to the evolutionary distance you are studying.
- **Phyloprofile Filtering**: When using the API to find "universal" genes, filter for OGs present in >90% of the target clade.
- **Identifier Mapping**: OrthoDB indexes over 100 databases. If a specific accession fails, try the UniProtKB or NCBI Gene ID.
- **EC Numbers**: When searching for Enzyme Commission numbers, always wrap them in double quotes (e.g., `"3.1.1.-"`) to prevent the hyphens from being interpreted as logical NOT operators.

## Reference documentation
- [OrthoDB V12 User Guide](./references/www_ezlab_org_orthodb_v12_userguide.html.md)
- [OrthoDB Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_orthodb_overview.md)