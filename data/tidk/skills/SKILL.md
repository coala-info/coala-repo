---
name: tidk
description: The Telomere Identification toolKit (`tidk`) is a specialized suite of tools designed to locate and analyze telomeric repeats in genomic data.
homepage: https://github.com/tolkit/telomeric-identifier
---

# tidk

---

## Overview

The Telomere Identification toolKit (`tidk`) is a specialized suite of tools designed to locate and analyze telomeric repeats in genomic data. It is particularly effective for chromosomal-level assemblies but also supports raw long-read data. The toolkit provides a complete workflow: discovering potential repeat motifs de novo, searching for known motifs based on taxonomic clades, and generating SVG visualizations to identify telomere locations across scaffolds.

## Core Workflows

### 1. De Novo Discovery (explore)
Use the `explore` module when the specific telomeric repeat of an organism is unknown. It identifies frequent, tandemly repeated kmers at the ends of sequences.

*   **Standard Search**: `tidk explore --minimum 5 --maximum 12 input.fasta > repeats.tsv`
*   **Long-Read Analysis**: When working with PacBio HiFi reads, set the distance to 0.5 to search the entire length of the read:
    `tidk explore --minimum 5 --maximum 12 --distance 0.5 reads.fasta`
*   **Filtering**: Use `--threshold` (default 100) to ignore low-frequency repeats that may be noise.

### 2. Clade-Based Identification (find)
Use the `find` module to search for repeats known to exist in specific taxonomic groups. This uses a curated internal database.

*   **Database Setup**: Before first use, run `tidk build` to fetch the latest repeat data.
*   **Execution**: `tidk find -c <clade_name> -o output_prefix input.fasta`
*   **Available Clades**: Common clades include `Lepidoptera`, `Hymenoptera`, `Coleoptera`, `Rodentia`, and `Cypriniformes`. Use `tidk find --print` to see the full list of supported clades and their associated sequences.

### 3. Targeted Motif Search (search)
Use the `search` module if you already know the specific DNA string (e.g., "TTAGGG") you want to map.

*   **Command**: `tidk search --string TTAGGG --window 10000 --output my_search input.fasta`
*   **Output Formats**: By default, it produces a TSV. Use `--extension bedgraph` to generate files compatible with genome browsers like IGV.

### 4. Visualization (plot)
The `plot` module transforms the windowed counts from `find` or `search` into an SVG line graph.

*   **Command**: `tidk plot -t finder/output_telomeric_repeat_windows.tsv -o plot_name`
*   **Customization**:
    *   Adjust dimensions: `--height 150 --width 800`
    *   Visuals: `--strokewidth 1 --fontsize 10`

## Expert Tips and Best Practices

*   **Canonical Reporting**: `tidk explore` reports repeats in their canonical form (e.g., TTAGG is reported as AACCT). Always check the TSV output for the "canonical" column.
*   **Window Size**: The default window size is 10,000 bp. For highly fragmented assemblies, consider reducing the window size (`-w`) to capture telomeric signals on smaller scaffolds.
*   **Memory Efficiency**: `tidk` is written in Rust and is generally memory-efficient, but processing very large genomes with many small scaffolds can increase the output file size significantly.
*   **Distance Parameter**: The `--distance` flag in `explore` defines how far from the sequence ends the tool looks (as a proportion). The default `0.01` (1%) is perfect for chromosome-level assemblies to avoid internal repeat noise.

## Reference documentation
- [tidk GitHub Repository](./references/github_com_tolkit_telomeric-identifier.md)
- [tidk Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tidk_overview.md)