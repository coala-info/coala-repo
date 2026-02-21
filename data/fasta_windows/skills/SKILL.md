---
name: fasta_windows
description: `fasta_windows` is a high-performance tool implemented in Rust designed to compute sequence statistics across sliding windows for every record in a FASTA file.
homepage: https://github.com/tolkit/fasta_windows
---

# fasta_windows

## Overview
`fasta_windows` is a high-performance tool implemented in Rust designed to compute sequence statistics across sliding windows for every record in a FASTA file. It is particularly effective for large-scale genome assemblies, providing a rapid way to profile sequence composition, identify regions of interest (like CpG islands or skew shifts), and generate data for genomic visualization.

## Usage Instructions

### Basic Command
The tool requires an input FASTA file and an output prefix. By default, it uses a window size of 1000bp.

```bash
fasta_windows --fasta input.fasta --output results_prefix
```

### Common Options
- **Window Size (`-w`)**: Adjust the granularity of the analysis. For large genomes, a larger window (e.g., 5000 or 10000) may be more appropriate.
  ```bash
  fasta_windows -f input.fasta -o output -w 5000
  ```
- **Soft-masking (`-m`)**: Use this flag to consider only uppercase nucleotides in calculations. This is useful if the FASTA file uses lowercase to indicate repetitive or low-complexity regions that should be excluded from the statistics.
- **Include Descriptions (`-d`)**: Adds an extra column to the output containing the full FASTA header description rather than just the sequence ID.

### Output Files
The tool generates four TSV files using the provided output prefix:
1. `_windows.tsv`: The primary file containing GC proportion, GC/AT skew, Shannon entropy, and individual nucleotide proportions.
2. `_di.tsv`: Dinucleotide frequency arrays.
3. `_tri.tsv`: Trinucleotide frequency arrays.
4. `_tetra.tsv`: Tetranucleotide frequency arrays.

## Expert Tips and Best Practices

- **Storage Management**: Be aware that the tetranucleotide frequency file (`_tetra.tsv`) can become extremely large, as it contains 256 columns (4^4) for every window in the genome. Ensure sufficient disk space before running on large assemblies.
- **K-mer Ordering**: K-mers in the frequency files are sorted lexicographically from left to right (e.g., AA, AC, AG, AT... for dinucleotides).
- **Coordinate System**: The output uses a BED-like format for the first three columns (ID, start, end), making it easy to integrate with other bioinformatics tools like `bedtools` or for loading into genome browsers.
- **Handling Ambiguity**: The tool handles ambiguity codes in GC calculations and calculates masked proportions if the `-m` flag is used.
- **Downstream Analysis**: For grouping or visualizing these outputs, consider using the companion tools `fw_group` or `fw_plot` mentioned in the developer documentation.

## Reference documentation
- [fasta_windows - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fasta_windows_overview.md)
- [GitHub - tolkit/fasta_windows: A Rust implementation of sliding window stats over fastas.](./references/github_com_tolkit_fasta_windows.md)