---
name: khipu-metabolomics
description: Khipu is a Python-based tool that organizes untargeted metabolomics features into "empirical compounds" using a tree-based grid structure.
homepage: https://github.com/shuzhao-li/khipu
---

# khipu-metabolomics

## Overview
Khipu is a Python-based tool that organizes untargeted metabolomics features into "empirical compounds" using a tree-based grid structure. It helps researchers move from a list of disparate m/z peaks to a structured set of related ions (isotopes and adducts) belonging to the same biological molecule. This is particularly useful for reducing data complexity and improving the accuracy of metabolite identification in both standard and isotope-labeled experiments.

## Installation
Install via pip or conda:
```bash
pip install khipu-metabolomics
# OR
conda install bioconda::khipu-metabolomics
```

## Common CLI Patterns

### Basic Annotation
To annotate a standard feature table (TSV format), use the following command:
```bash
khipu -i input_features.tsv -o output_prefix -m pos --ppm 10
```
*   `-i`: Input feature table (tab-delimited).
*   `-o`: Prefix for output files (generates `.json` and `.tsv`).
*   `-m`: Ionization mode (`pos` or `neg`).
*   `--ppm`: Mass tolerance for matching patterns.

### Handling Custom Feature Tables
If your input table has intensity data starting at a specific column, use the `-s` and `-e` flags:
```bash
khipu -i features.tsv -s 3 -e 12 -o annotated_data
```
*   `-s`: Start column index for intensity data (0-indexed).
*   `-e`: End column index for intensity data.

### Parameter Tuning
*   **Retention Time Tolerance**: Use `--rtol` to set the maximum allowed difference in retention time (in seconds) for features to be grouped into the same khipu.
*   **Mass Precision**: Adjust `--ppm` based on your instrument's resolution (e.g., 5 for Orbitrap, 20 for Q-TOF).

## Expert Tips
*   **Input Format**: Ensure your input TSV contains `feature_ID`, `m/z`, and `retention_time` as the first three columns unless specified otherwise via arguments.
*   **Empirical Compounds**: The output `.json` file contains the full hierarchical structure of the "khipu" trees, which is more informative for downstream software than the flattened `.tsv` file.
*   **Isotope Tracing**: While the CLI handles standard patterns, complex isotope tracing experiments are best handled by using khipu as a Python library within a Jupyter Notebook to define custom isotope search patterns.
*   **Integration with asari**: Khipu is the default pre-annotation engine for the `asari` preprocessing tool. If you are already using `asari`, khipu annotation is often performed automatically.

## Reference documentation
- [Khipu GitHub Repository](./references/github_com_shuzhao-li-lab_khipu.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_khipu-metabolomics_overview.md)