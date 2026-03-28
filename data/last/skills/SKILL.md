---
name: last
description: LAST is a high-performance sequence alignment suite designed for large-scale comparative genomics and identifying distant evolutionary relationships. Use when user asks to index reference databases, train alignment parameters, perform DNA or protein sequence alignments, or convert MAF files to other formats.
homepage: https://gitlab.com/mcfrith/last
---

# last

## Overview
LAST is a high-performance sequence alignment suite designed for large-scale biological data. It is significantly faster than BLAST while maintaining high sensitivity, making it ideal for comparative genomics and identifying distant evolutionary relationships. The workflow typically involves indexing a database, optionally training parameters for specific datasets, and executing the alignment.

## Core Workflow

### 1. Database Indexing
Before aligning, you must create an index of your reference sequences.
```bash
lastdb mydb reference.fasta
```
*   For protein databases, use `-p`.
*   For large genomes, consider `-u` options to specify seeding schemes.

### 2. Parameter Training (Recommended)
To get the most accurate alignments, use `last-train` to find the best substitution matrix and gap penalties for your specific sequences.
```bash
last-train mydb query.fasta > myparams.txt
```

### 3. Sequence Alignment
Use `lastal` to perform the search. It is common to pipe the output directly to other tools.
```bash
lastal -p myparams.txt mydb query.fasta > alignments.maf
```

## Common CLI Patterns

### DNA-versus-Protein (Translated) Alignment
To align DNA queries against a protein database with frame information:
```bash
lastal -f BlastTab+ -F0 mydb query.fasta
```
*   **Note**: The `BlastTab+` format includes a column for the translation frame (1, 2, 3, -1, -2, -3).

### Genome-to-Genome Alignment
For sensitive whole-genome comparisons, ensure you handle E-values correctly to filter out random matches.
```bash
lastal -m100 -E0.05 mydb query.fasta
```

### Format Conversion
LAST defaults to MAF (Multiple Alignment Format). Use `maf-convert` to change this to standard formats:
*   **To SAM**: `maf-convert sam alignments.maf`
*   **To BED**: `maf-convert bed alignments.maf`
*   **To BlastTab**: `maf-convert blasttab alignments.maf`

## Expert Tips
*   **Sensitivity**: If you are looking for very weak similarities, increase the sensitivity using the `-s` (search phase) and `-m` (maximum initial matches) flags.
*   **Memory Management**: For extremely large datasets, `lastal` allows for memory-efficient allocations. Recent versions support coordinates greater than 2^32.
*   **Visualization**: Use `last-dotplot` to create visual representations of alignments, which is helpful for identifying synteny or structural variations.
*   **Gzipped Input**: Tools like `maf-linked` now support `.gz` input directly.



## Subcommands

| Command | Description |
|---------|-------------|
| last-dotplot | Draw a dotplot of pair-wise sequence alignments. |
| last-train | Try to find suitable score parameters for aligning the given sequences. |
| lastal | Find and align similar sequences. |
| lastdb | Prepare sequences for subsequent alignment with lastal. |
| maf-convert | Read MAF-format alignments & write them in another format. |

## Reference documentation
- [LAST Project Overview](./references/gitlab_com_mcfrith_last.md)
- [LAST README](./references/gitlab_com_mcfrith_last_-_blob_main_README.rst.md)