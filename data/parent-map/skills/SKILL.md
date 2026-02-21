---
name: parent-map
description: The `parent-map` tool is a specialized bioinformatics utility used to determine the lineage of synthetic or evolved biological sequences.
homepage: https://github.com/damienmarsic/parent-map
---

# parent-map

## Overview
The `parent-map` tool is a specialized bioinformatics utility used to determine the lineage of synthetic or evolved biological sequences. When provided with a set of "parent" sequences and a set of "variant" sequences, the tool identifies which parent contributed to each part of a variant's sequence. This is essential for researchers working in synthetic biology and protein engineering to verify recombination patterns, identify crossover points, and quantify parental inheritance in library construction.

## Installation and Setup
The tool can be installed via Bioconda or PyPI. Bioconda is generally preferred for managing bioinformatics dependencies.

```bash
# Via Conda
conda install -c bioconda parent-map

# Via Pip
pip install parent-map
```

Note: If using `pip`, you may need to manually install the `gooey` package if you intend to use the Graphical User Interface (GUI).

## Core Workflow
The tool operates in two primary modes: GUI (no arguments) and Console (with arguments). For automated workflows, use the console mode.

### 1. Prepare Input Files
You need two primary FASTA files:
- **Parents File**: Contains the original template sequences (e.g., `parents.fasta`).
- **Variants File**: Contains the evolved or engineered sequences to be analyzed (e.g., `variants.fasta`).

### 2. Basic Execution
Run the tool using the command line. If the `parent-map` command is not in your path, use the Python module execution.

```bash
# Standard CLI usage
parent-map --parents parents.fasta --variants variants.fasta

# Alternative execution
python -m parent-map --parents parents.fasta --variants variants.fasta
```

### 3. Accessing Help
To see all available parameters, including alignment settings and output formatting, use the help flag:
```bash
parent-map -h
```

## Best Practices and Tips
- **Sequence Alignment**: Ensure your parent sequences are well-defined. The tool performs internal alignments, but providing clean, high-quality FASTA files prevents mapping errors.
- **Output Interpretation**: `parent-map` generates several output files. Focus on:
    - `.html` files: These provide a visual, color-coded map of parental contributions, making it easy to spot recombination hotspots.
    - `stats.txt`: Use this for quantitative analysis of parental representation across your entire library.
    - `aln.txt`: Review this to verify the underlying alignments if a specific variant mapping looks unexpected.
- **Protein vs. DNA**: The tool is versatile and handles both nucleotide and amino acid sequences. Ensure your input files are consistent (do not mix DNA parents with protein variants).
- **GUI for Exploration**: If you are unsure about which parameters to tune (such as gap penalties or thresholding), run `parent-map` without arguments to launch the GUI. This allows for interactive adjustment before committing to a CLI-based pipeline.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_damienmarsic_Parent-map.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_parent-map_overview.md)