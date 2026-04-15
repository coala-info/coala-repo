---
name: grapetree
description: GrapeTree is a tool for the visualization and analysis of phylogenetic trees, specializing in creating Minimum Spanning Trees from allelic profiles or sequence alignments. Use when user asks to generate trees from MLST data, visualize genomic epidemiology results, or interactively explore tree topologies with integrated metadata.
homepage: https://github.com/achtman-lab/GrapeTree
metadata:
  docker_image: "quay.io/biocontainers/grapetree:2.1--pyh3252c3a_0"
---

# grapetree

## Overview

GrapeTree is a specialized tool for the visualization and analysis of phylogenetic trees, particularly optimized for genomic epidemiology. It excels at creating Minimum Spanning Trees (MST) from allelic profiles (MLST) or sequence alignments. The tool provides a dual-purpose interface: a command-line utility for deterministic tree generation and a web-based interactive viewer for exploring tree topology, branch recrafting, and metadata integration.

## Installation and Setup

GrapeTree can be installed via pip or conda:

```bash
# Via pip
pip install grapetree

# Via Bioconda
conda install bioconda::grapetree
```

## Command Line Usage

The `grapetree` command-line tool is used to generate trees in NEWICK format from character data.

### Basic Tree Generation
To generate a tree from an allelic profile and save it to a file:
```bash
grapetree --profile input_data.profile > output_tree.nwk
```

### Recommended MSTreeV2 Workflow
MSTreeV2 is the default and generally preferred method as it handles missing data more effectively and supports asymmetric distance matrices.
```bash
grapetree --profile data.profile --method MSTreeV2 --matrix asymmetric --recraft > tree.nwk
```

### Handling Large Datasets
For very large datasets where standard MST methods may be slow, use the RapidNJ algorithm:
```bash
grapetree --profile alignment.fasta --method RapidNJ --n_proc 8 > tree.nwk
```

### Key Parameters
- `--profile (-p)`: [Required] Input file (MLST/SNP profile or aligned FASTA).
- `--method (-m)`: Tree algorithm. Options: `MSTreeV2` (default), `MSTree`, `NJ`, `RapidNJ`, `distance`.
- `--matrix (-x)`: Distance matrix type. Use `asymmetric` for MSTreeV2 and `symmetric` for others.
- `--recraft (-r)`: Triggers local branch recrafting to improve tree topology.
- `--n_proc (-n)`: Number of CPU processes for parallel execution (default is 5).
- `--check (-c)`: Use this to calculate expected time and memory requirements before running a large analysis.

## Input Data Formats

### Allele Profiles
- **Format**: Tab-delimited text.
- **Header**: Must start with `#`. The first column must contain unique strain identifiers.
- **Missing Data**: Represent missing alleles with `0` or `-`.

### Aligned FASTA
- Standard multiple sequence alignment where all sequences are the same length. GrapeTree currently supports p-distance for sequence data.

## Interactive Visualization

To launch the local web interface for interactive tree manipulation:
```bash
grapetree
```
This starts a lightweight web server (usually at `http://127.0.0.1:8000/`). You can then drag and drop your generated NEWICK files or raw profile data directly into the browser.

### Metadata Integration
In the web interface, you can upload a metadata file (tab or comma-delimited) to color nodes or group strains. The metadata file must have a column labeled `ID` that matches the strain identifiers in your profile or tree.

## Expert Tips

1. **Missing Data Handling**: When using a symmetric distance matrix, use the `--missing` flag to control how gaps are treated:
   - `0`: Ignore missing data in pairwise comparisons (default).
   - `1`: Remove any column containing missing data.
   - `2`: Treat missing data as a unique allele.
2. **Heuristics**: For MSTree and MSTreeV2, you can adjust the tiebreak heuristic using `--heuristic`. `harmonic` is the default for MSTreeV2, while `eBurst` is the default for the original MSTree.
3. **Memory Efficiency**: If you encounter memory errors on large profiles, ensure you are using the latest version and consider using the `--check` flag to verify if your hardware can support the matrix size.

## Reference documentation
- [GrapeTree GitHub Repository](./references/github_com_achtman-lab_GrapeTree.md)
- [GrapeTree Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_grapetree_overview.md)