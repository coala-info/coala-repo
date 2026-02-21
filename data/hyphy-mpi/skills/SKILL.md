---
name: hyphy-mpi
description: HyPhy (Hypothesis Testing using Phylogenies) is a comprehensive software package for molecular evolution research.
homepage: http://hyphy.org/
---

# hyphy-mpi

## Overview

HyPhy (Hypothesis Testing using Phylogenies) is a comprehensive software package for molecular evolution research. This skill enables the execution of sophisticated evolutionary models to characterize selective pressures on genetic sequences. It focuses on the command-line interface (CLI) and the MPI-enabled version (`HYPHYMPI`), which is optimized for high-performance computing clusters. By leveraging this skill, you can automate the detection of selection at the site, branch, or gene-wide level, ensuring that the appropriate statistical method is matched to the specific biological hypothesis being tested.

## Core CLI Usage

HyPhy operates as a command-line tool where specific methods are called as subcommands.

### Basic Command Structure
```bash
hyphy <method> --alignment <path_to_alignment> [options]
```

### Common Arguments
- `--alignment`: Path to the multiple sequence alignment (FASTA, NEXUS, PHYLIP).
- `--tree`: Path to the Newick-formatted phylogeny (if not included in the alignment file).
- `--code`: Genetic code (default is `Universal` or `1`).
- `--output`: Path for the resulting JSON file.

### Running with MPI
For large datasets or computationally intensive methods (like GARD or FUBAR), use the MPI version to distribute the load:
```bash
mpirun -np <number_of_cores> HYPHYMPI <method> --alignment <path>
```

## Method Selection Guide

Choose the method based on the specific evolutionary question:

| Goal | Recommended Method |
| :--- | :--- |
| **Gene-wide selection** (Is the gene under selection anywhere?) | `busted` |
| **Branch-specific selection** (Which lineages are under selection?) | `absrel` |
| **Site-specific (Pervasive)** (Which sites are consistently selected?) | `fubar` (preferred) or `fel` |
| **Site-specific (Episodic)** (Which sites are selected on some branches?) | `meme` |
| **Selection Relaxation** (Has selection pressure changed on specific branches?) | `relax` |
| **Recombination Detection** (Screening for breakpoints before selection analysis) | `gard` |

## Expert Tips and Best Practices

1. **Recombination Screening**: Always run `gard` on your alignment before performing selection analyses. Recombination can cause false positives in selection detection. Use the resulting partitioned NEXUS file for subsequent analyses.
2. **FUBAR vs. FEL**: Use `fubar` for medium-to-large datasets as it is faster and generally more powerful for detecting pervasive selection. Use `fel` for smaller datasets.
3. **Branch Labeling**: For methods like `absrel`, `busted`, or `relax`, you can label branches in your Newick tree (e.g., `(A,B){Foreground},C;`) to test specific hypotheses about those lineages.
4. **Synonymous Rate Variation**: Always enable synonymous rate variation (default in most modern HyPhy methods) to avoid biases in dN/dS estimation.
5. **Visualization**: HyPhy outputs results in JSON format. These should be uploaded to [hyphy-vision](https://vision.hyphy.org) for interactive exploration and publication-quality figures.
6. **Interactive Mode**: If unsure of the required parameters for a new method, run `hyphy -i` to enter the interactive prompt, which will guide you through the necessary inputs.

## Reference documentation
- [Methods for Inferring Selection Pressure](./references/hyphy_org_methods_selection-methods.md)
- [Using HyPhy as a standard command line tool](./references/hyphy_org_tutorials_CLI-tutorial.md)
- [Installation and MPI versions](./references/hyphy_org_installation.md)
- [Selection Analysis Tutorials](./references/hyphy_org_tutorials_CL-prompt-tutorial.md)