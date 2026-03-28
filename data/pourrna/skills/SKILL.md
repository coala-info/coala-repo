---
name: pourrna
description: pourrna maps RNA energy landscapes by identifying gradient basins and calculating transition rates between local minima. Use when user asks to explore RNA folding pathways, identify local minima, calculate transition rates between basins, or analyze RNA kinetic behavior.
homepage: https://github.com/ViennaRNA/pourRNA/
---

# pourrna

## Overview
The `pourrna` tool is designed for the detailed exploration of RNA energy landscapes. While standard tools often focus solely on the single Minimum Free Energy (MFE) structure, `pourrna` uses a "flooding" algorithm to map out the various peaks and valleys (local minima) of the landscape. It identifies gradient basins—sets of structures that fold into the same local minimum—and calculates the transition rates between these basins. This is essential for understanding RNA switches, folding pathways, and the kinetic behavior of RNA molecules over time.

## Usage Guidelines

### Core Command Line Patterns
The tool is typically invoked via the `pourRNA` executable. It relies on the ViennaRNA library for underlying energy evaluations.

*   **Basic Landscape Exploration**:
    Run the tool with default parameters to identify the primary basins and transition rates for a given sequence.
*   **Controlling Flooding Depth**:
    Use energy thresholds to limit the search space and prevent computational explosion on long sequences.
    *   `--deltaE <value>`: Sets the maximum energy height to flood above each local minimum.
    *   `--maxEnergy <value>`: Sets an absolute energy threshold for the flooding process.
*   **Heuristic Optimization**:
    *   `--dynamicBestK`: Enables a heuristic that automatically adjusts the neighborhood search size (K-value) if the global MFE structure has not yet been discovered in the explored basins.
    *   `--dynamicMaxToHash`: Prevents system memory exhaustion (swapping) by estimating and limiting the hash table size based on sequence length.

### Advanced Analysis Features
*   **Partition Functions**: Use the `partitionFunctions` parameter to write basin-specific partition functions to a file. This data is useful for downstream clustering or calculating the equilibrium probability of being in a specific basin.
*   **Dot Plot Generation**: The tool can generate base pair probability dot plots for specific basins, which can be visualized using standard ViennaRNA tools like `ghostview` or `EPS` viewers.
*   **Temperature Settings**: 
    *   `--boltzmann-temperature`: Specifically sets the temperature used for Boltzmann weight and probability calculations.
    *   Ensure this matches your general energy model temperature for consistency.

### Expert Tips
*   **Turner Model Selection**: Be cautious with the `turner2004` parameter in older versions of ViennaRNA (e.g., 2.1.9), as it may contain inaccuracies. Defaulting to the standard parameters is often safer unless specific version compatibility is confirmed.
*   **Targeted Exploration**: If you are interested in a specific structural state, use the "final structure" parameter to stop the exploration once that specific basin has been fully processed.
*   **Rate Normalization**: When analyzing transition rates, ensure your temperature and dangling ends parameters (`-d0`, `-d1`, `-d2`) are explicitly set to match the experimental conditions you are simulating.



## Subcommands

| Command | Description |
|---------|-------------|
| RNAsubopt | calculate suboptimal secondary structures of RNAs |
| pourrna | Explore RNA energy landscapes |

## Reference documentation
- [pourRNA README](./references/github_com_ViennaRNA_pourRNA_blob_master_README.md)
- [pourRNA ChangeLog (Parameter Details)](./references/github_com_ViennaRNA_pourRNA_blob_master_ChangeLog.md)
- [Bioconda pourrna Overview](./references/anaconda_org_channels_bioconda_packages_pourrna_overview.md)