---
name: last
description: LAST is a high-performance sequence alignment suite designed to identify complex relationships and rearrangements in large-scale biological data. Use when user asks to index a reference database, perform sequence alignment, train scoring parameters, or find protein-coding regions in DNA queries.
homepage: https://gitlab.com/mcfrith/last
---


# last

## Overview
LAST is a high-performance sequence alignment suite designed for large-scale biological data. Unlike traditional aligners, it excels at identifying complex relationships such as genomic rearrangements and distant protein homologies. It is particularly effective for "unusual" data types, including bisulfite-converted DNA or sequences with extreme base compositions. The workflow typically involves indexing a reference database and then performing the alignment using specialized scoring parameters.

## Core Workflow

### 1. Database Indexing
Before aligning, you must create an index of your reference sequences.
```bash
lastdb mydb reference.fasta
```
*   **Pro Tip**: For large genomes, use `-u` to specify a seed pattern (e.g., `-uNEAR` for closely related sequences).

### 2. Parameter Training (Optional but Recommended)
For non-standard data (like specific sequencing technologies), use `last-train` to find the optimal substitution matrix and gap penalties.
```bash
last-train mydb queries.fasta > my_params.train
```

### 3. Sequence Alignment
The primary alignment tool is `lastal`.
```bash
# Basic alignment
lastal mydb queries.fasta > alignments.maf

# Using trained parameters and multiple threads
lastal -p my_params.train -P 8 mydb queries.fasta > alignments.maf
```

## Common CLI Patterns

### DNA-versus-Protein Search
To find protein-coding regions in DNA queries against a protein database:
```bash
# Index the protein database
lastdb -p protdb proteins.fasta

# Align DNA queries (translates queries in 6 frames)
lastal -F15 protdb queries.fasta > alignments.maf
```

### Sensitive Genome Alignment
For sensitive DNA-DNA search, especially with rearrangements:
```bash
lastal -m100 -E0.05 mydb queries.fasta
```
*   `-m`: Increases sensitivity by allowing more initial matches.
*   `-E`: Sets the maximum E-value (expected alignments by chance).

### Output Formatting
LAST defaults to MAF (Multiple Alignment Format). Use `maf-convert` to change formats:
```bash
# Convert to BLAST Tabular format
lastal mydb queries.fasta | maf-convert blasttab > alignments.tab

# Convert to SAM for downstream genomic tools
lastal mydb queries.fasta | maf-convert sam > alignments.sam
```

## Expert Tips
*   **E-values**: If you get too many random matches, decrease the E-value threshold using `-e` (e.g., `-e0.00001`).
*   **Frame Information**: In recent versions (1651+), using `-fBlastTab+` in DNA-versus-protein searches will include the translation frame in the output.
*   **Memory Management**: For very large databases, use `lastdb -i` to set the volume size, which allows LAST to process the index in chunks.
*   **Bisulfite Mapping**: Use the specialized scripts provided in the LAST suite for methyl-seq data to handle the C-to-T conversion logic.



## Subcommands

| Command | Description |
|---------|-------------|
| last-dotplot | Draw a dotplot of pair-wise sequence alignments. |
| last-train | Try to find suitable score parameters for aligning the given sequences. |
| lastal | Find and align similar sequences. |
| lastdb | Prepare sequences for subsequent alignment with lastal. |
| maf-convert | Read MAF-format alignments & write them in another format. |

## Reference documentation
- [LAST Overview](./references/anaconda_org_channels_bioconda_packages_last_overview.md)
- [LAST GitLab Repository](./references/gitlab_com_mcfrith_last.md)
- [LAST Tags and Version History](./references/gitlab_com_mcfrith_last_-_tags.md)