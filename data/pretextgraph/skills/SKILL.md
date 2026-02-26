---
name: pretextgraph
description: This tool overlays quantitative genomic data from bedGraph files onto Hi-C contact maps in Pretext format. Use when user asks to add genomic tracks to a Pretext file, visualize bedGraph data on a contact map, or convert BigWig files for Pretext visualization.
homepage: https://github.com/wtsi-hpag/PretextGraph
---


# pretextgraph

## Overview
The `pretextgraph` tool allows you to overlay quantitative genomic information onto existing Hi-C contact maps. By converting bedGraph data into a format compatible with Pretext files, you can visualize structural features and genomic tracks simultaneously. This skill provides the necessary command-line patterns to integrate these data layers, whether you are appending them to an existing file or creating a new annotated contact map.

## Usage Patterns

### Basic Command Structure
The tool requires an input Pretext file and a name for the graph track. Data is typically piped in from `stdin`.

```bash
PretextGraph -i input.pretext -n "track_name" < data.bedgraph
```

### Common Workflows

**1. Appending to an existing map**
If no output file is specified with `-o`, the graph data is appended directly to the input file.
```bash
PretextGraph -i map.pretext -n "Coverage" < coverage.bedgraph
```

**2. Creating a new annotated map**
To preserve the original file, specify an output path.
```bash
PretextGraph -i input.pretext -o output.pretext -n "Repeats" < repeats.bedgraph
```

**3. Processing compressed files**
Use `zcat` to stream gzipped bedGraph files directly into the tool.
```bash
zcat data.bedgraph.gz | PretextGraph -i map.pretext -n "MyGraph"
```

**4. Converting BigWig on the fly**
If your data is in BigWig format, use `bigWigToBedGraph` to pipe the data into `pretextgraph`.
```bash
bigWigToBedGraph input.bw /dev/stdout | PretextGraph -i map.pretext -n "BW_Track"
```

## Extension Types and Logic
The tool applies different mathematical treatments based on the name provided via the `-n` flag.

| Extension Name | Logic Applied |
| :--- | :--- |
| `coverage` | Adds weighted values of bins to the graph. |
| `coverage_avg` | Adds weighted values (averaged) to the graph. |
| `repeat_density` | Normalizes values by bin size (useful for repeat counts per bin). |
| `gap` | Binary logic: sets value to 1 if a gap exists in the pixel range, else 0. |
| `telomere` | Adds weighted values to the graph. |
| `not_weighted` | If "not" and "weighted" are in the name, values are accumulated without weighting. |
| `default` | Adds the weighted value of every bin. |

## Technical Requirements & Constraints
- **Input Format**: bedGraph files must use `\n` for newlines and `\t` (tabs) as separators.
- **Data Types**: Only non-negative integers are supported in the 4th column of the bedGraph.
- **Value Limits**: Maximum supported value is $2^{32} - 1$ (u32).
- **Sequence Names**: Chromosome/sequence names in the bedGraph must match those in the Pretext file exactly, though the sort order does not matter.
- **Noise Filter**: Enabled by default (1). Use `-nf 0` to disable it for coverage or repeat density tracks.

## Reference documentation
- [PretextGraph GitHub Repository](./references/github_com_sanger-tol_PretextGraph.md)