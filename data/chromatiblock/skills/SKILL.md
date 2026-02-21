---
name: chromatiblock
description: Chromatiblock is a comparative genomics tool designed to visualize colinear blocks across multiple prokaryotic genomes.
homepage: http://github.com/mjsull/chromatiblock/
---

# chromatiblock

## Overview

Chromatiblock is a comparative genomics tool designed to visualize colinear blocks across multiple prokaryotic genomes. It helps researchers identify large-scale structural variations, such as inversions and translocations, by aligning core and non-core genomic regions. The tool produces both static (SVG/PNG/PDF) and interactive (HTML) visualizations, allowing for detailed exploration of syntenic regions and gene-level annotations.

## Installation and Environment

The most reliable way to use chromatiblock is via a dedicated Conda environment to manage its dependencies (Sibelia, BLAST+, and CairoSVG).

```bash
conda create --name chromatiblock
conda activate chromatiblock
conda install chromatiblock --channel conda-forge --channel bioconda
```

## Core CLI Usage

### Basic Visualization
To generate a standard SVG visualization from a directory of FASTA or GenBank files:

```bash
chromatiblock -d /path/to/genomes/ -w ./work_dir -o output.svg
```

### Interactive HTML Output
For large datasets, use the `.html` extension. This enables tooltips (showing block numbers and locations) and interactive highlighting of syntenic blocks across genomes.

```bash
chromatiblock -d /path/to/genomes/ -w ./work_dir -o output.html
```

### Defining Genome Order
By default, the first genome is used as the reference for core block alignment. Use an order list to control the vertical arrangement of isolates.

```bash
chromatiblock -d ./fastas -l order_list.txt -w ./work_dir -o output.html
```
*Note: `order_list.txt` should contain one filename per line.*

## Advanced Features and Customization

### Gene Annotation (BLASTx)
You can annotate specific genes of interest (e.g., toxins, resistance genes) across all genomes by providing a protein FASTA file. Chromatiblock will use BLASTx to locate these genes.

```bash
chromatiblock -d ./fastas -gb proteins_of_interest.faa -w ./work_dir -o output.html
```

### Custom Coloring and Categories
To color the "Alignment Difference" view (the bottom panel) by specific categories (e.g., "Pathogenicity Island", "Transposon"), provide a categories TSV file.

```bash
chromatiblock -d ./fastas -c categories.tsv -w ./work_dir -o output.html
```

### Tuning Alignment Sensitivity
Chromatiblock uses Sibelia for block generation. You can adjust the sensitivity based on the evolutionary distance of your isolates:

*   `loose` (Default): Best for closely related strains.
*   `fine`: Higher resolution for very similar sequences.
*   `far`: Better for more divergent prokaryotic genomes.

```bash
chromatiblock -d ./fastas -sm far -w ./work_dir -o output.svg
```

## Expert Tips

*   **Working Directory:** Always specify a `-w` (working directory). Chromatiblock generates significant intermediate data; keeping this separate prevents clutter and allows for troubleshooting.
*   **File Formats:** The tool automatically filters for `.fasta`, `.fa`, `.fna`, `.gb`, and `.gbk`. Ensure your files use these extensions.
*   **Dependencies:** If you are not using Conda, ensure `Sibelia` and `ncbi-blast+` are in your system PATH, or specify the Sibelia path explicitly using `-s`.
*   **Image Conversion:** If you require PNG or PDF output, ensure `cairosvg` is installed in your environment.

## Reference documentation
- [github_com_mjsull_chromatiblock.md](./references/github_com_mjsull_chromatiblock.md)
- [anaconda_org_channels_bioconda_packages_chromatiblock_overview.md](./references/anaconda_org_channels_bioconda_packages_chromatiblock_overview.md)