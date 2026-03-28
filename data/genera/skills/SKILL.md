---
name: genera
description: The genera skill performs genomic phylostratigraphy to infer gene ages by integrating sequence similarity searches, structural alignments, and taxonomic data. Use when user asks to assign origination dates to genes, perform evolutionary transcriptomics, or identify orphan genes using DIAMOND and Foldseek.
homepage: https://github.com/josuebarrera/GenEra
---

# genera

## Overview
The `genera` skill provides a specialized workflow for genomic phylostratigraphy, allowing for the sensitive inference of gene ages across the tree of life. By integrating sequence similarity searches (DIAMOND), structural alignments (Foldseek), and taxonomic data (NCBI Taxonomy), it assigns an origination date to genes and gene families. This skill is essential for researchers performing evolutionary transcriptomics (e.g., using the `myTAI` R package) or studying genomic novelty and conservation.

## Core Workflow and Best Practices

### 1. Database Preparation
Before running an analysis, ensure the required databases are formatted and accessible.
- **NCBI Taxonomy**: Use `NCBItax2lin` to process the NCBI taxonomy dump.
- **Sequence Database**: A local copy of the NCBI NR database is required for DIAMOND searches.
- **Structural Database**: If using structural alignments, ensure the AlphaFold DB is indexed for Foldseek.
- **Offline Mode**: For v1.2.0+, ensure all taxonomy and sequence files are local to run the tool without an internet connection.

### 2. Execution Patterns
The tool is typically invoked via the `genEra` command. While specific flags depend on the version, the following patterns are standard:

- **Standard Phylostratigraphy**: Uses DIAMOND to search against the NR database. This is the fastest method for general age estimation.
- **Structural Reassessment**: Use the Foldseek integration to improve sensitivity for distant homologs that have low sequence identity but conserved structures.
- **Infraspecies Analysis**: For strains or varieties without specific NCBI TaxIDs, use the `-F` flag (or equivalent) to incorporate custom phylogenetic relationships or OrthoFinder results.
- **Nucleotide Search**: Use the MMseqs2 integration to search protein queries against nucleotide assemblies (genomes/transcriptomes) to better classify orphan genes.

### 3. Improving Sensitivity
- **JackHMMER Reassessment**: If DIAMOND results are insufficient, enable the JackHMMER step. Note that this significantly increases runtime but provides higher sensitivity for ancient homologs.
- **abSENSE Integration**: Use this to calculate homology detection failure probabilities. This helps distinguish "true" orphan genes from those that are simply evolving too fast for standard tools to detect.

### 4. Handling Output
The primary output is a "phylomap" (typically a `.tsv` file).
- **Rank/Phylostratum**: Indicates the assigned age (1 being the oldest/ancestral).
- **Representativeness Score**: Always check this score to assess the reliability of the age assignment for a specific gene.
- **Downstream Integration**: The output is formatted for direct use with the `myTAI` R package for calculating Transcriptome Age Index (TAI) patterns.

## Expert Tips
- **Memory Management**: DIAMOND and Foldseek are memory-intensive. Ensure your environment has sufficient RAM, especially when searching against the full NR database.
- **Taxonomic Resolution**: When working with non-model organisms, ensure your query species' TaxID is correctly specified to avoid incorrect "orphan" assignments.
- **Version Compatibility**: Ensure DIAMOND is v2.0.0 or higher and Foldseek is v3.915ef7d or higher for full feature support.



## Subcommands

| Command | Description |
|---------|-------------|
| /usr/local/bin/FASTSTEP3R | FASTSTEP3R tool for processing gene lists and diamond output. |
| genEra | genEra is an easy-to-use, low-dependency command-line tool that estimates the age of the earliest common ancestor of protein coding genes though genomic phylostratigraphy. |
| hmmEra | HMMER-based gene family analysis tool |
| tree2ncbitax | Converts a NEWICK tree to NCBI taxonomy format. |

## Reference documentation
- [GenEra Wiki Home](./references/github_com_josuebarrera_GenEra_wiki.md)
- [Running GenEra](./references/github_com_josuebarrera_GenEra_wiki_Running-GenEra.md)
- [GenEra Output Guide](./references/github_com_josuebarrera_GenEra_wiki_GenEra-output.md)
- [Database Setup](./references/github_com_josuebarrera_GenEra_wiki_Setting-up-the-database_s_.md)
- [Downstream Analysis (myTAI)](./references/github_com_josuebarrera_GenEra_wiki_Downstream-analyses.md)