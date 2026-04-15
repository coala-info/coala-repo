---
name: smashpp
description: Smash++ identifies genomic rearrangements and similarities between DNA sequences using compression-based algorithms to generate position-based mapping data. Use when user asks to find rearrangements between a reference and target sequence, generate genomic similarity maps, or visualize genomic relationships in SVG format.
homepage: https://github.com/smortezah/smashpp
metadata:
  docker_image: "quay.io/biocontainers/smashpp:23.09--h9948957_1"
---

# smashpp

## Overview

Smash++ is a high-performance genomic tool designed for the rapid identification of rearrangements in DNA sequences. By utilizing compression-based algorithms, it detects similarities between a reference and a target sequence, producing position-based mapping data. This data can then be processed by the built-in visualizer to create vector-based (SVG) diagrams of genomic relationships.

## Core CLI Usage

The primary workflow involves two steps: generating a position/similarity file and then visualizing that file.

### 1. Finding Rearrangements
The basic command requires a reference and a target file.

```bash
smashpp -r reference.fasta -t target.fasta
```

**Common Options:**
- `-l [0-6]`: Compression level. Higher levels (default 3) increase sensitivity but take longer.
- `-m [INT]`: Minimum segment size (default 50). Increase this value to filter out small, potentially noisy matches.
- `-fmt [pos|json]`: Output format. Use `json` if you plan to process the data with external scripts; `pos` is the standard format for the internal visualizer.
- `-n [INT]`: Number of threads (default 4). Scale this based on available CPU cores for large genomes.

### 2. Visualizing Results
Use the `viz` sub-command to turn the output from the first step into a diagram.

```bash
smashpp viz -o similarity_map.svg input.pos
```

**Visualization Options:**
- `--vertical-view`: Switches the layout from horizontal to vertical.
- `-c [0|1]`: Toggles color modes.
- `-p [0.0-1.0]`: Adjusts the opacity of the links between sequences.
- `-rn "Name"` / `-tn "Name"`: Custom labels for the reference and target sequences in the output image.

## Expert Tips and Best Practices

- **Sequence Naming**: For the best visual results, use short, concise names in the headers of your FASTA/FASTQ files. Long headers can clutter the SVG labels.
- **Filtering Noise**: If the resulting map is too "busy" with small links, re-run the analysis with a higher `-m` (minimum segment size) or a larger `-f` (filter size).
- **Signal Smoothing**: The tool uses a windowing function (filter) to process the similarity signal. While `hann` (default) is suitable for most genomic data, you can experiment with `-ft` (filter type) using options like `hamming` or `triangular` for different smoothing effects.
- **Self-Complexity**: By default, the tool computes self-complexity. If you only care about the relationship between the two sequences and want to save time, use the `-nr` (no self-complexity) flag.
- **Inverted Repeats**: To specifically look for inversions, ensure the model parameters or default settings are capturing inverted repeats (controlled via `-rm` and `-tm` advanced model strings).

## Reference documentation
- [Smash++ GitHub Repository](./references/github_com_smortezah_smashpp.md)
- [Smash++ Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_smashpp_overview.md)