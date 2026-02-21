---
name: alv
description: alv (Alignment Viewer) is a lightweight, console-based utility designed for rapid visualization of biological sequence alignments.
homepage: https://github.com/arvestad/alv
---

# alv

## Overview

alv (Alignment Viewer) is a lightweight, console-based utility designed for rapid visualization of biological sequence alignments. It eliminates the need for heavy graphical interfaces by rendering colored alignments directly in the terminal. It is particularly effective for remote server work, quick quality control of MSAs, and inspecting coding DNA sequences where it can automatically translate and color by codon.

## Usage Patterns

### Basic Visualization
View an alignment with automatic sequence type detection (DNA/RNA/AA/Coding):
```bash
alv msa.fa
```

### Paging with Colors
By default, alv strips colors when piping. To use `less` for paging while preserving the colored output:
```bash
alv -k msa.fa | less -R
```

### Inspecting Large Alignments
For files too large for the terminal buffer, use these sampling and summary modes:
- **Glimpse mode**: Shows a representative conserved region that fits on one screen.
  ```bash
  alv -g huge_msa.fa
  ```
- **Random sampling**: View a subset of sequences (e.g., 20 random sequences).
  ```bash
  alv -r 20 huge_msa.fa
  ```

### Sub-alignment and Filtering
- **Select columns**: View a specific range (e.g., columns 30 to 60).
  ```bash
  alv -sa 30 60 msa.fa
  ```
- **Select sequences**: View only specific accessions.
  ```bash
  alv -so accession1,accession2 msa.fa
  ```
- **Filter by pattern**: View sequences matching a specific string (e.g., "YEAST").
  ```bash
  alv -sm YEAST msa.fa
  ```

### Coding DNA Analysis
alv can color nucleotides based on their amino acid translation. While usually autodetected, you can force this mode:
```bash
alv -t coding msa.fa
```

## Expert Tips

- **Terminal Width**: If the alignment wraps awkwardly, use `-w` to set a specific width (e.g., `alv -w 120 msa.fa`).
- **Focus on Variation**: Use `--only-variable` or `--only-variable-excluding-indels` to hide conserved columns and highlight mutations.
- **Input Formats**: alv supports FASTA, Clustal, PHYLIP, NEXUS, and Stockholm formats.
- **Python Integration**: For Jupyter environments, use `alv.view(msa_object)` or `alv.glimpse(msa_object)` with BioPython alignment objects for inline colored visualization.

## Reference documentation
- [alv GitHub Repository](./references/github_com_arvestad_alv.md)
- [alv Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_alv_overview.md)