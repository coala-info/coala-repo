---
name: pymlst
description: The `pymlst` tool is a Python-based suite designed for high-resolution bacterial clonality assessment.
homepage: https://github.com/bvalot/pyMLST.git
---

# pymlst

## Overview
The `pymlst` tool is a Python-based suite designed for high-resolution bacterial clonality assessment. It moves beyond traditional 7-gene MLST by enabling large-scale analysis of core and whole-genome sets. The tool is particularly useful for clinical microbiology workflows involving *E. coli*, *K. pneumoniae*, *A. baumanii*, and *P. aeruginosa*. It excels at iterative strain collection by storing allele sequences and profiles in a local database, allowing users to add new genomic data to existing projects without re-processing the entire dataset.

## Core Workflows and CLI Patterns

### Database Initialization
Before running searches, initialize the environment and import the necessary schemes.
- **Automatic Import**: Use the v2.0+ mechanism to pull cgMLST/MLST schemas.
- **Configuration**: Ensure the `rcfile.rc` or configuration file correctly points to external dependencies like MAFFT or KMA.

### Typing from Draft Genomes (Assemblies)
Use the standard search command when you have FASTA files (assembler-generated drafts).
```bash
pymlst search --db [database_name] --input [assembly.fasta]
```

### Typing from Raw Reads (FASTQ)
For direct analysis of sequencing data without prior assembly, use the `search2` or `add2` commands which leverage KMA integration.
```bash
# Search and identify alleles directly from raw reads
pymlst search2 --db [database_name] --input1 [read_R1.fastq] --input2 [read_R2.fastq]
```

### Specialized Typing (pyTyper)
For specific species-level identification beyond standard MLST:
- **E. coli**: Use for `fimH` typing and phylogrouping.
- **S. aureus**: Use for `spa` typing.
```bash
pymlst pyTyper --method [fimH|spa|phylogroup] --input [genome.fasta]
```

### Handling Incomplete Genes
If alleles are missing or truncated in draft genomes, `pymlst` can attempt to fill these gaps using MAFFT-based alignment. Ensure MAFFT is in your PATH or defined in the tool's configuration.

## Expert Tips
- **Iterative Expansion**: Because `pymlst` uses SQLite, you can continuously add new strains to a local database. This is more efficient than flat-file systems for long-term surveillance.
- **Resource Management**: When using `search2` on raw reads, ensure sufficient memory is available for the KMA indexing and mapping process.
- **Version Compatibility**: If you are upgrading from v1.x, note that v2.x introduced a sub-command system (e.g., `pymlst [command]`) which is not backward compatible with the old single-command syntax.

## Reference documentation
- [pyMLST GitHub Repository](./references/github_com_bvalot_pyMLST.md)