---
name: evofold2
description: The `evofold2` tool is a comparative method for predicting RNA secondary structures by combining Stochastic Context-Free Grammars (SCFGs) with phylogenetic models.
homepage: https://github.com/jakob-skou-pedersen/phy
---

# evofold2

## Overview
The `evofold2` tool is a comparative method for predicting RNA secondary structures by combining Stochastic Context-Free Grammars (SCFGs) with phylogenetic models. It analyzes multiple sequence alignments to detect patterns of evolutionary conservation and compensatory mutations that signal functional RNA elements. This skill provides guidance on using the tool within the `phy` library ecosystem to evaluate and train models for RNA structure identification.

## Usage Guidelines

### Core Functionality
`evofold2` operates on the principle that functional RNA structures maintain their base-pairing through evolution. It evaluates the likelihood of an alignment folding into a specific structure versus a background null model.

### Common CLI Patterns
While `evofold2` is the primary application, it relies on the underlying `phy` library tools for model evaluation and training:

*   **Evaluating Alignments**: Use `dfgEval` to calculate the likelihood of a specific DFG (Directed Factor Graph) or SCFG model given an alignment.
    ```bash
    dfgEval --dfgSpecPrefix=/path/to/models/ --ncFile=- alignment_data.tab
    ```
*   **Training Models**: Use `dfgTrain` to optimize model parameters based on known structural alignments.
*   **Input Formats**: The tool typically expects multiple sequence alignments. Ensure your alignments are clean and properly formatted (often in `.tab` or standard MSA formats supported by the `phy` library).

### Expert Tips
*   **Phylogenetic Context**: Since the tool uses phylogenetic models, the quality of the input tree and the evolutionary distance between sequences significantly impact prediction accuracy. Use alignments with a diverse but related set of species.
*   **Model Specification**: The `--dfgSpecPrefix` flag is critical as it points to the directory containing the model specifications (DFGs/SCFGs) that define the RNA structural motifs you are searching for.
*   **Handling Continuous Data**: If working with continuous state maps or mixtures (e.g., Beta or Normal mixtures), ensure your state map parsers are correctly configured as per the `phy` library's PIMPL implementation for StateMaps.

## Reference documentation
- [evofold2 - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_evofold2_overview.md)
- [jakob-skou-pedersen/phy GitHub Repository](./references/github_com_jakob-skou-pedersen_phy.md)
- [phy Wiki - Model Distributions](./references/github_com_jakob-skou-pedersen_phy_wiki.md)