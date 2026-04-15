---
name: robust-bias-aware
description: This tool identifies stable disease-related modules by aggregating multiple Steiner Trees while correcting for gene study bias. Use when user asks to identify disease modules, find significant sub-networks from seed genes, or perform bias-aware network mining.
homepage: https://github.com/bionetslab/robust_bias_aware_pip_package
metadata:
  docker_image: "quay.io/biocontainers/robust-bias-aware:0.0.1--pyh7cba7a3_1"
---

# robust-bias-aware

## Overview
The ROBUST (Robust disease module mining) tool identifies disease-related modules by calculating multiple Steiner Trees and aggregating them to find stable, significant sub-networks. Its primary advantage is the "bias-aware" feature, which adjusts edge costs based on how frequently genes are used as baits or their general "study attention" in literature. This prevents the algorithm from simply picking the most well-documented genes and instead focuses on biologically relevant connections.

## Installation and Environment
ROBUST has a strict dependency on Python 3.7.
- **Conda**: `conda install bioconda::robust-bias-aware`
- **Pip**: `pip install robust-bias-aware`

## Command Line Usage
The basic command structure is:
`robust-bias-aware --seeds <seeds.txt> --outfile <output_file> [options]`

### Core Arguments
- `--seeds`: Path to a newline-separated text file containing seed gene identifiers.
- `--outfile`: The output format is determined by the file extension:
  - `.graphml`: Full graph data including vertex properties (`isSeed`, `significance`, `nrOfOccurrences`).
  - `.csv`: A table of vertices with occurrence percentages.
  - Any other extension: Generates a simple edge list.
- `--network`: Choose a built-in network (`BioGRID`, `APID`, `STRING`) or provide a path to a custom `.graphml`, `.csv`, `.tsv`, or `.txt` edgelist.

### Bias Correction Settings
- `--study-bias-scores`: Defines the correction method.
  - `BAIT_USAGE` (Default): Corrects based on how often a protein is used in experiments.
  - `STUDY_ATTENTION`: Corrects based on general research prevalence.
  - `NONE`: Runs standard ROBUST without bias correction (uniform edge costs).
- `--gamma`: (0.0 to 1.0) Controls the strength of the bias correction. 1.0 (default) applies full correction.
- `--namespace`: Set to `ENTREZ`, `GENE_SYMBOL` (default), or `UNIPROT` to match your seed list and bias data.

### Algorithm Tuning
- `--n`: Number of Steiner trees to generate (default: 30). Higher values increase robustness but take longer.
- `--tau`: Threshold for including a node in the final module based on its frequency across the `n` trees (default: 0.1).
- `--alpha` (0.25) and `--beta` (0.90): Parameters controlling the Steiner tree approximation.

## Common CLI Patterns

### Standard Bias-Aware Mining
```bash
robust-bias-aware --seeds my_seeds.txt --outfile module.graphml --network STRING --study-bias-scores BAIT_USAGE
```

### High-Stringency Module Extraction
To extract only the most frequently occurring nodes across iterations:
```bash
robust-bias-aware --seeds my_seeds.txt --outfile strict_module.csv --tau 0.5 --n 100
```

### Using Uniprot IDs with Custom Network
```bash
robust-bias-aware --seeds uniprot_seeds.txt --network my_network.edgelist --namespace UNIPROT --outfile output.graphml
```

## Expert Tips
- **Output Analysis**: Use the `.graphml` format if you intend to visualize the results in Cytoscape, as it preserves the `significance` and `nrOfOccurrences` attributes for every node.
- **Seed Selection**: Ensure your seed file contains only one identifier per line and matches the `--namespace` argument exactly to avoid empty modules.
- **Gamma Adjustment**: If the resulting module is too small or only contains seeds, try reducing `--gamma` (e.g., 0.5) to relax the bias penalty.

## Reference documentation
- [ROBUST GitHub Repository](./references/github_com_bionetslab_robust_bias_aware_pip_package.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_robust-bias-aware_overview.md)