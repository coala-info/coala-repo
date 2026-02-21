---
name: alcor
description: "FAIL to generate CWL: alcor not found in Singularity image. The image may not provide this executable."
homepage: https://cobilab.github.io/alcor/
---

# alcor

## Overview

AlcoR is a specialized toolkit designed for the characterization of low-complexity regions (LCRs) in genomic and proteomic sequences. By utilizing smoothed-segmented bi-directional data compression rather than traditional alignment, AlcoR achieves high sensitivity in detecting repetitive elements. This skill enables workflows for sequence simulation, automated mapping of LCRs, sequence masking (soft/hard masking), and the generation of high-quality SVG visualizations for comparative genomics.

## Core CLI Tools

AlcoR is invoked using specific sub-commands:

- `AlcoR info`: Displays general information about the toolkit.
- `AlcoR extract`: Extracts specific sub-sequences from FASTA files.
- `AlcoR mapper`: The primary engine for identifying and masking LCRs.
- `AlcoR simulation`: Generates synthetic sequences with controlled LCR properties.
- `AlcoR visual`: Converts mapping data into visual SVG representations.

## Mapping and Masking LCRs

The `mapper` tool uses context models to identify regions of low information entropy.

### Basic Mapping
To map LCRs in a DNA sequence and output to a CSV:
```bash
AlcoR mapper -v -w 10 --dna -m 11:50:0:1:0:0.9/0:0:0 input.fasta > LCRs.csv
```

### Sequence Masking
To mask LCRs (converting them to lowercase) in a genome:
```bash
AlcoR mapper -v --threshold 0.5 --ignore 20 --dna -w 10 -m 14:50:0:1:10:0.9/3:10:0.9 -k -o masked_output.fa input.fa
```
- `-k`: Enables masking mode.
- `--threshold`: Sets the sensitivity (lower values are more stringent).
- `--ignore`: Skips regions shorter than the specified symbol count.

### Expert Parameters for Mapper
- `-w <size>`: Window size for analysis. Use smaller windows (e.g., 10-50) for local LCRs and larger windows (e.g., 5000) for distant similarities.
- `-m <params>`: Model configuration. Format: `order:size:alpha:beta:gamma:delta`.
- `--renormalize`: Useful when processing multi-FASTA files to ensure consistent complexity scoring across sequences.

## Simulation of LCRs

AlcoR can generate synthetic data for testing or modeling.

### Generating Synthetic Sequences
```bash
AlcoR simulation -rs 2000:0:1:0:0:0 -fs 1:2000:1:3:0:0:0:template.fa > simulated.fasta
```
- `-rs`: Generates a pseudo-random sequence (size:seed:model...).
- `-fs`: Extracts and incorporates a sub-sequence from an existing FASTA file.

## Visualization

The `visual` tool creates SVG maps from the output of the `mapper`.

### Creating a Visual Map
```bash
AlcoR visual -v -o map.svg LCRs.csv
```

### Comparative Visualization
To compare multiple genomes in a single map, concatenate their mapping outputs or provide them as a colon-separated list:
```bash
AlcoR visual -o comparative_map.svg --strict-corner -s 10 -w 10 -e 0 genome1.txt:genome2.txt:genome3.txt
```
- `-s`: Scale factor for the image.
- `-w`: Width of the representation.
- `--border-color`: Hex code for visual styling (e.g., `cccccc`).

## Best Practices

1. **Memory Management**: AlcoR uses multithreading. Ensure your environment has sufficient threads for large-scale whole-genome mapping.
2. **Model Selection**: For DNA, always include the `--dna` flag to optimize the compression models for a 4-symbol alphabet.
3. **Threshold Tuning**: Start with a threshold of `0.5` for general masking. Increase to `1.0` or higher to capture only the most highly repetitive regions.
4. **File Prefixes**: When running batch operations on multi-FASTA files, use `--prefix` to prevent output file name collisions.

## Reference documentation
- [AlcoR Homepage](./references/cobilab_github_io_alcor.md)
- [AlcoR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_alcor_overview.md)