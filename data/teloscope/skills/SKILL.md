---
name: teloscope
description: Teloscope identifies and quantifies terminal and interstitial telomeric repeats within genome assemblies to generate BED-formatted annotations. Use when user asks to annotate telomeres, detect interstitial telomeric sequences, or calculate repeat density and sequence metrics across sliding windows.
homepage: https://github.com/vgl-hub/teloscope
metadata:
  docker_image: "quay.io/biocontainers/teloscope:0.1.3--h35c04b2_0"
---

# teloscope

## Overview
Teloscope is a specialized bioinformatics tool designed for the rapid identification and quantification of telomeric repeats within genome assemblies. It processes FASTA files (including compressed .gz) to generate BED-formatted annotations of both terminal and interstitial telomeres. By utilizing prefix trees and sliding windows, it efficiently handles multiple repeat patterns and provides detailed metrics on sequence composition and complexity.

## Installation
The easiest way to install teloscope is via Bioconda:
```bash
conda install bioconda::teloscope
```

## Common CLI Patterns

### Basic Telomere Annotation
To run a standard scan for canonical telomeres (TTAGGG) on a genome assembly:
```bash
teloscope -f assembly.fasta -o output_dir/
```

### Custom Repeat Patterns
If working with non-standard telomeres or specific variants, define the canonical repeat and additional patterns. Teloscope supports IUPAC format for patterns:
```bash
teloscope -f assembly.fasta -c TTAGGG -p TCAGGG,TGAGGG,TTGGGG
```

### Comprehensive Window Metrics
To generate detailed metrics including repeat density, GC content, and Shannon entropy across sliding windows:
```bash
teloscope -f assembly.fasta -o results/ -r -g -e --verbose
```

### Detecting Interstitial Telomeres (ITSs)
By default, teloscope may run in "ultra-fast" mode which focuses on contig ends. To perform a full assembly scan for interstitial telomeres, ensure the ultra-fast flag is managed (note: `-u` is true by default in some versions, so check your version's defaults):
```bash
teloscope -f assembly.fasta --out-its
```

## Parameter Reference

### Required
- `-f`, `--input-sequence`: Path to the input FASTA file (.fa or .fa.gz).

### Search Configuration
- `-c`, `--canonical`: The primary telomeric repeat (Default: TTAGGG).
- `-p`, `--patterns`: Comma-separated list of variant patterns to explore.
- `-t`, `--terminal-limit`: Distance from contig ends to search for terminal telomeres (Default: 50000 bp).
- `-k`, `--max-match-distance`: Maximum distance allowed between matches to merge them (Default: 50).

### Window Analysis
- `-w`, `--window`: Size of the sliding window (Default: 1000).
- `-s`, `--step`: Step size for the sliding window (Default: 500).

### Output Toggles
- `-r`, `--out-win-repeats`: Output repeat density per window.
- `-g`, `--out-gc`: Output GC content per window.
- `-e`, `--out-entropy`: Output Shannon entropy per window.
- `-i`, `--out-its`: Output interstitial telomere regions.

## Expert Tips
- **IUPAC Support**: Use IUPAC ambiguity codes in the `-p` parameter to capture multiple variants with a single string (e.g., `NNNGGG`).
- **Reverse Complements**: You do not need to provide reverse complements of your patterns; teloscope automatically scans for both strands.
- **Memory and Threads**: Use `-j` to specify threads. Teloscope is optimized for speed using prefix trees, making it suitable for large, highly fragmented assemblies.
- **Output Interpretation**: 
    - `terminal_telomeres.bed`: The primary file for chromosome-end annotations.
    - `window_metrics.bedgraph`: Best for visualizing telomeric "strength" or decay in a genome browser like IGV.

## Reference documentation
- [teloscope - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_teloscope_overview.md)
- [GitHub - vgl-hub/teloscope: A comprehensive telomere annotation tool](./references/github_com_vgl-hub_teloscope.md)