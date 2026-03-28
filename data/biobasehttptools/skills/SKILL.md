---
name: biobasehttptools
description: BiobaseHTTPTools provides command-line utilities for retrieving biological sequences and mapping identifiers across major bioinformatics databases like NCBI and Ensembl. Use when user asks to fetch sequences in FASTA format, convert accessions to Taxonomy IDs, retrieve Gene Ontology terms, or map gene IDs to UniProt identifiers.
homepage: https://github.com/eggzilla/BiobaseHTTPTools
---


# biobasehttptools

## Overview

BiobaseHTTPTools is a suite of command-line utilities designed to streamline interactions with major bioinformatics web databases like NCBI and Ensembl. Instead of manual web searches or complex API scripting, these tools provide direct CLI access to routine data tasks, such as sequence retrieval and cross-database identifier mapping. This skill helps you navigate the specific tools available in the package to automate bioinformatics workflows.

## Core Toolset and Usage

The suite consists of four primary tools. Each is executed as a standalone command:

### 1. Sequence Retrieval
Use `FetchSequence` to obtain biological sequences.
- **Function**: Retrieves sequences in FASTA format.
- **Context**: Use when you have a list of accessions and need the raw sequence data for alignment or analysis.

### 2. Taxonomy Mapping
Use `AccessionToTaxId` for NCBI database cross-referencing.
- **Function**: Converts an NCBI accession number into its corresponding Taxonomy ID.
- **Context**: Essential for phylogenetic studies or when verifying the species origin of a specific sequence accession.

### 3. Functional Annotation
Use `GeneIdToGOTerms` to explore gene function.
- **Function**: Retrieves all associated Gene Ontology (GO) terms for a specific Ensembl Gene ID.
- **Context**: Use during functional enrichment analysis or when characterizing the biological process, molecular function, or cellular component of a gene set.

### 4. Identifier Mapping
Use `GeneIdToUniProtId` for protein-level cross-referencing.
- **Function**: Maps an Ensembl Gene ID to its corresponding UniProt identifier.
- **Context**: Use when transitioning from genomic/transcriptomic data (Ensembl) to proteomic analysis (UniProt).

## Best Practices

- **Batch Processing**: These tools are designed for routine tasks; you can wrap them in shell loops to process multiple identifiers sequentially.
- **Network Dependency**: Since these tools query live web resources via the BiobaseHTTP library, ensure a stable internet connection and be mindful of rate limits imposed by NCBI and Ensembl.
- **Installation**: If the tools are not found in the environment, they can be installed via the Haskell package manager using `cabal install BiobaseHTTPTools`.



## Subcommands

| Command | Description |
|---------|-------------|
| Fetchsequence | Fetch sequence information based on gene ID, start, and stop. |
| GeneIdToGOTerms | Convert Ensembl gene IDs to Gene Ontology terms. |
| GeneIdToUniProtId | Converts Ensembl gene IDs or NCBI locus tags to UniProt IDs. |
| biobasehttptools_AccessionToTaxId | Convert NCBI accession numbers to TaxIds. |

## Reference documentation

- [BiobaseHTTPTools Main Repository](./references/github_com_eggzilla_BiobaseHTTPTools.md)