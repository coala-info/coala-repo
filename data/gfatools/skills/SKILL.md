---
name: gfatools
description: gfatools is a high-performance utility for manipulating and converting sequence graphs in GFA and rGFA formats. Use when user asks to extract subgraphs, convert graphs to FASTA sequences, or generate BED files from reference GFA data.
homepage: https://github.com/lh3/gfatools
---


# gfatools

## Overview

gfatools is a high-performance utility for handling sequence graphs, commonly used in pangenomics and genome assembly. It provides a bridge between complex graph structures and traditional linear sequence formats. Use this skill to navigate graph topologies, extract local neighborhoods around specific segments, and prepare graph-based data for downstream analysis tools that require FASTA or BED inputs.

## Command Line Usage

### Subgraph Extraction
The `view` command is the primary way to subset a large GFA file. This is essential for visualizing or analyzing specific genomic regions within a pangenome.

*   **Extract by segment and radius**: To extract a segment and its neighbors within a certain distance (range):
    ```bash
    gfatools view -l [segment_name] -r [radius] input.gfa > subgraph.gfa
    ```
    *Note: The radius `-r` defines how many steps away from the target segment the tool should traverse.*

### Format Conversion
gfatools allows for the conversion of graph segments into linear formats for use in standard bioinformatics pipelines.

*   **Convert GFA to Segment FASTA**: Extracts every segment in the graph as a separate FASTA record.
    ```bash
    gfatools gfa2fa input.gfa > segments.fa
    ```

*   **Convert rGFA to Stable FASTA**: When working with Reference GFA (rGFA), use the `-s` flag to produce stable sequences (reconstructing the reference paths).
    ```bash
    gfatools gfa2fa -s input.gfa > reference.fa
    ```

*   **Convert rGFA to BED**: Useful for identifying the coordinates of segments relative to the reference path.
    ```bash
    gfatools gfa2bed -m input.gfa > coordinates.bed
    ```
    *The `-m` flag is often used to handle multiple ranks/levels in the rGFA.*

## Expert Tips and Best Practices

1.  **rGFA vs. GFA**: Always verify if your input is a standard GFA or an rGFA (which contains `SN`, `SO`, and `SR` tags). Commands like `gfa2bed` and the `-s` flag in `gfa2fa` are specifically designed for rGFA and may not produce meaningful output on standard assembly graphs.
2.  **Piping for Efficiency**: gfatools is designed to work well in Unix pipes. You can subset a graph and immediately convert it to FASTA without writing intermediate GFA files:
    ```bash
    gfatools view -l seg1 -r 2 input.gfa | gfatools gfa2fa - > sub_segments.fa
    ```
3.  **Memory Management**: While gfatools is efficient, extremely large pangenome graphs (e.g., human pangenomes) may require significant RAM for certain operations. Subsetting with `view` first is recommended before performing complex conversions.

## Reference documentation
- [gfatools GitHub Repository](./references/github_com_lh3_gfatools.md)
- [gfatools Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gfatools_overview.md)