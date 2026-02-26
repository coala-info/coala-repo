---
name: biobasehttptools
description: BiobaseHTTPTools is a suite of command-line utilities for querying remote bioinformatics databases to map identifiers and retrieve biological sequences. Use when user asks to fetch sequences in FASTA format, convert NCBI accessions to Taxonomy IDs, retrieve Gene Ontology terms, or map Ensembl Gene IDs to UniProt identifiers.
homepage: https://github.com/eggzilla/BiobaseHTTPTools
---


# biobasehttptools

## Overview
BiobaseHTTPTools is a suite of command-line utilities designed to streamline common bioinformatics workflows that involve querying remote databases. It provides a lightweight way to map identifiers and retrieve sequences without writing custom API scripts. This skill helps in selecting and using the correct utility for specific mapping tasks involving NCBI and Ensembl identifiers.

## Command-Line Utilities
The suite consists of four primary tools. Each is executed as a standalone command:

### 1. FetchSequence
Retrieves biological sequences directly from web resources.
- **Primary Use**: Downloading sequences in FASTA format.
- **Context**: Use when you have a list of accessions and need the corresponding sequence data for downstream analysis.

### 2. AccessionToTaxId
A specialized utility for taxonomic classification.
- **Primary Use**: Converting NCBI accession numbers into their corresponding Taxonomy IDs.
- **Context**: Essential for metagenomics or phylogenetics workflows where sequence origin must be verified.

### 3. GeneIdToGOTerms
Maps genetic identifiers to functional annotations.
- **Primary Use**: Retrieving Gene Ontology (GO) terms associated with a specific Ensembl Gene ID.
- **Context**: Use during functional enrichment analysis or when characterizing the biological process of a gene set.

### 4. GeneIdToUniProtId
Cross-references Ensembl and UniProt databases.
- **Primary Use**: Mapping an Ensembl Gene ID to its corresponding UniProt identifier.
- **Context**: Use when transitioning from genomic/transcriptomic data (Ensembl) to protein-centric analysis (UniProt).

## Best Practices and CLI Patterns
- **Identifier Validation**: Ensure Ensembl IDs (e.g., ENSG...) and NCBI accessions are correctly formatted before passing them to the tools to avoid query errors.
- **Network Awareness**: These tools rely on live web resources (NCBI/Ensembl APIs). Ensure stable internet connectivity and be prepared for potential latency during peak hours.
- **Standard Streams**: These utilities are designed for routine tasks; use standard shell redirection (e.g., `> output.fasta`) to capture the results of sequence or term retrieval.
- **Installation**: The tools can be managed via Conda (`conda install bioconda::biobasehttptools`) or Haskell's Cabal (`cabal install BiobaseHTTPTools`).

## Reference documentation
- [GitHub Repository Overview](./references/github_com_eggzilla_BiobaseHTTPTools.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biobasehttptools_overview.md)