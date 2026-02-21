---
name: rappas
description: RAPPAS (Rapid Alignment-free Phylogenetic Placement via Ancestral Sequences) is a specialized tool for placing genomic reads onto a pre-defined phylogenetic tree.
homepage: https://github.com/blinard-BIOINFO/RAPPAS
---

# rappas

## Overview

RAPPAS (Rapid Alignment-free Phylogenetic Placement via Ancestral Sequences) is a specialized tool for placing genomic reads onto a pre-defined phylogenetic tree. Unlike traditional methods, it is alignment-free, meaning once a reference database is built, metagenomic reads can be placed directly without being aligned to the original reference alignment. The workflow is divided into two distinct phases: building a phylo-kmer database from a reference tree/alignment and performing the actual placement of query sequences.

## Installation and Setup

The most reliable way to use RAPPAS is via Bioconda:

```bash
conda install bioconda::rappas
```

If running the JAR file directly, ensure Java 8+ is installed. Use the `rappas` command if installed via conda, or `java -jar RAPPAS.jar` if using the standalone executable.

## Core Workflows

### 1. Database Construction (Mode 'b')
This step generates the phylo-kmer database. It requires a reference alignment and a corresponding phylogenetic tree.

```bash
rappas -m b -w [work_dir] -k [kmer_size] -r [ref_alignment.fasta] -t [ref_tree.nwk] -s [nucl|prot] -b [path_to_AR_binary]
```

**Key Parameters:**
- `-m b`: Sets mode to "build".
- `-k`: k-mer size (default is 8; higher values increase memory usage).
- `-s`: Sequence type, either `nucl` (nucleotide) or `prot` (protein).
- `-b`: Path to the ancestral reconstruction (AR) binary (PhyML, PAML, or RAxML-ng). PhyML is generally recommended for speed.
- `-w`: Working directory where the `.union` database file will be created.

### 2. Phylogenetic Placement (Mode 'p')
Once the database (`.union` file) is created, use it to place metagenomic reads.

```bash
rappas -m p -d [database.union] -q [query_reads.fasta] -w [work_dir]
```

**Key Parameters:**
- `-m p`: Sets mode to "placement".
- `-d`: Path to the `.union` database file generated in the build step.
- `-q`: The fasta file containing the metagenomic reads to be placed.
- **Output**: Results are saved as a `.jplace` file in the `log/` subdirectory of your working directory.

## Expert Tips and Best Practices

### Memory Management
RAPPAS can be memory-intensive during database construction. Always specify the Java heap size using `-Xmx` if you encounter memory errors:
```bash
java -Xmx16G -jar $(which RAPPAS.jar) [options]
```

### Ancestral Reconstruction Selection
- **PhyML**: Faster, but requires more RAM. Recommended for most standard workflows.
- **PAML**: Slower, but more memory-efficient. Use this for very large reference trees or long alignments if PhyML fails.
- **RAxML-ng**: Supported in versions 1.20+, providing a modern alternative for AR.

### Handling Large Trees
If working with trees containing >4000 taxa, the default limits of some AR tools (like older PhyML versions) may be exceeded. Ensure you are using RAPPAS >= 1.12 and a compatible version of PhyML (>= 3.3.20190909) to avoid output format errors.

### Downstream Analysis
The resulting `.jplace` files are compatible with several downstream tools for diversity analysis and visualization:
- **GUPPY**: For calculating diversity indexes (Alpha diversity, Unifrac).
- **iTOL / Genesis**: For visual inspection of placements on the reference tree.

## Reference documentation
- [RAPPAS GitHub Repository](./references/github_com_phylo42_RAPPAS.md)
- [RAPPAS Wiki and Tutorials](./references/github_com_phylo42_RAPPAS_wiki.md)
- [Bioconda RAPPAS Overview](./references/anaconda_org_channels_bioconda_packages_rappas_overview.md)