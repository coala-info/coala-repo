---
name: tadtool
description: TADtool is a utility for Hi-C data analysis that enables interactive visualization and parameter optimization for identifying Topologically Associating Domains. Use when user asks to find optimal TAD-calling parameters, visualize insulation indices or directionality indices, and generate domain calls from contact matrices.
homepage: https://github.com/vaquerizaslab/tadtool
---


# tadtool

## Overview
TADtool is a specialized utility for Hi-C data analysis that helps researchers determine the most biologically meaningful parameters for TAD-calling algorithms. It bridges the gap between raw contact matrices and domain calls by providing an interactive environment to visualize how different window sizes and algorithms (Insulation Index, Normalized Insulation, or Directionality Index) impact the resulting TAD boundaries. Once optimal parameters are identified, the tool can be used via the command line to process full datasets.

## Installation and Setup
TADtool is available via PyPI or Bioconda. It is primarily supported on Linux and macOS.

```bash
# Via Conda
conda install bioconda::tadtool

# Via pip
pip install tadtool
```

## Core CLI Commands

### 1. Interactive Parameter Exploration (`plot`)
The `plot` command is the primary way to find the "sweet spot" for TAD calling. It requires a matrix, a BED file defining regions, and a specific genomic coordinate to visualize.

```bash
tadtool plot matrix.txt regions.bed chr12:31000000-33000000
```

**Key Arguments:**
- `-a [insulation|ninsulation|directionality]`: Select the algorithm. Default is `insulation`.
- `-w [sizes]`: Define window sizes. You can provide a file, a range (start stop step), or specific integers.
- `-m MAX_DIST`: Limit the distance from the diagonal to improve rendering speed.

### 2. Programmatic TAD Calling (`tads`)
Once you have identified the optimal window size and algorithm using the `plot` command, use `tads` to generate the final domain calls.

```bash
tadtool tads matrix.txt regions.bed <window_size> --algorithm insulation > output_tads.bed
```

### 3. Matrix Subsetting (`subset`)
For very large Hi-C matrices, use `subset` to create smaller files for faster interactive exploration.

## Data Format Requirements

### Hi-C Matrix
TADtool supports three matrix formats:
1. **Square Matrix**: Tab-delimited text file where rows = columns.
2. **Sparse Matrix**: Tab-delimited file with three columns: `<row_index> <column_index> <value>`.
3. **NumPy**: Binary `.npy` files for faster loading.

### Regions BED File
A standard BED file (Chromosome, Start, End) corresponding to the matrix bins.
- **Crucial**: The file must NOT have a header.
- If using sparse format, the fourth column should contain the unique identifier used in the matrix.

## Expert Tips and Best Practices
- **Memory Management**: Loading whole-genome matrices at high resolution can be extremely memory-intensive. It is recommended to use intra-chromosomal matrices or subsetted regions for the interactive `plot` tool.
- **Window Size Selection**: If you don't specify window sizes, TADtool defaults to logarithmic spacing. For the Insulation Index, it typically ranges between $10^4$ and $10^6$ bp.
- **Sparse vs. Dense**: For high-resolution data where the matrix is mostly zeros, use the sparse matrix format to significantly reduce file size and improve loading times.
- **Coordinate Standards**: Ensure your BED file coordinates follow the 0-indexed, half-open standard (BED3) to avoid off-by-one errors in boundary calls.

## Reference documentation
- [TADtool GitHub Repository](./references/github_com_vaquerizaslab_tadtool.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_tadtool_overview.md)