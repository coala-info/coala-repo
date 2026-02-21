---
name: pycomo
description: PyCoMo is a specialized Python package designed to bridge the gap between individual metabolic models and community-scale simulations.
homepage: https://github.com/univieCUBE/PyCoMo
---

# pycomo

## Overview

PyCoMo is a specialized Python package designed to bridge the gap between individual metabolic models and community-scale simulations. It generates compartmentalized community models that allow for two distinct simulation structures: fixed community growth rate with variable member abundance, or fixed abundance profiles with variable growth rates. These models are fully compatible with COBRApy and the SBML format, ensuring that community-level reconstructions remain reusable and attributable to their original members.

## Installation

PyCoMo can be installed via standard Python package managers:

```bash
# Via pip
pip install pycomo

# Via conda
conda install -c conda-forge -c bioconda pycomo
```

## Command Line Interface (CLI) Usage

The primary entry point for the CLI is the `pycomo` command. Use the help flag to explore available subcommands and options:

```bash
pycomo --help
```

### Common CLI Patterns and Tasks

*   **Model Generation**: Use the CLI to combine individual member models into a single community model.
*   **Flux Variability Analysis (FVA)**: Perform FVA to determine the feasible range of fluxes for reactions within the community.
*   **Cross-Feeding Prediction**: Analyze the community model to identify potential metabolite exchanges and interactions between different members.

## Expert Tips and Best Practices

*   **Loopless FVA for Large Communities**: When working with large models (typically >10 members), use the loopless FVA option without loop reaction precomputation. This significantly reduces runtime and avoids numerical instability in complex community structures.
*   **Mass Balance Verification**: Always run mass balance checks on generated community models. Pay particular attention to metabolites without assigned elements, as PyCoMo provides specific warnings for these to ensure simulation accuracy.
*   **Handling Stalls**: For long-running optimizations, utilize the `--restart-on-stall` or timeout flags. Recent updates allow the stall timer to scale with the number of model reactions rather than just target reactions, providing more reliable execution for large-scale models.
*   **Exchange Reaction Focus**: When performing FVA, use the `--only-exchange-reaction` flag if you are primarily interested in community-environment or inter-member interactions. This reduces the computational burden by ignoring internal member reactions.
*   **SBML Compatibility**: Since PyCoMo models are standard COBRApy objects, you can save them as SBML files for use in other metabolic modeling suites or for sharing in public repositories.

## Reference documentation

- [PyCoMo Overview - Anaconda](./references/anaconda_org_channels_bioconda_packages_pycomo_overview.md)
- [PyCoMo GitHub Repository](./references/github_com_univieCUBE_PyCoMo.md)
- [PyCoMo Development History and Features](./references/github_com_univieCUBE_PyCoMo_commits_main.md)