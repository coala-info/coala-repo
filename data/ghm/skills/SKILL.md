---
name: ghm
description: The ghm tool performs parametric linkage analysis by optimizing trait model parameters to maximize LOD scores. Use when user asks to perform MOD-score analysis, optimize trait parameters for complex diseases, or conduct linkage analysis with unknown genetic models.
homepage: https://www.helmholtz-muenchen.de/en/ige/service/software-download/genehunter-modscore/index.html
---


# ghm

## Overview
The `ghm` (Genehunter-Modscore) tool is a specialized extension of the Genehunter software suite. It is designed for parametric linkage analysis where the trait model parameters (such as penetrances and disease allele frequency) are not fixed but are instead optimized to maximize the LOD score. This approach, known as MOD-score analysis, is particularly useful for complex diseases where the underlying genetic model is unknown.

## Installation and Setup
The tool is primarily distributed via the Bioconda channel.
- **Install via Conda**: `conda install bioconda::ghm`
- **Platform Support**: Primarily available for `linux-64`.

## CLI Usage and Best Practices
The `ghm` tool typically operates as a command-line interface that processes pedigree and marker data.

### Core Workflow
1.  **Data Preparation**: Ensure your input files follow the standard Genehunter format (typically `.dat`, `.ped`, and map files).
2.  **Execution**: Run the tool from the terminal to initiate the maximization process.
3.  **Parameter Optimization**: Unlike standard Genehunter, `ghm` will iterate through trait parameters. Ensure your trait file allows for variable parameters if the specific version requires explicit bounds.

### Common CLI Patterns
- **Standard Run**: Execute the binary (often named `ghm` or `genehunter-modscore` depending on the specific build) followed by the input commands or a batch script.
- **Memory Management**: For large pedigrees or dense marker sets, ensure the environment has sufficient RAM, as MOD-score calculations are computationally intensive due to the multi-dimensional optimization.

### Expert Tips
- **Trait Models**: Use `ghm` when you suspect a single major locus but are uncertain about the mode of inheritance (dominant, recessive, or intermediate).
- **LOD vs. MOD**: Remember that MOD-scores are generally higher than standard LOD scores because of the extra degrees of freedom; appropriate significance thresholds (often higher than the traditional 3.0) should be considered.
- **Convergence**: Monitor the output for convergence messages to ensure the maximization algorithm has reached a stable peak in the parameter space.

## Reference documentation
- [ghm - Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ghm_overview.md)
- [Helmholtz Munich - Genehunter-Modscore Home](./references/www_helmholtz-munich_de_index.php.md)