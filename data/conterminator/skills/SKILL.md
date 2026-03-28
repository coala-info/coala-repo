---
name: conterminator
description: Conterminator identifies and flags sequences assigned to the wrong taxonomic kingdom by performing ungapped local alignments across genomic datasets. Use when user asks to detect cross-taxon contamination, identify misclassified sequences in FASTA files, or clean genomic databases using taxonomy mapping.
homepage: https://github.com/martin-steinegger/conterminator
---

# conterminator

## Overview
Conterminator is a high-performance tool designed to identify sequences that have been assigned to the wrong taxonomic kingdom. By performing ungapped local alignments across an entire dataset, it flags sequences that show high similarity to organisms in distant taxa. This is essential for maintaining the integrity of genomic databases and ensuring that downstream analyses are not biased by "hidden" contaminants.

## Usage Patterns

### Basic Execution
Conterminator requires two primary inputs: a FASTA file and a tab-separated mapping file.

**For Nucleotide Sequences:**
```bash
conterminator dna input.fna input.mapping result_prefix tmp_dir
```

**For Protein Sequences:**
```bash
conterminator protein input.faa input.mapping result_prefix tmp_dir
```

### Input Requirements
1. **FASTA File**: Standard sequence file.
2. **Mapping File**: A two-column TSV file:
   - Column 1: Sequence Identifier (by default, text up to the first blank space).
   - Column 2: NCBI Taxonomy ID.

### Defining Contamination Rules
The `--kingdom` parameter defines which taxonomic groups are checked against each other.

- **Simple Pair**: To check for contamination between Bacteria (TaxID 2) and Humans (TaxID 9606):
  `--kingdom 2,9606`
- **Logic Operators**: Use `!` (NOT), `||` (OR), and `&&` (AND) for complex rules.
- **Default Rule**: `2||2157,4751,33208,33090,2759&&!4751&&!33208&&!33090`
  (This checks for contamination between Bacteria/Archaea, Fungi, Metazoa, Viridiplantae, and other Eukaryotes).

## Interpreting Results
The tool generates two main output files:

1. **`{PREFIX}_conterm_prediction`**: A TSV file containing predicted contamination.
   - **Columns**: Numeric ID, Contaminated ID, Kingdom, Species Name, Alignment Start/End, Corrected Contig Length, Longest Contaminating Sequence ID, and its Kingdom/Species.
2. **`{PREFIX}_all`**: Contains all alignments used to predict contamination for deeper manual inspection.

## Expert Tips
- **Temporary Directory**: Ensure the `tmp_dir` is on a fast disk (SSD) with sufficient space, as the underlying MMseqs2 modules generate significant intermediate data.
- **Taxonomy Mapping**: For large databases like NCBI NT, use `blastdbcmd` to generate the mapping file:
  `blastdbcmd -db nt -entry all -outfmt "%a %T" > nt.fna.taxidmapping`
- **Hardware Requirements**: Requires a 64-bit system with at least SSE4.1 instruction set support. Use the AVX2 build if your CPU supports it for significantly faster processing.



## Subcommands

| Command | Description |
|---------|-------------|
| conterminator dna | Searches for cross taxon contamination in DNA sequences |
| conterminator protein | Searches for cross taxon contamination in protein sequences |

## Reference documentation
- [Conterminator GitHub Repository](./references/github_com_steineggerlab_conterminator.md)
- [Conterminator Wiki Home](./references/github_com_steineggerlab_conterminator_wiki.md)