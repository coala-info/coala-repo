---
name: phyml
description: PhyML estimates phylogenetic trees from sequence alignments using the Maximum Likelihood principle. Use when user asks to build a phylogeny, optimize tree topologies using NNI or SPR moves, or calculate branch support through bootstrapping or aLRT.
homepage: http://www.atgc-montpellier.fr/phyml/
metadata:
  docker_image: "quay.io/biocontainers/phyml:3.3.20220408--h9bc3f66_3"
---

# phyml

## Overview

PhyML is a specialized tool for estimating phylogenies using the Maximum Likelihood (ML) principle. It is designed to handle moderate to large datasets (up to 4,000 sequences) with high efficiency. Use this skill to guide the selection of substitution models, optimize tree topologies using NNI or SPR moves, and calculate branch support to assess the reliability of phylogenetic trees.

## Command Line Usage

### Basic Execution
The most common entry point for PhyML requires an input alignment in PHYLIP format.

```bash
# Basic run for DNA sequences
phyml -i alignment.phy -d nt

# Basic run for Amino Acid sequences
phyml -i alignment.phy -d aa
```

### Model Selection and Parameters
*   **Substitution Models**: Specify the model using `-m`. For DNA, common choices are HKY85 (default), JC69, K80, F81, F84, TN93, or GTR. For protein, use LG (recommended), WAG, JTT, or MtREV.
*   **Automatic Selection**: Use the Smart Model Selection (SMS) utility if the best-fit model is unknown.
*   **Gamma Distribution**: Use `-c` to specify the number of relative substitution rate categories (default is 4) and `-a` to estimate the gamma shape parameter.

### Topology Search Options
PhyML offers different intensities for searching the tree space:
*   **NNI (Nearest Neighbor Interchanges)**: Fast and efficient; best for very large datasets or initial explorations.
*   **SPR (Subtree Pruning and Regrafting)**: Slower but more thorough; recommended for final tree estimation to avoid local optima.
*   **BEST**: Runs both NNI and SPR and keeps the best result.

```bash
# Use SPR moves for a more thorough search
phyml -i alignment.phy -d nt -s SPR
```

### Branch Support Analysis
*   **Non-parametric Bootstrap**: Specify the number of replicates with `-b <int>`.
*   **aLRT (Approximate Likelihood-Ratio Test)**: A faster alternative to bootstrap. Use `-b -2` for Chi2-based aLRT or `-b -4` for SH-like support.
*   **aBayes**: Use `-b -5` for the aBayes branch support algorithm.

## Expert Tips and Best Practices

*   **Outgroup Handling**: PhyML does not explicitly distinguish between ingroup and outgroup sequences during the search. To properly root a tree, run the analysis with all sequences, then manually root the resulting tree using the designated outgroup in a tree viewer.
*   **Starting Trees**: By default, PhyML uses a BioNJ tree. For difficult topologies, provide a custom starting tree using `-u <tree_file>` or use the `-r` flag to add random starting trees to increase the chance of finding the global maximum likelihood.
*   **Memory and Scale**: While PhyML can process up to 2,000,000 characters, very large alignments should be run with NNI (`-s NNI`) to keep computation times manageable.
*   **Estimating Runtime**: Use the heuristic formula `T^2 * L * A * B * I` where T=Taxa, L=Length, A=Alphabet (1 for NT, 12 for AA), B=Bootstrap/Starts, and I=Improvement (1 for NNI, 4 for SPR) to estimate relative CPU requirements.
*   **Input Formatting**: Ensure the input PHYLIP file is correctly formatted. Interleaved or sequential formats are supported, but "badly formatted input files" are the most common cause of execution failure.

## Reference documentation

- [PhyML Overview](./references/www_atgc-montpellier_fr_phyml.md)
- [PhyML FAQ](./references/www_atgc-montpellier_fr_phyml_faq.php.md)
- [PhyML User Guide](./references/www_atgc-montpellier_fr_phyml_usersguide.php.md)
- [PhyML Benchmarks](./references/www_atgc-montpellier_fr_phyml_benchmarks.md)