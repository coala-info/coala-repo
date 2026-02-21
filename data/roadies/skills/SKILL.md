---
name: roadies
description: ROADIES (Reference-free Orthology-free Alignment-free DIscordance aware Estimation of Species tree) is an end-to-end automated pipeline designed to reconstruct species trees from raw genomic data.
homepage: https://github.com/TurakhiaLab/ROADIES
---

# roadies

## Overview
ROADIES (Reference-free Orthology-free Alignment-free DIscordance aware Estimation of Species tree) is an end-to-end automated pipeline designed to reconstruct species trees from raw genomic data. Unlike traditional methods that require a reference genome or the identification of specific orthologous genes, ROADIES processes assemblies directly. It is particularly useful for researchers seeking a scalable solution that accounts for phylogenetic discordance while allowing for a flexible trade-off between runtime and tree accuracy.

## Execution Patterns

### Standard High-Accuracy Run
By default, ROADIES performs multiple iterations to converge on a highly accurate species tree. This is the recommended mode for final analysis.

```bash
python run_roadies.py --cores <number_of_cores>
```

### Quick Testing and Validation
To perform a rapid initial check of the data or to generate a preliminary tree, use the `--noconverge` flag. This limits the pipeline to a single iteration.

```bash
python run_roadies.py --cores 16 --noconverge
```

### Post-Processing: Rerooting
ROADIES produces unrooted trees by default. To root the resulting tree, use the provided utility script located in the workflow directory. This requires a reference rooted species tree as an input for comparison.

```bash
python workflow/scripts/reroot.py -t <roadies_output.nwk> -r <reference_rooted_tree.nwk>
```

## Input Requirements and Preparation

### Genome Formatting
*   **File Types**: Input assemblies must be in `.fa` or `.fa.gz` format.
*   **Naming Convention**: Files should be named according to the species (e.g., `Homo_sapiens.fa`).
*   **Species Integrity**: Each file must contain sequences for only one species.

### Handling Multi-Species Files
If your input files contain multiple species, they must be split before running the pipeline. Use the `faSplit` utility:

```bash
faSplit byname <input_directory> <output_directory>
```

## Best Practices and Expert Tips

*   **Resource Allocation**: Always specify the `--cores` parameter to match your hardware capabilities, as the alignment-free steps are highly parallelizable.
*   **Convergence Monitoring**: When running in default mode, ROADIES saves the Newick tree for each iteration in `converge_files/iteration_<n>/`. The latest iteration typically represents the most confident and accurate tree.
*   **Output Locations**: 
    *   In single-iteration mode (`--noconverge`), the final tree is saved as `output_files/roadies.nwk`.
    *   In default mode, check the highest-numbered iteration folder for the final result.
*   **Configuration**: Before execution, ensure the `GENOMES` field in the configuration file points to the correct paths of your assembly files.

## Reference documentation
- [ROADIES GitHub Repository](./references/github_com_TurakhiaLab_ROADIES.md)
- [ROADIES Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_roadies_overview.md)