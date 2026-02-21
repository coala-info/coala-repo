---
name: pasta
description: PASTA is a specialized tool for biological sequence analysis that scales multiple sequence alignment to massive datasets.
homepage: https://github.com/smirarab/pasta
---

# pasta

## Overview
PASTA is a specialized tool for biological sequence analysis that scales multiple sequence alignment to massive datasets. It operates by decomposing large datasets into smaller, manageable subsets, aligning them, and then merging the results using a transitivity-based approach. This iterative process alternates between improving the alignment and the phylogenetic tree, making it a robust choice for complex evolutionary studies.

## Command Line Usage

### Basic Execution
The most common way to run PASTA is by providing an input FASTA file. By default, PASTA will automatically estimate a starting tree and pick appropriate configurations.

```bash
run_pasta.py -i input_sequences.fasta
```

### Providing a Starting Tree
If you have a pre-computed tree, providing it can significantly improve the speed and accuracy of the initial iteration.

```bash
run_pasta.py -i input_sequences.fasta -t starting_tree.tre
```

### Selecting Specific Aligners
PASTA supports several underlying aligners. You can specify one using the `--aligner` flag. Supported options include `ginsi`, `homologs`, `contralign`, and `probcons`.

```bash
run_pasta.py -i input_sequences.fasta --aligner=ginsi
```

### Using MAFFT-Homologs or Contralign
To use `mafft-homologs` or `contralign`, you must set the environment variable pointing to the tools directory:

```bash
export CONTRALIGN_DIR=/path/to/sate-tools-linux
run_pasta.py -i input_sequences.fasta --aligner=contralign
```

## Expert Tips and Best Practices

- **Memory Management**: For ultra-large alignments (100k+ sequences), ensure you have significant temporary disk space, as PASTA generates many intermediate files during the decomposition and merging phases.
- **Automated Configuration**: Unless you have specific requirements for sub-alignment size or decomposition strategy, let PASTA use its default automated configurations, which are optimized for most biological datasets.
- **TreeShrink Integration**: Use the `--treeshrink-filter` option if your dataset is prone to long-branch attraction or contains outlier sequences that might distort the alignment.
- **GUI Access**: If working in a local environment with `wxPython` installed, you can use `run_pasta_gui.py` for a visual interface to configure parameters.
- **Conda Installation**: The most reliable way to manage dependencies (like Dendropy and Java) is via Bioconda: `conda install bioconda::pasta`.

## Reference documentation
- [PASTA Overview and Installation](./references/anaconda_org_channels_bioconda_packages_pasta_overview.md)
- [PASTA GitHub README and Usage Guide](./references/github_com_smirarab_pasta.md)