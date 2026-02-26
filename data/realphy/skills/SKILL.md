---
name: realphy
description: Realphy performs sequence alignment and phylogenetic tree construction. Use when user asks to align DNA or protein sequences, infer evolutionary relationships, or generate phylogenetic trees.
homepage: https://realphy.unibas.ch/fcgi/realphy
---


# realphy

yaml
name: realphy
description: |
  Performs sequence alignment and phylogenetic tree construction. Use when Claude needs to:
  1. Align DNA or protein sequences.
  2. Infer evolutionary relationships between sequences.
  3. Generate phylogenetic trees from aligned sequences.
  4. Work with bioinformatics tasks requiring sequence alignment and phylogeny.
```
## Overview
Realphy is a bioinformatics tool designed for sequence alignment and phylogenetic tree construction. It takes biological sequences as input, aligns them to identify homologous regions, and then uses these alignments to infer the evolutionary history and relationships among the sequences, ultimately generating a phylogenetic tree.

## Usage Instructions

Realphy is typically used via its command-line interface. The core workflow involves providing input sequences and specifying parameters for alignment and tree building.

### Basic Usage

The most common usage involves providing an input file containing sequences and specifying an output directory.

```bash
realphy -i <input_sequences.fasta> -o <output_directory>
```

### Key Parameters

*   `-i, --input`: Path to the input file containing sequences (e.g., FASTA format).
*   `-o, --output`: Directory where output files (alignment, tree) will be saved.
*   `-m, --method`: Alignment method to use. Common options include `muscle` and `mafft`. If not specified, a default method will be used.
*   `-t, --tree`: Tree building method. Common options include `iqtree` and `fasttree`. If not specified, a default method will be used.
*   `-p, --protein`: Flag to indicate if the input sequences are proteins (default is DNA).
*   `--threads`: Number of threads to use for alignment and tree building.

### Example Workflow

To align protein sequences using MAFFT and build a phylogenetic tree using IQ-TREE, saving the output to a directory named `realphy_results`:

```bash
realphy -i protein_sequences.fasta -o realphy_results -m mafft -t iqtree -p --threads 8
```

### Expert Tips

*   **Sequence Format**: Ensure your input sequences are in a standard format like FASTA. Mixed sequence types (DNA and protein) in a single file are generally not supported.
*   **Alignment Method**: For highly divergent sequences, consider using more sensitive alignment methods. For large datasets, faster methods might be preferable. Experiment with different methods to see which yields the best results for your specific data.
*   **Tree Building Method**: IQ-TREE is generally recommended for its accuracy and speed, especially with large datasets. FastTree is a good alternative for very large datasets where speed is paramount.
*   **Resource Management**: For large datasets, utilize the `--threads` option to leverage multiple CPU cores for faster processing. Monitor memory usage, as large alignments and tree building can be memory-intensive.
*   **Output Files**: Realphy typically generates an alignment file (e.g., `.aln` or `.fasta`) and a phylogenetic tree file (e.g., `.tree` or `.nwk`). Familiarize yourself with the output formats for downstream analysis.

## Reference documentation
- [Realphy Overview](./references/anaconda_org_channels_bioconda_packages_realphy_overview.md)