---
name: qgrs-cpp
description: The `qgrs-cpp` tool is a high-performance C++ implementation of the QGRS mapping algorithm.
homepage: https://github.com/freezer333/qgrs-cpp
---

# qgrs-cpp

## Overview
The `qgrs-cpp` tool is a high-performance C++ implementation of the QGRS mapping algorithm. It identifies potential G-quadruplexes—four-stranded secondary structures found in nucleic acids—based on specific tetrad and spacer constraints. Use this skill to automate the discovery of these motifs in FASTA or raw sequence files, filter results by stability (G-score), and generate structured data (JSON/CSV) for downstream bioinformatics pipelines.

## Installation and Setup
The tool is available via Bioconda or can be compiled from source.

```bash
# Install via Conda
conda install bioconda::qgrs-cpp

# Manual build (C++11 required)
g++ -o qgrs src/default.cpp src/qgrs.cpp --std=c++11
```

## Command Line Usage

### Basic Execution
By default, the tool reads from `stdin` and writes to `stdout`. Use `Ctrl+D` to signal EOF if entering sequences manually.

```bash
# Basic run with default settings
./qgrs -i sequence.txt

# Direct sequence input via echo
echo "GGAGGAGGAGG" | ./qgrs
```

### Output Formats
The tool defaults to a space-delimited column format. For automated processing, use structured formats:

*   **JSON**: `-json`
*   **CSV**: `-csv`
*   **No Headers**: `-notitle` (useful for concatenating multiple runs)

### Filtering and Refinement
*   **Tetrad Count (`-t`)**: Filter for higher stability. Defaults to 2. Use `-t 3` for more robust quadruplexes.
*   **G-Score (`-s`)**: Filter by the calculated G-score (likelihood of formation). Defaults to 17.
*   **Overlapping Motifs (`-v`)**: By default, the tool suppresses overlapping motifs. Use `-v` to see all possible variants (e.g., 1.1, 1.2).

```bash
# Find high-stability motifs (3+ tetrads, score > 50) including overlaps
./qgrs -i input.fasta -t 3 -s 50 -v -json -o results.json
```

### Visualization Tip
Use the `-g` flag to replace Guanines involved in the tetrads with a specific character. This makes the motif structure immediately visible in the sequence string.

```bash
# Highlight tetrads with '@'
./qgrs -i input.txt -g @
# Output example: @@@A@@@GC@@@TCT@@@
```

## Output Column Reference
When using the default column output, the data is organized as follows:
1.  **ID**: Sequence identifier (e.g., 1, 1.1 for overlaps).
2.  **Pos 1-4**: Start positions of the four G-tetrads relative to the sequence start.
3.  **Tetrads**: Number of tetrads in the motif.
4.  **G-Score**: Numerical score indicating the strength/stability of the motif.
5.  **Sequence**: The actual nucleotide string of the identified motif.

## Expert Best Practices
*   **Algorithm Constraints**: Note that `qgrs-cpp` applies a maximum length of 45nt for motifs with 3+ tetrads and 30nt for those with 2 tetrads.
*   **Large Scale Analysis**: For whole-genome scans, always use the `-json` or `-csv` flags and redirect to a file (`-o`) to avoid memory overhead in the terminal buffer.
*   **Handling Overlaps**: Use `-v` only when you need to analyze the competition between different quadruplex folding patterns. For simple mapping, the default (non-overlapping) output is significantly more concise.

## Reference documentation
- [qgrs-cpp GitHub Repository](./references/github_com_freezer333_qgrs-cpp.md)
- [Bioconda qgrs-cpp Package](./references/anaconda_org_channels_bioconda_packages_qgrs-cpp_overview.md)