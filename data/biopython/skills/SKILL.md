---
name: biopython
description: "Biopython provides a comprehensive suite of Python tools for biological computation, sequence analysis, and structural biology. Use when user asks to parse sequence files, retrieve data from NCBI Entrez, perform sequence alignments, or manipulate macromolecular structures."
homepage: http://www.biopython.org/
---


# biopython

## Overview
Biopython is the industry-standard library for bioinformatics in Python. It provides a robust framework for handling biological data types and integrating with external bioinformatics software. This skill enables efficient manipulation of sequence data, structural biology analysis, and automated retrieval of data from public biological repositories.

## Core Workflows

### Sequence Handling (Bio.Seq and Bio.SeqRecord)
- Use `Seq` objects for biological strings; they provide biological methods like `translate()`, `complement()`, and `reverse_complement()`.
- Use `SeqRecord` to bundle sequences with identifiers, names, and annotations.
- **Tip**: Always specify the molecule type (DNA, RNA, or protein) when performing translations to ensure correct codon table usage.

### File Parsing (Bio.SeqIO)
- Use `SeqIO.parse()` for files containing multiple records and `SeqIO.read()` for files with exactly one record.
- Supported formats: `fasta`, `genbank`, `embl`, `abi`, `fastq`.
- **Efficiency Tip**: `SeqIO.index()` or `SeqIO.index_db()` should be used for large files (e.g., whole genomes) to allow random access without loading the entire file into memory.

### Database Access (Bio.Entrez)
- Always set `Entrez.email` before making requests to NCBI.
- Use `Entrez.esearch` to find IDs and `Entrez.efetch` to retrieve full records.
- **Best Practice**: Use `Entrez.read()` to parse XML results into Python dictionaries/lists.

### Structural Biology (Bio.PDB)
- Use `PDBParser` or `MMCIFParser` to load macromolecular structures.
- Navigate the SMCRA hierarchy: Structure -> Model -> Chain -> Residue -> Atom.
- Use `NeighborSearch` for fast coordinate-based lookups (e.g., finding atoms within a specific radius).

### Sequence Alignment (Bio.Align)
- Use `PairwiseAligner` for local and global alignments. It provides more flexibility and better performance than older modules.
- For reading alignment files (Clustal, Stockhom), use `Bio.AlignIO`.

## Expert Tips
- **Lazy Loading**: When dealing with massive datasets, use generators (the default for `SeqIO.parse`) to keep memory usage low.
- **Subprocess Integration**: For tools like BLAST or ClustalW, use the `Bio.Blast.NCBIWWW` for online searches or `Bio.Applications` wrappers for local command-line execution.
- **Search IO**: For parsing output from search tools (BLAST, HMMER, Blat), use `Bio.SearchIO` as it provides a unified object model for different search engines.

## Reference documentation
- [Biopython Project Homepage](./references/biopython_org_index.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_biopython_overview.md)