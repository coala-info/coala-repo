---
name: yass
description: YASS is a specialized bioinformatics tool for sensitive genomic sequence comparison. Use when user asks to 'compare genomic sequences', 'detect distant homologies', 'find fuzzy repeats', 'search for non-coding RNA or regulatory elements', 'detect segmental duplications'.
homepage: https://bioinfo.lifl.fr/yass
metadata:
  docker_image: "quay.io/biocontainers/yass:1.16--h7b50bb2_0"
---

# yass

## Overview
YASS (Yet Another Similarity Searcher) is a specialized bioinformatics tool designed for sensitive genomic sequence comparison. Unlike standard BLAST, YASS utilizes multiple transition-constrained spaced seeds, making it significantly more sensitive for detecting distant homologies and fuzzy repeats in non-coding regions. It supports fasta or plain text formats and provides various output formats including BLAST-tabular and dot-plot visualizations.

## Core Usage Patterns

### Basic Alignment
To compare two sequences (query and target):
```bash
yass query.fasta target.fasta
```
To compare a sequence against itself (self-similarity/repeat detection):
```bash
yass sequence.fasta
```

### Output Formats (`-d`)
*   `-d 1`: Extended output with alignments and statistics (default).
*   `-d 2`: BLAST tabular format.
*   `-d 3`: Short, easily parsable tabular format.
*   `-o <file>`: Redirect output to a specific file.

### Sensitivity and Seed Control
*   `-p <pattern>`: Specify a custom seed pattern (e.g., `-p ##@_#@#__#_###`).
    *   `#`: Match
    *   `@`: Match or Transition (A↔G, C↔T)
    *   `_`: Joker (any match or mismatch)
*   `-c 1`: Single hit criterion (higher sensitivity, slower).
*   `-c 2`: Double hit criterion (lower sensitivity, faster).

### Scoring and Thresholds
*   `-E <value>`: Set E-value threshold (e.g., `-E 1e-5`).
*   `-G <open>,<ext>`: Set gap penalties (e.g., `-G -10,-4`).
*   `-C <match>,<mismatch>`: Simple scoring (e.g., `-C 1,-3`).
*   `-C <match>,<transversion>,<transition>`: Transition-aware scoring.
*   `-r <0|1|2>`: Search strand (0: forward, 1: reverse complement, 2: both).

### Sorting Results (`-s`)
*   `-s 70`: Query sorted (BLAST-like behavior).
*   `-s 0`: Sort by score.
*   `-s 6`: Sort by alignment identity percentage.

## Expert Tips
*   **Non-coding DNA**: Use YASS instead of BLAST when searching for non-coding RNA or regulatory elements, as its transition-constrained seeds better handle the mutation patterns found in these regions.
*   **Large Databases**: When the second file is a multi-fasta, YASS treats it as a database. Use `-S <number>` to select a specific sequence from a multi-fasta query (first file).
*   **Post-processing**: Use the included `yass2blast.pl` script to convert the `-d 1` output into standard BLAST, AXT, or multi-fasta alignment formats for downstream compatibility with Bioperl or other tools.
*   **Visualizing Repeats**: For self-alignment, use `-T <int>` to forbid aligning regions that are too close (e.g., tandem repeats) to focus on segmental duplications.

## Reference documentation
- [YASS Help and Options](./references/bioinfo_lifl_fr_yass_help.php.md)
- [YASS Main Documentation](./references/bioinfo_lifl_fr_yass_index.php.md)
- [YASS Output Description](./references/bioinfo_lifl_fr_yass_help.php.md)
- [yass2blast.pl Script Details](./references/bioinfo_lifl_fr_yass_files_yass-current_yass2blast.pl.md)