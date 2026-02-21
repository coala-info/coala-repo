---
name: tango
description: tango (executed via the `contigtax` command) is a specialized tool for assigning taxonomic identities to metagenomic sequences.
homepage: https://github.com/johnne/tango
---

# tango

## Overview
tango (executed via the `contigtax` command) is a specialized tool for assigning taxonomic identities to metagenomic sequences. It operates by querying contig nucleotide sequences against a protein database using the DIAMOND aligner and subsequently parsing the results through a filtering logic that applies specific identity thresholds for different taxonomic ranks (e.g., species, genus, family). This approach, based on established metagenomic binning and classification methodologies, allows for more sensitive detection of distant homologs compared to traditional nucleotide-only searches.

## Installation and Setup
The tool is primarily distributed via Bioconda.
```bash
conda install -c bioconda contigtax
```

## Core Workflow

### 1. Database Preparation
Before classification, you must prepare the reference databases. This involves downloading the protein sequences and the NCBI taxonomy mapping.

```bash
# Download reference protein data (e.g., uniref100)
contigtax download uniref100

# Download NCBI taxonomy files
contigtax download taxonomy

# Reformat the fasta and create a taxon map
contigtax format uniref100/uniref100.fasta.gz uniref100/uniref100.reformat.fasta.gz

# Build the DIAMOND database
contigtax build uniref100/uniref100.reformat.fasta.gz uniref100/prot.accession2taxid.gz taxonomy/nodes.dmp
```

### 2. Taxonomic Search
Perform the alignment of your assembled contigs against the prepared DIAMOND database. Use the `-p` flag to specify CPU threads for performance.

```bash
# Search assembled contigs (assembly.fa)
contigtax search -p 8 assembly.fa uniref100/diamond.dmnd assembly.tsv.gz
```

### 3. Taxonomy Assignment
The final step parses the search hits and applies rank-specific thresholds to produce the final taxonomy table.

```bash
# Assign taxonomy based on search results
contigtax assign -p 8 assembly.tsv.gz assembly.taxonomy.tsv
```

## Expert Tips and Best Practices
- **Database Selection**: While UniRef100 provides the highest resolution, UniRef90 or UniRef50 can be used for faster searches or when looking for broader conservation.
- **Resource Management**: The `search` and `assign` commands are computationally intensive. Always utilize the `-p` parameter to match the available cores on your system.
- **Docker Usage**: If running in a containerized environment, use the official image `nbisweden/contigtax` and mount your current working directory to `/work`.
  - Example: `docker run --rm -v $(pwd):/work nbisweden/contigtax search -p 4 query.fa db.dmnd out.tsv.gz`
- **Input Formats**: The tool natively handles gzipped files (`.gz`), which is recommended for managing large metagenomic datasets and reference databases.

## Reference documentation
- [NBISweden/contigtax GitHub Repository](./references/github_com_NBISweden_contigtax.md)
- [contigtax Wiki](./references/github_com_NBISweden_contigtax_wiki.md)