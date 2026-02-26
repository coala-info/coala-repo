---
name: obitools4
description: obitools4 is a suite of command-line utilities designed for processing and analyzing high-throughput environmental DNA and metabarcoding sequencing data. Use when user asks to pair reads, filter sequences, dereplicate identical reads, perform taxonomic assignment, simulate in silico PCR, or generate OTU count tables.
homepage: https://obitools4.metabarcoding.org
---


# obitools4

## Overview

obitools4 is a specialized suite of command-line utilities designed for the management and analysis of high-throughput sequencing data, specifically tailored for environmental DNA (eDNA) and metabarcoding workflows. It follows a Unix-like philosophy where modular tools are piped together to transform raw FASTQ/FASTA files into annotated taxonomic tables. The toolset excels at handling large sequence datasets, performing dereplication, taxonomic assignment using NCBI-formatted databases, and cleaning PCR/sequencing errors.

## Core Command Patterns

### Sequence Preprocessing and Filtering
The primary workflow usually begins with pairing reads and filtering based on quality or sequence attributes.

- **Pairing reads**: Use `obipairing` to align forward and reverse reads from Illumina paired-end sequencing.
- **Filtering**: Use `obigrep` to select sequences based on length, quality scores, or the presence of specific primers/probes.
  - Example: `obigrep -l 100 -L 200 input.fastq` (filters for sequences between 100 and 200 bp).
- **Dereplication**: Use `obiuniq` to group identical sequences and keep track of their counts (abundance). This is a critical step to reduce computational load.

### Taxonomic Assignment
obitools4 uses a specific taxonomy system based on taxids.

- **Reference Indexing**: Before assignment, reference databases (like GenBank) must be indexed using `obirefidx`.
- **Assignment**: Use `obitaxonomy` to assign taxonomic information to sequences based on their taxids or via comparison to a reference database.
- **PCR Simulation**: `obipcr` can be used to simulate an in silico PCR against a reference database to check primer specificity.

### Data Cleaning and Matrix Generation
- **Error Identification**: `obiclean` is used to identify potential PCR chimeras or sequencing errors by looking for "head", "internal", and "singleton" sequences within a cluster.
- **Matrix Construction**: `obimatrix` generates a count table (OTU table) where rows represent sequences and columns represent samples, which is the standard input for downstream ecological analysis in R or Python.

## Expert Tips and Best Practices

- **Piping for Efficiency**: obitools4 is designed to work with standard streams. Avoid writing large intermediate files by piping commands: `obigrep ... | obiuniq ... | obiclean ... > output.fasta`.
- **Attribute Management**: Most obitools4 commands add metadata to the header of the FASTA/FASTQ records (e.g., `count`, `taxid`). Use `obiannotate` to manually add, delete, or modify these attributes.
- **Format Conversion**: Use `obiconvert` to switch between formats (FASTA, FASTQ, GenBank, EMBL) while preserving the specialized attribute tags used by the suite.
- **Memory Management**: For extremely large datasets, ensure you are using the 64-bit version and monitor memory usage during `obiuniq` and `obiclean` steps, as these are the most memory-intensive.
- **Taxonomy Files**: Always ensure your NCBI taxdump files are up to date when performing taxonomic assignments to avoid stale taxid references.

## Reference documentation
- [OBITools4 Documentation](./references/obitools4_metabarcoding_org_index.md)