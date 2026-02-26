---
name: conterminator
description: Conterminator identifies sequences assigned to incorrect taxonomic groups by performing efficient ungapped local alignments across large datasets. Use when user asks to detect cross-kingdom contamination, identify mislabeled sequences in FASTA files, or find bacterial sequences within eukaryotic datasets.
homepage: https://github.com/martin-steinegger/conterminator
---


# conterminator

## Overview
Conterminator is a specialized tool designed to identify sequences that have been assigned to the wrong taxonomic group. By performing ungapped local alignments across an entire dataset, it detects sequences from one kingdom (e.g., Bacteria) that appear within a dataset labeled as another (e.g., Metazoa). It is built on the MMseqs2 framework, making it highly efficient for massive sequence sets.

## Core Workflows

### 1. Preparing Input Files
Conterminator requires two primary inputs:
- **FASTA File**: The sequences to be checked.
- **Mapping File**: A tab-separated file (TSV) with two columns:
  1. FASTA identifier (text before the first space).
  2. NCBI Taxonomy ID.

### 2. Running the Analysis
The command structure differs slightly based on the sequence type. Both require a result prefix and a temporary directory for intermediate files.

**For Nucleotide Sequences:**
```bash
conterminator dna input.fna input.mapping result_prefix tmp_dir
```

**For Protein Sequences:**
```bash
conterminator protein input.faa input.mapping result_prefix tmp_dir
```

### 3. Defining Contamination Rules
The `--kingdom` parameter is the most powerful feature, allowing you to define exactly which taxa should be considered "contaminants" relative to each other.

- **Default Rule**: `2||2157,4751,33208,33090,2759&&!4751&&!33208&&!33090`
  - This compares Bacteria/Archaea, Fungi, Metazoa, Viridiplantae, and "Other Eukaryotes" against each other.
- **Custom Rule Syntax**:
  - `,` : Separates distinct groups to compare against each other.
  - `||` : OR logic.
  - `&&` : AND logic.
  - `!` : NOT logic.
- **Example (Bacteria vs. Human)**:
  To specifically look for bacterial contamination in human samples:
  ```bash
  conterminator dna input.fna input.mapping result --kingdom 2,9606
  ```

## Interpreting Results
The tool generates two main output files:

1. **`{prefix}_conterm_prediction`**: The primary list of predicted contaminants.
   - **Column 2**: The contaminated sequence ID.
   - **Column 3**: The kingdom index of the sequence.
   - **Column 8**: The ID of the longest contaminating sequence it aligned to.
   - **Column 12**: Count of how many sequences from the contaminating kingdom aligned to this entry.
2. **`{prefix}_all`**: A comprehensive list of all alignments used to make predictions, useful for deep-dive validation of specific hits.

## Expert Tips
- **Temporary Storage**: Ensure the `tmp_dir` is on a fast disk (like an SSD) with ample space, as MMseqs2-based tools generate significant intermediate data during the all-against-all search.
- **Taxonomy Mapping**: If working with NCBI's NT database, you can generate the mapping file using `blastdbcmd`:
  ```bash
  blastdbcmd -db nt -entry all -outfmt "%a %T" > nt.mapping
  ```
- **Redundancy**: The prediction file may list the same identifier multiple times if multiple distinct contamination alignments were detected. Always aggregate or filter this file before downstream processing.

## Reference documentation
- [GitHub Repository - steineggerlab/conterminator](./references/github_com_steineggerlab_conterminator.md)
- [Conterminator Wiki](./references/github_com_steineggerlab_conterminator_wiki.md)