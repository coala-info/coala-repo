---
name: hyphy
description: HyPhy is a specialized framework for comparative sequence analysis used to identify selective pressures at the gene, site, or branch level. Use when user asks to detect selection using methods like FEL, MEME, or BUSTED, test for relaxation of selection with RELAX, or identify recombination using GARD.
homepage: http://hyphy.org/
---

# hyphy

## Overview
HyPhy (Hypothesis Testing using Phylogenies) is a specialized framework for comparative sequence analysis. It is primarily used by bioinformaticians to identify selective pressures at the gene, site, or branch level. While it provides a powerful scripting language (HBL) for custom model development, most users interact with it through a library of standardized, high-performance analysis pipelines. It supports nucleotide, amino-acid, and codon data, and is optimized for multi-threaded (MP) or cluster-based (MPI) execution.

## CLI Usage Patterns
The `hyphy` command (or `HYPHYMP`) typically triggers an interactive menu if run without arguments. For automated workflows, provide the path to a standard analysis or a custom `.bf` script.

### Running Standard Analyses
Standard analyses are located in the HyPhy library directory. You can call them by name or path:
```bash
# General syntax
hyphy <analysis_name> --alignment <path> --tree <path> [options]

# Example: Detecting selection at sites using FEL
hyphy fel --alignment data.fasta --tree tree.nwk --code Universal
```

### Common Selection Detection Methods
*   **FUBAR**: Preferred for pervasive selection (sites). Fast and Bayesian.
*   **MEME**: Preferred for episodic selection (sites). Detects selection that affects only a subset of branches.
*   **aBSREL**: Preferred for branch-specific selection. Tests if specific lineages have experienced diversification.
*   **BUSTED**: Gene-wide test for episodic selection. Use when you want to know if *any* site on *any* branch is under selection.
*   **RELAX**: Tests if selection pressure has been relaxed or intensified on a set of "test" branches compared to "reference" branches.

### Environment and Paths
If HyPhy cannot find its library files, specify the `LIBPATH` or set the environment variable:
```bash
# Inline path specification
hyphy LIBPATH=/usr/local/lib/hyphy <analysis>

# Environment variable
export HYPHY_LIB_PATH=/usr/local/lib/hyphy
```

## HyPhy Batch Language (HBL) Basics
For custom scripts, HBL uses a syntax similar to C/C++.
*   **Namespaces**: Use the dot notation (e.g., `namespace.variable`) to avoid global scope collisions.
*   **Local Functions**: Use `lfunction` instead of `function` to ensure variables remain scoped to the function.
*   **Data Loading**:
    ```hbl
    DataSet myData = ReadDataFile("path/to/file.fasta");
    DataSetFilter myFilter = CreateFilter(myData, 1); // 1 = Nucleotide/Standard
    ```

## Expert Tips
*   **Recombination**: Always run **GARD** (Genetic Algorithm for Recombination Detection) before selection analyses, as recombination can cause false positives in selection detection.
*   **Parallelization**: Use `HYPHYMPI` for large datasets or complex models like GARD and FUBAR to distribute the load across cluster nodes.
*   **Genetic Codes**: Ensure the correct `--code` is specified (e.g., `Universal`, `Vertebrate-mtDNA`).
*   **Output**: HyPhy generates JSON files containing detailed results. Use `hyphy-vision` or web-based tools to visualize these results interactively.



## Subcommands

| Command | Description |
|---------|-------------|
| hyphy_mcc | Test for |
| hyphy_mclk | RUNNING MOLECULAR CLOCK ANALYSIS |
| hyphy_meme | Available analysis command line options |
| hyphy_mgvsgy | Choose Genetic Code |
| hyphy_molerate | Available analysis command line options |
| hyphy_mss-ga | Genetic Algorithms for Recombination Detection. Implements a heuristic approach to screening alignments of sequences for recombination, by using the CHC genetic algorithm to search for phylogenetic incongruence among different partitions of the data. The number of partitions is determined using a step-down procedure, while the placement of breakpoints is searched for with the GA. The best fitting model (based on c-AIC) is returned; and additional post-hoc tests run to distinguish topological incongruence from rate-variation. v0.2 adds and spooling results to JSON after each breakpoint search conclusion |
| hyphy_mss-ga-processor | Read an alignment (and, optionally, a tree) remove duplicate sequences, and prune the tree accordingly. |
| hyphy_mt | RUNNING MODEL TESTING ANALYSIS Based on the program ModelTest |
| mss_joint_fitter | Performs a joint MSS model fit to several genes jointly. |

## Reference documentation
- [HyPhy Overview](./references/hyphy_org_about.md)
- [Getting Started with HyPhy](./references/hyphy_org_getting-started.md)
- [Selection Methods Guide](./references/hyphy_org_methods_selection-methods.md)
- [HBL libv3 Reference](./references/github_com_veg_hyphy_wiki_libv3.md)
- [Installation and CLI Options](./references/hyphy_org_installation.md)